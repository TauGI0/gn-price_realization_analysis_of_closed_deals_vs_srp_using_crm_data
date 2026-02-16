-- Staging table to hold cleaned sales pipeline data before loading and mapping the foreign keys into fact_sales_pipeline

CREATE TABLE stg_sales_pipeline (
    opportunity_id TEXT,
    sales_agent TEXT,
    product TEXT,
    account TEXT,
    deal_outcome TEXT,
    engage_date DATE,
    close_date DATE,
    deal_duration INTEGER,
    deal_duration_bucket_month TEXT,
    close_value NUMERIC(18,2),
    price_adjustment_pct NUMERIC(6,5)
);