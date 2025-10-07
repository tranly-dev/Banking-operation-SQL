# 🏦 Banking Operations Analysis – SQL (Vietnam Banking Dataset)

> **A complete SQL-based data analysis project simulating real banking operations:**  
> from customer deposits, savings accounts, and loan contracts to forecasting maturities and ranking top customers.

---

## 💼 Project Overview

This project was built to demonstrate practical **SQL data analysis in a banking context** — focusing on **deposits, maturities, and customer insights**.

The dataset and schema are inspired by real Vietnamese banking systems, including customers, branches, savings accounts, and credit contracts.

### 🔍 Key Objectives
- Design and normalize a **relational database** for banking operations.  
- Write **analytical SQL queries** using `JOIN`, `CTE`, `WINDOW FUNCTIONS`.  
- Forecast upcoming **maturity dates** for savings contracts (early 2025).  
- Identify **Top 3 customers in 2024** by total deposits / net flow.  
- Compute **weighted-average interest rates** by branch & year.  

---

## 🧱 Database Schema

All table creation scripts are stored in [`sql/schema_clean.sql`](./sql/schema_clean.sql).

### 🗂️ Main Tables
| Table | Description |
|--------|--------------|
| `KHACH_HANG` | Customer information (ID, name, DOB, gender, branch, city) |
| `MA_CHINHANH` | Branch codes and regions |
| `TIENGUI_TIETKIEM` | Savings accounts and maturity information |
| `HOPDONG_TINDUNG` | Loan contracts and disbursement data |
| `TAISAN_BAODAM` | Collateral assets linked to customers |
| `MA_KHU_VUC`, `MA_THANHPHO` | Area and city master data |

---

## 📊 ERD Diagram

```mermaid
erDiagram
  MA_LOAIHINH_TSBD {
    int ID
    string MA_LOAI
    string TENLOAI
  }
  MA_KHU_VUC {
    int ID
    string MA_KHUVUC
    string TEN_KHUVUC
  }
  MA_LOAI_HINH_DOANHNGHIEP {
    int ID
    string MA_LOAIHINH
    string TEN_LOAIHINH
  }
  MA_NGANHNGHE {
    int ID
    string MA_NGANH
    string TEN_NGANH
  }
  MA_THANHPHO {
    int ID
    string MA_TP
    string TEN_TP
  }
  MA_CHINHANH {
    int ID
    string MA_CN
    string TEN_CN
    string MA_KHUVUC
  }
  KHACH_HANG {
    int MA_KH
    string TEN_KH
    date NGAYSINH
    string GIOITINH
    string MA_CN
    string MA_TP
  }
  TIENGUI_TIETKIEM {
    int MA_SO
    int MA_KH
    date NGAY_MO_SO
    date NGAY_DAOHAN
    decimal SOTIEN_GUI
    decimal LAISUAT
  }
  HOPDONG_TINDUNG {
    int MA_HOPDONG
    int MA_KH
    decimal SOTIEN_GIAINGAN
    date NGAY_HOPDONG
    date NGAY_DAOHAN
    decimal LAISUAT
  }
  TAISAN_BAODAM {
    int MA_TS
    int MA_KH
    string LOAI_TS
    decimal GIATRI_TS
  }

  KHACH_HANG }o--|| MA_CHINHANH : "thuộc CN"
  KHACH_HANG }o--|| MA_THANHPHO : "ở TP"
  TIENGUI_TIETKIEM }o--|| KHACH_HANG : "thuộc KH"
  HOPDONG_TINDUNG }o--|| KHACH_HANG : "thuộc KH"
  TAISAN_BAODAM }o--|| KHACH_HANG : "thuộc KH"
