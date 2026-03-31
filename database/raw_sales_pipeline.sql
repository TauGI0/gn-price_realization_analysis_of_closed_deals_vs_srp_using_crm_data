-- Create raw_sales_pipeline table as part of investigation dim_sales_teams records with no corresponding entry in fact_sales_pipeline

CREATE TABLE raw_sales_pipeline (
    opportunity_id TEXT,
    sales_agent TEXT,
    product TEXT,
    account TEXT,
    deal_stage TEXT,
    engage_date DATE,
    close_date DATE,
    close_value NUMERIC(18,2)
)
