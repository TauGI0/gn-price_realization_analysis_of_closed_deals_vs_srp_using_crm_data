-- Average Price Adjustment Percentage for Won Deals
-- Lost deals excluded to avoid distorting the metric

SELECT AVG(price_adjustment_pct) AS avg_price_adjustment_pct
FROM fact_sales_pipeline
WHERE deal_outcome = 'Won';

