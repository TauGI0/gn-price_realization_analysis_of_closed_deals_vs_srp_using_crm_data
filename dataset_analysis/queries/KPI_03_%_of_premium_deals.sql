-- % Won Deals Above SRP Calculation
-- % Won Above SRP = (Number of Won Deals Priced Above SRP) / (Total Number of Won Deals)

WITH above_srp AS (
    SELECT COUNT(opportunity_id) AS deal_count
    FROM fact_sales_pipeline
    WHERE deal_outcome = 'Won'
        AND price_adjustment_pct > 0
),
won_total AS (
    SELECT COUNT(opportunity_id) AS deal_count
    FROM fact_sales_pipeline
    WHERE deal_outcome = 'Won'
)
SELECT
    above_srp.deal_count::float / won_total.deal_count AS pct_above_srp
FROM won_total
CROSS JOIN above_srp;
