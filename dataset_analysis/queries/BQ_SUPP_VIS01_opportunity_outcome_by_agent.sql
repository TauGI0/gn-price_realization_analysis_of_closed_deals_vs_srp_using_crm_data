-- Supporting visual: total opportunities handled by each sales agent
-- Split into Won and Lost deals for outcome comparison

SELECT dim.agent_id,
	   dim.sales_agent,
	   COUNT (*) AS deal_handled,
	   COUNT (*) FILTER (WHERE deal_outcome = 'Won') AS won_deal,
	   COUNT (*) FILTER (WHERE deal_outcome = 'Lost') AS lost_deal
FROM fact_sales_pipeline fct
JOIN dim_sales_teams dim
	ON fct.agent_id = dim.agent_id
GROUP BY dim.agent_id, dim.sales_agent
ORDER BY won_deal DESC;
