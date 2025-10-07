-- Cleaned schema extracted from uploaded SQL (SQL Server compatible)
-- Removed CREATE DATABASE/USE/GO; keep only CREATE TABLE blocks.

create table MA_LOAIHINH_TSBD
(
ID int identity(1,1),
MA_LOAI nvarchar(20),
TENLOAI nvarchar(500) 
)
insert into MA_LOAIHINH_TSBD values		('BDS',		N'Bất động sản');

-- ===== Next Table ===== --

create table MA_KHU_VUC
(
ID				int identity(1,1),
MA_KHUVUC		nvarchar(20),
TEN_KHUVUC		nvarchar(50)
)

insert into MA_KHU_VUC values ('A01',N'HỘI SỞ CHÍNH');

-- ===== Next Table ===== --

create table MA_LOAI_HINH_DOANHNGHIEP
(
ID				int identity(1,1),
MALOAI_DOANHNGHIEP	nvarchar(20),
TENLOAI_DOANHNGHIEP	nvarchar(500)
)

insert into MA_LOAI_HINH_DOANHNGHIEP values ('1',N'Công ty nhà nước');

-- ===== Next Table ===== --

create table MA_NGANHNGHE
(
ID				int identity(1,1),
MA_NGANHNGHE	nvarchar(20),
TEN_NGANHNGHE	nvarchar(500)
)


insert into MA_NGANHNGHE values ('0',	N'Khác');

-- ===== Next Table ===== --

create table MA_THANHPHO
(
ID				int identity(1,1),
TEN_VIETTAT		nvarchar(5),
MA_TP			int,
TEN_THANHPHO	nvarchar(50)
)
insert into MA_THANHPHO values ('SG',79,N'Hồ Chí Minh');

-- ===== Next Table ===== --

create table MA_CHINHANH
(
ID					int identity(1,1),
MA_CHINHANH			nvarchar(20),
TEN_CHINHANH		nvarchar(500),
DIACHI_CHINHANH		nvarchar(max),
MA_THANHPHO			int,
MA_KHUVUC			nvarchar(10)
)

insert into MA_CHINHANH values (N'1302004',N'NH TMCP VNC  - Chi nhánh Đống Đa',N'Tôn Đức Thắng - Đống Đa - HN',1,'A01');

-- ===== Next Table ===== --

create table KHACH_HANG
(
ID				int identity(1,1),
MA_CHINHANH		nvarchar(20),
MA_KHACHHANG	nvarchar(20),
TEN_KHACHHANG	nvarchar(500),
LOAI_KHACHHANG	nvarchar(10),
NGAY_SINH		DATE,
DIA_CHI			nvarchar(max),
SO_CMND			nvarchar(20),
NGAYCAP_CMND	date,
NOI_CAP_CMND	int,
SO_CCCD			nvarchar(20),
NGAYCAP_CCCD	date,
NOI_CAP_CCCD	int,
SO_HOCHIEU		nvarchar(20),
NGAYCAP_HOCHIEU	date,
NOI_CAP_HOCHIEU	int,
MASOTHUE		nvarchar(20),
NGAYCAP_MST		DATE,
NOI_CAP_MST	int,
TEN_CHUDOANHNGHIEP		nvarchar(500),
SO_CMND_CHUDOANHNGHIEP	nvarchar(50),
MA_TAIKHOAN_THANHTOAN	nvarchar(20),
MA_LOAIHINH		nvarchar(20),
MA_NGANHNGHE	nvarchar(20)
);

-- ===== Next Table ===== --

CREATE TABLE TIENGUI_TIETKIEM
(
	ID				INT		IDENTITY(1,1),
	MA_KHACHHANG			NVARCHAR(20),	--> mã khách hàng
	MA_TAIKHOAN_TIETKIEM	NVARCHAR(20),	--> mã tài khoản
	NGAY_GUI		DATE,			--> ngày gửi
	NGAY_DAOHAN		DATE,			--> ngày kết thúc
	LAI_SUAT		NUMERIC(10,2),	--> lãi suất
	SOTIEN			NUMERIC(18,2),	--> số tiền khách gửi
	SOTIEN_LAI		NUMERIC(18,2),	--> số tiền lãi
	TONG_TIEN		NUMERIC(18,2),	--> tổng số tiền khách nhận (= gốc + lãi)
	TU_GIAHAN		INT,			--> tự gia hạn: 0-không tự gia hạn/1- tự gia hạn
	NGAY_TATTOAN	DATE,			--> ngày rút
	TRANG_THAI		INT				---> trạng thái: 0- chưa tất toán/1 - đã tất toán
)

INSERT INTO TIENGUI_TIETKIEM VALUES ('CIF0006435','SAV-000-093','2018-09-22','2020-09-22','8.37','560000000','94000833','654000833','1','2020-09-22','1');

-- ===== Next Table ===== --

CREATE TABLE HOPDONG_TINDUNG
(
ID						INT		IDENTITY(1,1),
MA_KHACHHANG			NVARCHAR(20),
MA_HOPDONG_TINDUNG		NVARCHAR(20),
MA_HOPDONG_THECHAP		NVARCHAR(20),
SO_HOPDONG_TINDUNG				NVARCHAR(MAX),
NGAY_HOPDONG			DATETIME,
SOTIEN_GIAINGAN			NUMERIC(18,2),	
NGAY_DAOHAN				DATETIME,	
LAISUAT					NUMERIC(18,2),
SO_HOPDONG_THECHAP		NVARCHAR(MAX),
NGAY_HOPDONG_THECHAP	DATETIME,
GHI_CHU					NVARCHAR(MAX)

);

-- ===== Next Table ===== --

CREATE TABLE TAISAN_BAODAM
(
ID				INT		IDENTITY(1,1),
MA_TAISAN		NVARCHAR(20),
MA_LOAI			NVARCHAR(20), 
GIATRI_DINHGIA 	NUMERIC(18,2),
DIACHI			NVARCHAR(MAX),
THANHPHO		INT
)

INSERT INTO TAISAN_BAODAM VALUES ('BDS00000322','BDS','4000000000',N'Thôn Ngọc Trục, xã Đại Mỗ, Huyện Từ Liêm, Hà Nội','1');

-- ===== Next Table ===== --

CREATE TABLE HOPDONG_THECHAP_CHITIET
(
	ID					INT		IDENTITY(1,1),
	MA_HOPDONG_THECHAP	NVARCHAR(20),
	MA_HOPDONG_TINDUNG	NVARCHAR(20),
	MA_TAISAN_BAODAM	NVARCHAR(20),
	PHAMVI_BAODAM		NUMERIC(18,0),
	TILE_BAODAM			NUMERIC(18,2)
)

 INSERT INTO HOPDONG_THECHAP_CHITIET VALUES ('HDTC00001171','CTRA001255','BDS00000322','2200000000','54.73');

-- ===== Next Table ===== --

CREATE TABLE KE_HOACH_TRA_NO(
	ID					int identity(1,1),
	MA_KEHOACH			nvarchar(20) NULL,
	MA_HOPDONG_TINDUNG	nvarchar(20) NULL,
	SODU_DAUKI		numeric(18, 0) NULL,
	SO_KY			int NULL,
	NGAY_DAUKI		date NULL,
	NGAY_CUOIKY		date NULL,
	SONGAY_TINHLAI	int NULL,
	LAISUAT			numeric(5, 2) NULL,
	GOC_PHAITRA		numeric(18, 0) NULL,
	LAI_PHAITRA	    numeric(18, 0) NULL,
	TONG_TIEN 		numeric(18, 0) NULL
);

-- ===== Next Table ===== --

CREATE TABLE THUHOINO_KHACHHANG(
	ID				int		IDENTITY(1,1),
	MA_HOPDONG_TINDUNG		nvarchar(20) NULL,
	SO_KY			int NULL,
	NGAY_TRA		date NULL,
	TRA_GOC			numeric(18, 0) NULL,
	TRA_LAI	        numeric(18, 0) NULL
);

-- ===== Next Table ===== --

CREATE TABLE TAIKHOAN_THANHTOAN (
    ID						INT identity(1,1),
    MA_TAIKHOAN_THANHTOAN	NVARCHAR(20),
    THOIGIAN_GIAODICH		DATETIME,
    SODU_BANDAU				NUMERIC(18, 0),
    SOTIEN_TANG				NUMERIC(18, 0),
    SOTIEN_GIAM				NUMERIC(18, 0),
    SODU_SAU				NUMERIC(18, 0),
    LOAITIEN				NVARCHAR(5),
    GHICHU					NVARCHAR(MAX),
    TAIKHOAN_GUI			NVARCHAR(50),
    TAIKHOAN_NHAN			NVARCHAR(50),
    LOAI_CHUYENKHOAN		NVARCHAR(5)
);