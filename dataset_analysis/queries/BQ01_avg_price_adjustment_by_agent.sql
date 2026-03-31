-- Compute average price adjustment percentage by sales agent
-- Lost deals are excluded because their closed_value = 0 by design
-- and would distort average pricing results

SELECT 
    dim.agent_id,
    dim.sales_agent,
    AVG(price_adjustment_pct) AS avg_price_adjustment
FROM fact_sales_pipeline fct

-- Join dimension table to retrieve agent id and name
LEFT JOIN dim_sales_teams dim
    ON fct.agent_id = dim.agent_id

-- Restrict to realized deals only
WHERE deal_outcome = 'Won'

-- Aggregate pricing performance per agent
GROUP BY dim.agent_id, dim.sales_agent

-- Rank agents from highest premium pricing to highest discounting
ORDER BY avg_price_adjustment DESC;
