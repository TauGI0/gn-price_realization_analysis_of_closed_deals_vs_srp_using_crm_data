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

These steps focused on:

- Filtering relevant records  
- Standardizing outcome labels  
- Creating derived analytical metrics within the fact table  

#### 3.3.1 Outcome Standardization and Record Filtering  

To ensure analytical consistency:

- The dataset was filtered to retain only deals with outcomes classified as **Won** or **Lost**.
- The `deal_stage` column was renamed to `deal_outcome` for clarity and semantic accuracy.

This ensures that:
- The dataset reflects finalized deal outcomes only.
- Ongoing or undefined stages do not distort pricing and duration analysis.

#### 3.3.2 Deal Duration Calculation  

To measure sales cycle efficiency, a new metric was created:

- **deal_duration**  

This metric calculates the number of days between:
- `engage_date` (deal initiation)
- `close_date` (deal completion)

Duration is computed as:

> deal_duration = close_date − engage_date  

This enables analysis of how long deals take to close.

#### 3.3.3 Deal Duration Bucketing  

To support grouped analysis and visualization, deal duration was further categorized into time-based buckets.

Steps performed:

1. Deal duration (in days) was converted into approximate months.
2. Duration values were grouped into defined ranges.

Bucket structure:

- 0–1 month  
- 2 months  
- 3–4 months  
- 5+ months  

This enables:
- Aggregated performance comparison across deal cycle segments  
- Faster reporting and dashboard summarization  

#### 3.3.4 Price Adjustment Percentage  

To measure pricing discipline and realization performance, a new metric was created:

- **price_adjustment_pct**

This metric compares the actual deal close value against the product’s Suggested Retail Price (SRP).

Calculation logic:

> price_adjustment_pct = (closed_value − SRP) / SRP  

Interpretation:

- Positive value → Sold above SRP (premium pricing)  
- Negative value → Sold below SRP (discounting)  
- Zero → Sold exactly at SRP  

This metric serves as the core variable for the price realization analysis.

--- 



