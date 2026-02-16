-- Interpretation:
--   - Value near 0 → no meaningful linear correlation
--   - Positive → longer deals tend to close at a premium
--   - Negative → longer deals tend to have higher discounting

SELECT 
    CORR(deal_duration, price_adjustment_pct) AS duration_price_corr
FROM fact_sales_pipeline
WHERE deal_outcome = 'Won';
