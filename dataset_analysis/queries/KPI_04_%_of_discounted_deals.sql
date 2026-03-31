-- % Won Deals Below SRP Calculation
-- % Won Below SRP = (Number of Won Deals Priced Below SRP) / (Total Number of Won Deals)

WITH below_srp AS (
    SELECT COUNT(opportunity_id) AS deal_count
    FROM fact_sales_pipeline
    WHERE deal_outcome = 'Won'
        AND price_adjustment_pct < 0
),
won_total AS (
    SELECT COUNT(opportunity_id) AS deal_count
    FROM fact_sales_pipeline
    WHERE deal_outcome = 'Won'
)
SELECT
    below_srp.deal_count::float / won_total.deal_count AS pct_below_srp
FROM won_total
CROSS JOIN below_srp;