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

### 1.2 Key Business Questions

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

### 3.1 Data Quality Check

Before performing any cleaning operations, the dataset was reviewed to assess its overall quality and identify issues requiring correction.  

A full walkthrough of the initial validation process is available here:  
**[Detailed Validation Steps](https://github.com/TauGI0/gn-price_realization_analysis_of_closed_deals_vs_srp_using_crm_data/tree/master/dataset_validation/data_quality_check)**  

**Key findings:**  

- Multiple text columns contained inconsistent capitalization (e.g., values not starting with uppercase letters).  
- Several spelling errors were identified in key categorical fields such as sector and office location.  
- Product names showed formatting inconsistencies (e.g., missing spaces between words).  

These findings guided the subsequent data-cleaning procedures.  

### 3.2 Data Cleaning  

To prepare the dataset for accurate and reliable analysis, structured cleaning procedures were applied to address the issues identified during the validation phase.  

A full walkthrough of the cleaning process is available here:  
**[Detailed Cleaning Steps](https://github.com/TauGI0/gn-price_realization_analysis_of_closed_deals_vs_srp_using_crm_data/tree/master/dataset_cleaning)**  

#### 3.2.1 Standardization of Text Formatting  

To ensure uniform formatting across datasets and eliminate case-sensitivity issues during filtering, grouping, and joins, text values were standardized across both fact and dimension tables.

The following adjustments were made:

- Converted values in the **account** and **sector** columns of the `accounts` dimension table to title case.
- Corrected inconsistent capitalization in the **account** column of the `sales_pipeline` fact table (e.g., *dambase* → *Dambase*).

#### 3.2.2 Correction of Spelling and Formatting Errors  

To improve data accuracy, integrity, and reporting consistency, misspelled and improperly formatted categorical values were corrected in both fact and dimension tables.

Affected fields included:

- **sector** (accounts dimension table)  
- **office_location** (accounts dimension table)  
- **product** (sales_pipeline fact table)  

Examples of corrections:

- *Technolgy* → *Technology*  
- *Philipines* → *Philippines*  
- *GTXPro* → *GTX Pro*  

### 3.3 Data Transformation & Feature Engineering  

After data cleaning, additional transformation and feature engineering steps were performed to prepare the dataset for pricing and sales cycle analysis.  

These included filtering relevant records, standardizing outcome labels, and creating derived metrics in the fact table.

#### 3.3.1 Outcome Standardization and Record Filtering  

- Retained only deals with outcomes **Won** or **Lost**.  
- Renamed `deal_stage` to `deal_outcome` for clarity.  

This ensures only finalized deals are analyzed and avoids distortion from ongoing or undefined stages.

#### 3.3.2 Deal Duration Metrics  

- **deal_duration:** Number of days between `engage_date` and `close_date`.  
- **deal_duration_bucket:** Categorized durations into months for grouped analysis:  
  - 0–1, 2, 3–4, 5+ months  

These metrics support sales cycle analysis and dashboard aggregation.

#### 3.3.3 Price Adjustment Percentage  

- **price_adjustment_pct:** Measures the difference between actual deal value and product SRP:  

> price_adjustment_pct = (closed_value − SRP) / SRP  

- Positive → Sold above SRP  
- Negative → Sold below SRP  
- Zero → Sold at SRP  

This metric is the core variable for analyzing pricing realization.

### 3.4 Data Modeling & Implementation    

After preparing the dataset, a relational database was implemented to support structured storage and analytical queries.

**Key Steps**

- **Database and Tables:** Created fact and dimension tables following a star schema. Fact table stores deal transactions; dimension tables store reference data like products, accounts, and sales team members.  
- **Data Loading:** Datasets were loaded into the respective tables with proper data types and constraints.  
- **Foreign Key Mapping:** String-based keys in the fact table were replaced with surrogate integer keys referencing the dimension tables. This ensures faster joins, consistent references, and referential integrity.

SQL scripts for setting up the database is available here:  
**[Database Table Creation & Foreign Key Mapping](https://github.com/TauGI0/gn-price_realization_analysis_of_closed_deals_vs_srp_using_crm_data/tree/master/database)**

### 3.5 Relational Integrety Check 

After loading the cleaned and transformed datasets into the database, a second round of validation was conducted to verify the relational integrity between the fact and dimension tables.  

Validation scripts is available here:  
**[Relational Integrity Check](https://github.com/TauGI0/gn-price_realization_analysis_of_closed_deals_vs_srp_using_crm_data/blob/master/dataset_validation/relational_integrety_check/sql_validation.md)**  

**Key findings:**  

- No orphaned foreign keys were found in the fact table.  
- All surrogate key mappings in the fact table are consistent with the dimension tables.  
- Referential integrity between fact and dimension tables was successfully enforced.

--- 




