SELECT (CAST(COUNT(*) AS DECIMAL) /
	(SELECT COUNT (*)
		FROM fact_sales_pipeline)) AS win_rate
FROM fact_sales_pipeline
WHERE deal_outcome = 'Won';

