SELECT COUNT(*) AS unref_product_count
FROM dim_products dim
LEFT JOIN fact_sales_pipeline fct
	ON dim.product_id = fct.product_id
WHERE fct.product_id IS NULL;

