CREATE TABLE fact_sales_pipeline (
    opportunity_id TEXT PRIMARY KEY,

    -- Foreign keys to dimension tables
    agent_id BIGINT NOT NULL REFERENCES dim_sales_teams(agent_id),
    product_id BIGINT NOT NULL REFERENCES dim_products(product_id),
    account_id BIGINT NOT NULL REFERENCES dim_accounts(id),

    -- Fact attributes
    deal_outcome TEXT,
    engage_date DATE,
    close_date DATE,
    deal_duration INTEGER,
    deal_duration_bucket_month TEXT,
    close_value NUMERIC(18,2),
    price_adjustment_pct NUMERIC(6,5)
);


INSERT INTO fact_sales_pipeline (
    opportunity_id,
    agent_id,
    product_id,
    account_id,
    deal_outcome,
    engage_date,
    close_date,
    deal_duration,
    deal_duration_bucket_month,
    close_value,
    price_adjustment_pct
)
SELECT
    s.opportunity_id,
    a.agent_id,
    p.product_id,
    ac.account_id,
    s.deal_outcome,
    s.engage_date,
    s.close_date,
    s.deal_duration,
    s.deal_duration_bucket_month,
    s.close_value,
    s.price_adjustment_pct
FROM stg_sales_pipeline s
JOIN dim_sales_teams a ON s.sales_agent = a.sales_agent
JOIN dim_products p ON s.product = p.product
JOIN dim_accounts ac ON s.account = ac.account;