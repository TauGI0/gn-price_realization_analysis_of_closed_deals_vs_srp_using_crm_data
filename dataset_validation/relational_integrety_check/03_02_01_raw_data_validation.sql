SELECT raw.sales_agent AS agent_raw, dim.*
FROM raw_sales_pipeline raw
RIGHT JOIN dim_sales_teams dim
  ON raw.sales_agent = dim.sales_agent
WHERE raw.sales_agent IS NULL;
