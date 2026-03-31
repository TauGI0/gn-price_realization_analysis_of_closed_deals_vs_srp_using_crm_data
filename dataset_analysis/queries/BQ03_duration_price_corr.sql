-- Compute correlation between deal duration and price adjustment for Won deals only
-- Lost deals excluded to avoid distorting the metric

-- Interpretation:
--   - Value near 0 → no meaningful linear correlation
--   - Positive → longer deals tend to close at a premium
--   - Negative → longer deals tend to have higher discounting

SELECT 
    CORR(deal_duration, price_adjustment_pct) AS duration_price_corr
FROM fact_sales_pipeline
WHERE deal_outcome = 'Won';
