-- Compute average price adjustment percentage by product
-- Lost deals are excluded because their closed_value = 0 by design
-- and would distort average pricing results

SELECT 
    dim.product_id,
    dim.product,
    AVG(price_adjustment_pct) AS avg_price_adjustment
FROM fact_sales_pipeline fct

-- Join dimension table to retrieve product id and name
LEFT JOIN dim_products dim
    ON fct.product_id = dim.product_id

-- Restrict to realized deals only
WHERE deal_outcome = 'Won'

-- Aggregate pricing performance per product
GROUP BY dim.product_id, dim.product_id

-- Rank products from highest premium pricing to highest discounting
ORDER BY avg_price_adjustment DESC;
