SELECT dim.sales_agent
FROM dim_sales_teams dim
LEFT JOIN fact_sales_pipeline fct
  ON fct.agent_id = dim.agent_id
WHERE fct.agent_id IS NULL;
