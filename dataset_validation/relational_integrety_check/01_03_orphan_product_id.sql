SELECT COUNT(*) AS orphan_product_rows
FROM fact_sales_pipeline fct
LEFT JOIN dim_products dim
	ON fct.product_id = dim.product_id
WHERE dim.product_id IS NULL;

