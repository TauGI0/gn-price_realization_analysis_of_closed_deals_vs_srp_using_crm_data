# **DAX Measures – Price Realization Analysis**

This document details all DAX measures developed for the Price Realization Analysis dashboard. Measures are scoped to **Won deals only** to ensure Lost deal records — which carry a `closed_value` of 0 by dataset design — do not distort aggregate metrics.

---

## **Rate Metrics**

### **1. Average Price Adjustment % (Won Only)**

Computes the average `price_adjustment_pct` across Won deals. Serves as the north star metric for overall pricing discipline.

#### Measure
```dax
Avg Price Adjustment % (Won Only) = 
CALCULATE(
    AVERAGE('public fact_sales_pipeline'[price_adjustment_pct]),
    'public fact_sales_pipeline'[deal_outcome] = "Won"
)
```

---

### **2. Average Price Adjustment Variance from Target (%)**

Measures the difference between the actual average price adjustment and the target baseline (0%). Returns BLANK when the actual value is zero to avoid misleading indicators.

#### Measure
```dax
Avg Price Adjustment Variance from Target (%) = 
VAR Actual = 'KPI_Measures'[Avg Price Adjustment % (Won Only)]
VAR Target = 'KPI_Measures'[Avg Price Adjustment % Target]
RETURN
IF(
    Actual = 0,
    BLANK(),
    (Actual - Target)
)
```

---

### **3. % Won Deals Above SRP**

Calculates the share of Won deals where `price_adjustment_pct > 0` relative to total Won deals. Used as a KPI indicator for premium pricing behavior.

#### Measure
```dax
% Won Deals Above SRP = 
DIVIDE(
    CALCULATE(
        COUNT('public fact_sales_pipeline'[opportunity_id]),
        'public fact_sales_pipeline'[deal_outcome] = "Won",
        'public fact_sales_pipeline'[price_adjustment_pct] > 0
    ),
    CALCULATE(
        COUNT('public fact_sales_pipeline'[opportunity_id]),
        'public fact_sales_pipeline'[deal_outcome] = "Won"
    )
)
```

---

### **4. % Won Deals Below SRP**

Calculates the share of Won deals where `price_adjustment_pct < 0` relative to total Won deals. Used as a KPI indicator for discounting behavior and margin leakage.

#### Measure
```dax
% Won Deals Below SRP = 
DIVIDE(
    CALCULATE(
        COUNT('public fact_sales_pipeline'[opportunity_id]),
        'public fact_sales_pipeline'[deal_outcome] = "Won",
        'public fact_sales_pipeline'[price_adjustment_pct] < 0
    ),
    CALCULATE(
        COUNT('public fact_sales_pipeline'[opportunity_id]),
        'public fact_sales_pipeline'[deal_outcome] = "Won"
    )
)
```

> **Note:** The remaining ~2% of Won deals closed exactly at SRP (`price_adjustment_pct = 0`) are excluded from both measures. The three segments sum to 100%: 48.14% above, 50.33% below, and ~2% at SRP.

---

### **5. Won Deals Above SRP**

Raw count of Won deals closed above SRP. Formatted with a supporting label for KPI card display.

#### Measure
```dax
Won Deals Above SRP = 
CALCULATE(
    COUNT('public fact_sales_pipeline'[opportunity_id]),
    'public fact_sales_pipeline'[deal_outcome] = "Won",
    'public fact_sales_pipeline'[price_adjustment_pct] > 0
) & " " & "Premium Deals"
```

---

### **6. Won Deals Below SRP**

Raw count of Won deals closed below SRP. Formatted with a supporting label for KPI card display.

#### Measure
```dax
Won Deals Below SRP = 
CALCULATE(
    COUNT('public fact_sales_pipeline'[opportunity_id]),
    'public fact_sales_pipeline'[deal_outcome] = "Won",
    'public fact_sales_pipeline'[price_adjustment_pct] < 0
) & " " & "Discounted Deals"
```

---

## **Revenue Metrics**

### **7. Total Revenue**

Sums `close_value` across all deals. Used as the realized revenue figure in the dashboard.

#### Measure
```dax
Total Revenue = 
SUM('public fact_sales_pipeline'[close_value])
```

---

### **8. Total Revenue (Target)**

Computes SRP-implied revenue by iterating over Won deals and looking up each product's `sales_price` from the products dimension table. Serves as the baseline for revenue variance analysis.

#### Measure
```dax
Total Revenue (Target) = 
CALCULATE(
    SUMX(
        'public fact_sales_pipeline',
        RELATED('public dim_products'[sales_price])
    ),
    'public fact_sales_pipeline'[deal_outcome] = "Won"
)
```

---

### **9. Total Revenue Variance (%)**

Measures the percentage difference between realized revenue and SRP-implied revenue. Surfaced as a KPI indicator to quantify margin leakage at the portfolio and agent level.

#### Measure
```dax
Total Revenue Variance (%) = 
VAR Actual = [Total Revenue]
VAR Target = [Total Revenue (Target)]
RETURN
DIVIDE(Actual - Target, Target)
```

---

All measures were validated against SQL-based results from Section 3.5 to ensure consistency and correctness prior to dashboard publication.