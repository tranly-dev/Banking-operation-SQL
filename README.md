# 📌 Banking Operation Analysis
## 🏨 Understanding Long-Booking Window with No Deposit policy (2021 - 2025)

- **Author**: Tran Ngo Quang Ly  
- **Date**: 9/2025  
- **Tools Used**: Python, SQL, Power BI  

 ◦ Python: Pandas, Matplotlib, Seaborn, Scikit-learn, Datetime  
 ◦ SQL: CTEs, Window Functions, Joins, Aggregate functions  
 ◦ Power BI: DAX, Calculated columns & measures, Data modeling, Interactive dashboard  

---
### 📖 Background:
- This dataset represents **real operational data** from a **mid-sized Vietnamese commercial bank** during the high-growth period **2023–2025** — a time when Vietnamese banks aggressively expanded both funding and lending amid rising interest rates and stricter SBV regulations.
- The bank operates **68 branches/POS** across all 8 economic regions, serving **540+ customers** (retail + SME + corporate), with:
  - Over **38,000 CASA transactions**
  - More than **426 active credit contracts** (total outstanding ~VND 2.5 trillion)
  - Full regulatory classifications: credit purpose (per Circular 41/2021), economic sector (QĐ 27/2018), collateral type, customer segment
- However, like many Vietnamese banks at that time, the bank was facing critical operational challenges:
  - **CASA ratio stuck below 25%** while competitors aggressively pushed digital onboarding
  - **Rapid credit growth** but heavy exposure to real-estate-related lending → increasing regulatory scrutiny
  - **Data scattered across 20+ CSV files** maintained by different departments → no single source of truth
  - **Relationship managers had no tool** to quickly spot cross-sell opportunities or monitor VIP client health
### 📚 Business Problem  
Leadership and business units face four critical challenges that require accurate, real-time answers:

1. **Slow deposit growth & high cost of funds**  
   → Low CASA ratio, heavy reliance on long-term fixed deposits → NIM under pressure  
   → No visibility into which branches/regions/products drive CASA performance

2. **Credit growth quality not fully controlled**  
   → Loan book grows fast, but structure is unclear: How much is real-estate business lending? Consumer? Securities? Unsecured?  
   → Concentration risk by industry, purpose, and collateral type is not proactively monitored

3. **No single source of truth across the bank**  
   → Each department uses separate Excel files → numbers differ 5-10% in management meetings  
   → Lack of an interactive enterprise-wide dashboard with drill-down capability

4. **Limited cross-sell and VIP customer management**  
   → Relationship managers cannot instantly identify high-potential customers  
   → Missing a true Customer 360° view for targeted offers and retention

5. **Credit & Risk**  
- Full loan portfolio breakdown by regulatory purpose, industry (QĐ 27), collateral type  
- **Customer segmentation** (Retail, SME, Corporate, VIP, Priority)  
- **Debt group classification** (Nhóm 1–5 according to Circular 02/2017 & 11/2021)  
- **Overdue payment analysis** – late payment amounts, number of overdue days, overdue customers  
- Aging report & early warning signals  

6. **Profitability**  
- **Weighted average lending rate** (lãi suất cho vay bình quân)  
- Net Interest Margin (NIM) calculation & trend  
- Interest income/expense forecasting

###🎯 Project Objective  
Build **one unified Banking Operations Dashboard** that instantly answers the most critical questions:

- How much new funding was mobilized today/last month? How is CASA trending?
- Current loan portfolio size and breakdown by regulatory purpose & industry
- Which branches/regions deliver the best CASA and highest-quality lending?
- Top cross-sell opportunities (high deposits + no loans | high loans + low CASA)
- Real NIM performance and trend over time

**Dataset**: 540+ customers • 426 credit contracts • 38,000+ CASA transactions • Full branch network & regulatory classifications

---

###💡 Key Features & Insights (Preview)
- Real-time CASA ratio & deposit growth tracking
- Regulatory credit breakdown (Real-estate business, Consumer, Securities, etc.)
- Branch & regional performance ranking
- Customer 360° view with cross-sell scoring
- Net Interest Margin (NIM) calculation and trend analysis
- Collateral quality analysis (Real estate vs Paper vs Unsecured)

## 🚀 Dataset Description

### 🗂️ Data Source:
- **Source**:  
  ◦ Internal core-banking & reporting system of a mid-sized Vietnamese commercial bank  
  ◦ Real transactional + master data (anonymized)  
- **Size**:  
  ◦ 20+ raw CSV files  
  ◦ > 540 customers (retail + SME + corporate)  
  ◦ > 38,000 CASA transactions  
  ◦ > 426 active credit contracts  
  ◦ > 68 branches/transaction offices across 8 economic regions  
- **Format**: CSV (UTF-8)  
- **Time period**: 2023 – 2025 (latest available snapshot: Nov 2025)

### Key Tables Included
| Table                              | Rows       | Description                                           |
|------------------------------------|------------|-------------------------------------------------------|
| `Khach_Hang.xlsx`                  | ~540       | Customer master (CIF, segment, industry, branch)      |
| `Tiengui_Thanhtoan.csv`            | ~38,000    | CASA daily transactions & balances                    |
| `Tien_guicokyhan.csv`              | ~186       | Term deposits (fixed maturity)                        |
| `Tiengui_Tietkiem.csv`             | ~380       | Savings deposits (flexible, Thần Tài, Ong Vàng…)      |
| `Hop_dong_tindung.csv`             | 426        | All active loan contracts (amount, rate, purpose…)   |
| `Taisan_baodam.csv`                | ~300       | Collateral registry (real estate, paper, unsecured)  |
| `MaChiNhanh.csv` + `ThanhPho.csv`  | 68 + 64    | Full branch & province hierarchy                      |
| Reference tables                   | 15+ files  | Product catalog, economic sector (QĐ 27), credit purpose (Circular 41), etc. |

---

