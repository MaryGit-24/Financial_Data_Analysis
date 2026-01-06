/* Transaction Frequency Analysis */
	-- CTE 1 customer frequency --
WITH customer_frequency AS (
	SELECT owner_id AS customer_id,
    transaction_date AS transactions_date,
    id AS transaction_id
    FROM savings_savingsaccount
),
	-- CTE 2 customer_analysis --
customer_analysis AS (
	SELECT customer_id,
		-- counts unique transaction_id--
    COUNT(transaction_id) AS transaction_count,
		-- first_transaction_date--
    MIN(transactions_date) AS first_tx_date,
		-- last_transaction_date--
    MAX(transactions_date) AS last_tx_date
	FROM customer_frequency
    GROUP BY customer_id
),
	-- CTE 3 customer_activity --
customer_activity AS (
	SELECT customer_id, transaction_count,
			-- +1 ensure first active month is included--
		TIMESTAMPDIFF(MONTH, first_tx_date, last_tx_date) + 1 AS month_active,
        transaction_count / (TIMESTAMPDIFF(MONTH, first_tx_date, last_tx_date) + 1) AS transactions_no_per_month
    FROM customer_analysis
),
	-- CTE 4 customer_category --
customer_category AS (
	SELECT customer_id, transactions_no_per_month,
		CASE
				-- High Frequency >= 10--
			WHEN transactions_no_per_month >= 10 THEN "High Frequency"
				-- Medium Frequency between 3 and 9--
            WHEN transactions_no_per_month BETWEEN 3 AND 9 THEN "Medium Frequency"
				-- When above logic do not apply; Low Frequency--
            ELSE "Low Frequency"
            END AS frequency_category
	FROM customer_activity
)
SELECT frequency_category,
		-- counts number of customers in each frequency_category--
	COUNT(*) AS customer_count,
		-- Rounds avg_transaction_no_per_month to 2 decimal place--
    ROUND(AVG(transactions_no_per_month), 2) AS avg_transaction_no_per_month
FROM customer_category
GROUP BY frequency_category
ORDER BY customer_count ASC;