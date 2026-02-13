# Price Realization Analysis of Closed Deals Using CRM Sales Data

*This project evaluates pricing discipline by comparing actual won opportunity closed value against suggested retail pricing (SRP). The analysis examines pricing performance across sales representatives, products, and deal duration to identify key drivers of discounting and premium pricing.*

**Prepared by:** Gio Noga  
**Date:** December 2025 

**Dataset Source:** [CRM🚀 + Sales📊 + Opportunities🔖](https://www.kaggle.com/datasets/innocentmfa/crm-sales-opportunities)

---

## 1. Objective

### 1.1 Business Problem

Sales leadership currently has limited visibility into how actual won opportunity prices compare to suggested retail pricing. This gap makes it difficult to assess pricing discipline, identify margin leakage, and understand where discounting or premium pricing behaviors occur.

This analysis focuses exclusively on **closed opportunities** to ensure insights are based on realized revenue rather than pipeline or lost deals.

### 1.1 Key Business Questions

1. How does pricing performance vary across sales representatives relative to suggested retail pricing (SRP)?
2. Are certain products more likely to be sold at a premium or at a discount relative to SRP?
3. Does deal duration influence pricing outcomes, such as increased discounting or premium pricing?

---

## 2. Scope and Limitations

1. Analysis includes only Closed-Won and Closed-Lost opportunities  
2. External market factors are not considered  
3. SRP accuracy is assumed consistent across products

---

## 3. Methodology

### 3.1 Data Validation  

Before performing any cleaning operations, the dataset was reviewed to assess its overall quality and identify issues requiring correction.  

A full walkthrough of the initial validation process is available here:  
**[Detailed Validation Steps – Data Quality Check](https://github.com/TauGI0/gn-price_realization_analysis_of_closed_deals_vs_srp_using_crm_data/tree/master/dataset_validation/data_quality_check)**  

**Key findings:**  

- Multiple text columns contained inconsistent capitalization (e.g., values not starting with uppercase letters).  
- Several spelling errors were identified in key categorical fields such as sector and office location.  
- Product names showed formatting inconsistencies (e.g., missing spaces between words).  

These findings guided the subsequent data-cleaning procedures.  

After the cleaning process, a second round of validation was conducted to verify the relational integrity between the fact and dimension tables.  

A full walkthrough of this validation process is available here:  
**[Detailed Validation Steps – Relational Integrity Check](https://github.com/TauGI0/gn-price_realization_analysis_of_closed_deals_vs_srp_using_crm_data/blob/master/dataset_validation/relational_integrety_check/sql_validation.md)**  

**Key findings:**  

- No orphaned foreign keys were found in the fact table.  
- Five (5) agents were identified with no corresponding records in the cleaned fact table (closed deals only).

### 3.2 Data Cleaning

--- 



