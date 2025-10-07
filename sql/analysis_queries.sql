/* ============================================================
   analysis_queries.sql
   Banking Operations – SQL (SQL Server)

   Mục tiêu:
   1) Quy mô tiền gửi theo năm/quý
   2) Lãi suất BQ gia quyền theo Chi nhánh & Năm
   3) Top 3 khách hàng năm 2024 (theo tổng số tiền mở sổ)
   4) Forecast đáo hạn Q1/2025 (kèm days_to_maturity & bucket)
   5) Snapshot danh mục sổ còn hiệu lực tại mốc ngày Cutoff
   6) Tóm tắt tín dụng theo nhóm kỳ hạn (ngắn/trung/dài)
   7) Tỷ lệ bao phủ TS bảo đảm so với dư nợ (ước lượng)
   ------------------------------------------------------------
   Giả định các bảng:
     - KHACH_HANG(MA_KH, TEN_KH, MA_CN, MA_TP, ...)
     - MA_CHINHANH(MA_CN, TEN_CN, MA_KHUVUC, ...)
     - TIENGUI_TIETKIEM(MA_SO, MA_KH, NGAY_MO_SO, NGAY_DAOHAN, SOTIEN_GUI, LAISUAT)
     - HOPDONG_TINDUNG(MA_HOPDONG, MA_KH, SOTIEN_GIAINGAN, NGAY_HOPDONG, NGAY_DAOHAN, LAISUAT)
     - TAISAN_BAODAM(MA_TS, MA_KH, LOAI_TS, GIATRI_TS)
   ============================================================*/

SET NOCOUNT ON;

/* ========= 0) BIẾN THAM SỐ DÙNG CHUNG ========== */
DECLARE @Year_Target INT = 2024;
DECLARE @Forecast_From DATE = '2025-01-01';
DECLARE @Forecast_To   DATE = '2025-04-01';   -- exclusive
DECLARE @Cutoff_Date   DATE = GETDATE();      -- mốc tính hiện trạng

/* ========= 1) QUY MÔ TIỀN GỬI THEO NĂM / QUÝ ==========
   Tổng số tiền mở sổ (SOTIEN_GUI) quy đổi theo ngày mở sổ
*/
;WITH base AS (
  SELECT
      YEAR(NGAY_MO_SO)  AS y,
      DATEPART(QUARTER, NGAY_MO_SO) AS q,
      SOTIEN_GUI
  FROM dbo.TIENGUI_TIETKIEM
)
SELECT
    y AS Nam,
    q AS Quy,
    SUM(SOTIEN_GUI) AS Tong_SoTien_MoSo
FROM base
GROUP BY y, q
ORDER BY y, q;


/* ========= 2) LÃI SUẤT BQ GIA QUYỀN THEO CHI NHÁNH & NĂM ==========
   Trọng số = SOTIEN_GUI. Ghép KH -> CN để quy về chi nhánh mở sổ.
*/
SELECT
    YEAR(TG.NGAY_MO_SO) AS Nam,
    CN.TEN_CN,
    CAST(SUM(TG.SOTIEN_GUI * TG.LAISUAT) / NULLIF(SUM(TG.SOTIEN_GUI),0) AS DECIMAL(10,4)) AS LaiSuat_BQ_GiaQuyen
FROM dbo.TIENGUI_TIETKIEM TG
JOIN dbo.KHACH_HANG KH ON KH.MA_KH = TG.MA_KH
JOIN dbo.MA_CHINHANH CN ON CN.MA_CN = KH.MA_CN
GROUP BY YEAR(TG.NGAY_MO_SO), CN.TEN_CN
ORDER BY Nam, CN.TEN_CN;


/* ========= 3) TOP 3 KHÁCH HÀNG NĂM @Year_Target ==========
   Tiêu chí: tổng số tiền mở sổ trong năm @Year_Target
*/
;WITH y as (
  SELECT
      TG.MA_KH,
      SUM(TG.SOTIEN_GUI) AS Tong_MoSo_Nam
  FROM dbo.TIENGUI_TIETKIEM TG
  WHERE YEAR(TG.NGAY_MO_SO) = @Year_Target
  GROUP BY TG.MA_KH
),
r AS (
  SELECT
      y.MA_KH, KH.TEN_KH, y.Tong_MoSo_Nam,
      DENSE_RANK() OVER (ORDER BY y.Tong_MoSo_Nam DESC) AS rnk
  FROM y
  JOIN dbo.KHACH_HANG KH ON KH.MA_KH = y.MA_KH
)
SELECT TOP 3 *
FROM r
WHERE rnk <= 3
ORDER BY rnk, Tong_MoSo_Nam DESC;


/* ========= 4) FORECAST ĐÁO HẠN Q1/2025 ==========
   Liệt kê các sổ đáo hạn trong khoảng [@Forecast_From, @Forecast_To)
   + days_to_maturity + bucket theo tháng
*/
SELECT
    TG.MA_SO,
    KH.MA_KH,
    KH.TEN_KH,
    TG.NGAY_DAOHAN,
    TG.SOTIEN_GUI,
    DATEDIFF(DAY, @Cutoff_Date, TG.NGAY_DAOHAN) AS days_to_maturity,
    CONCAT('Th ', MONTH(TG.NGAY_DAOHAN)) AS bucket_month
FROM dbo.TIENGUI_TIETKIEM TG
JOIN dbo.KHACH_HANG KH ON KH.MA_KH = TG.MA_KH
WHERE TG.NGAY_DAOHAN >= @Forecast_From
  AND TG.NGAY_DAOHAN <  @Forecast_To
ORDER BY TG.NGAY_DAOHAN, TG.SOTIEN_GUI DESC;


/* ========= 5) SNAPSHOT DANH MỤC SỔ CÒN HIỆU LỰC TẠI @Cutoff_Date ==========
   Điều kiện: NGAY_MO_SO <= @Cutoff_Date < NGAY_DAOHAN
   (xấp xỉ “đang chạy”)
*/
SELECT
    TG.MA_SO,
    KH.TEN_KH,
    CN.TEN_CN,
    TG.SOTIEN_GUI,
    TG.LAISUAT,
    TG.NGAY_MO_SO,
    TG.NGAY_DAOHAN,
    DATEDIFF(DAY, @Cutoff_Date, TG.NGAY_DAOHAN) AS Days_Remaining
FROM dbo.TIENGUI_TIETKIEM TG
JOIN dbo.KHACH_HANG KH ON KH.MA_KH = TG.MA_KH
JOIN dbo.MA_CHINHANH CN ON CN.MA_CN = KH.MA_CN
WHERE TG.NGAY_MO_SO <= @Cutoff_Date
  AND (@Cutoff_Date < TG.NGAY_DAOHAN)
ORDER BY Days_Remaining ASC;


/* ========= 6) TÓM TẮT TÍN DỤNG THEO NHÓM KỲ HẠN ==========
   Phân loại theo số tháng giữa NGAY_HOPDONG và NGAY_DAOHAN
     <12: Ngắn | 12–60: Trung | >60: Dài
*/
;WITH tenors AS (
  SELECT
      TD.MA_HOPDONG,
      TD.MA_KH,
      TD.SOTIEN_GIAINGAN,
      TD.NGAY_HOPDONG,
      TD.NGAY_DAOHAN,
      DATEDIFF(MONTH, TD.NGAY_HOPDONG, TD.NGAY_DAOHAN) AS tenor_months
  FROM dbo.HOPDONG_TINDUNG TD
)
SELECT
    CASE
      WHEN tenor_months < 12 THEN N'NGẮN'
      WHEN tenor_months BETWEEN 12 AND 60 THEN N'TRUNG'
      ELSE N'DÀI'
    END AS Nhom_KyHan,
    COUNT(*) AS So_HopDong,
    SUM(SOTIEN_GIAINGAN) AS Tong_GiaiNgan
FROM tenors
GROUP BY CASE
      WHEN tenor_months < 12 THEN N'NGẮN'
      WHEN tenor_months BETWEEN 12 AND 60 THEN N'TRUNG'
      ELSE N'DÀI'
    END
ORDER BY Nhom_KyHan;


/* ========= 7) TỶ LỆ BAO PHỦ TÀI SẢN BẢO ĐẢM SO VỚI DƯ NỢ (ƯỚC LƯỢNG) ==========
   Ở đây dùng SOTIEN_GIAINGAN như proxy cho dư nợ (nếu không có bảng dư nợ).
   Nếu bạn có bảng dư nợ thực tế, thay SUM(SOTIEN_GIAINGAN) bằng SUM(DU_NO_CON_LAI).
*/
;WITH loan AS (
  SELECT MA_KH, SUM(SOTIEN_GIAINGAN) AS Tong_GiaiNgan
  FROM dbo.HOPDONG_TINDUNG
  GROUP BY MA_KH
),
col AS (
  SELECT MA_KH, SUM(GIATRI_TS) AS Tong_GiaTri_TSBD
  FROM dbo.TAISAN_BAODAM
  GROUP BY MA_KH
)
SELECT
    KH.MA_KH,
    KH.TEN_KH,
    ISNULL(l.Tong_GiaiNgan,0)    AS Tong_GiaiNgan,
    ISNULL(c.Tong_GiaTri_TSBD,0) AS Tong_GiaTri_TSBD,
    CASE WHEN ISNULL(l.Tong_GiaiNgan,0) = 0 THEN NULL
         ELSE CAST(ISNULL(c.Tong_GiaTri_TSBD,0) / l.Tong_GiaiNgan AS DECIMAL(12,2))
    END AS Coverage_Ratio
FROM dbo.KHACH_HANG KH
LEFT JOIN loan l ON l.MA_KH = KH.MA_KH
LEFT JOIN col  c ON c.MA_KH = KH.MA_KH
ORDER BY Coverage_Ratio DESC, Tong_GiaTri_TSBD DESC;

-- ================== END OF FILE ==================
