SELECT COUNT(*) AS orphan_account_rows
FROM fact_sales_pipeline fct
LEFT JOIN dim_accounts dim
	ON fct.account_id = dim.account_id
WHERE dim.account_id IS NULL;

