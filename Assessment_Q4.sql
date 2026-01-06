-- Customer Lifetime Value (CLV) Estimation--
	-- CTE 1 customer_metrics --
WITH customer_metrics AS (
	SELECT u.id AS customer_id,
		-- Concat first_name and last_name as name --
    CONCAT(u.first_name, " ", u.last_name) AS name,
		-- counts the month difference between date_joined and current_date--
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_month,
		-- Counts total_transactions of each customers--
    COUNT(s.id) AS total_transaction,
		-- Coalesce converts NULL to 0-- 
    COALESCE(SUM(s.confirmed_amount), 0) AS total_transaction_value,
    COALESCE(AVG(s.confirmed_amount), 0) AS avg_transaction_value
		-- LEFT JOIN with users_customuser as Anchor Table --
    FROM users_customuser u
    LEFT JOIN savings_savingsaccount s
		ON u.id = s.owner_id
    GROUP BY customer_id, name, tenure_month
),
	-- CTE 2 clv_calculation --
clv_calculation AS (
	SELECT customer_id,
		name,
		tenure_month,
		total_transaction,
		total_transaction_value,
		avg_transaction_value * 0.001 AS avg_profit_per_transaction,
			-- Excludes zero values from calculation; but returns 0 if the value is zero--
		CASE
			WHEN tenure_month > 0 THEN
				(total_transaction / tenure_month) * 12 * (avg_transaction_value * 0.001)
			ELSE 0
		END AS estimated_clv
	FROM customer_metrics
)
SELECT customer_id,
		name,
		tenure_month,
		total_transaction,
			-- formats estimated_clv to comma-separated thousands and 2 decimal place--
        FORMAT(estimated_clv, 2)
FROM clv_calculation
ORDER BY estimated_clv DESC;