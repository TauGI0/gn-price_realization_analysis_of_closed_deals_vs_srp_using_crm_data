-- Total Revenue from Closed Deals
-- Summing close_value for all deals, regardless of outcome, to capture total revenue potential

SELECT SUM(close_value) AS total_revenue
FROM fact_sales_pipeline;


