SELECT COUNT(*) AS orphan_agent_rows
FROM fact_sales_pipeline fct
LEFT JOIN dim_sales_teams dim 
	ON fct.agent_id = dim.agent_id
WHERE dim.agent_id IS NULL;


