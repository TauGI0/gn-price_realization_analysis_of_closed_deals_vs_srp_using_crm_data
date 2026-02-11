SELECT COUNT(*) AS unref_account_count
FROM dim_accounts dim
LEFT JOIN fact_sales_pipeline fct
	ON dim.account_id = fct.account_id
WHERE fct.account_id IS NULL;
