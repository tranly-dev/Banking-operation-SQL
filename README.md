# Banking Operation Analysis
### Understanding Long-Booking Window with No Deposit policy (2021 - 2025)

- **Author**: Tran Ngo Quang Ly  
- **Date**: 9/2025  
- **Tools Used**: Python, SQL, Power BI  

 ◦ Python: Pandas, Matplotlib, Seaborn, Scikit-learn, Datetime  
 ◦ SQL: CTEs, Window Functions, Joins, Aggregate functions  
 ◦ Power BI: DAX, Calculated columns & measures, Data modeling, Interactive dashboard  

---
#### Business Problem  
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

#### Project Objective  
Build **one unified Banking Operations Dashboard** that instantly answers the most critical questions:

- How much new funding was mobilized today/last month? How is CASA trending?
- Current loan portfolio size and breakdown by regulatory purpose & industry
- Which branches/regions deliver the best CASA and highest-quality lending?
- Top cross-sell opportunities (high deposits + no loans | high loans + low CASA)
- Real NIM performance and trend over time

**Dataset**: 540+ customers • 426 credit contracts • 38,000+ CASA transactions • Full branch network & regulatory classifications

---

### Key Features & Insights (Preview)
- Real-time CASA ratio & deposit growth tracking
- Regulatory credit breakdown (Real-estate business, Consumer, Securities, etc.)
- Branch & regional performance ranking
- Customer 360° view with cross-sell scoring
- Net Interest Margin (NIM) calculation and trend analysis
- Collateral quality analysis (Real estate vs Paper vs Unsecured)
