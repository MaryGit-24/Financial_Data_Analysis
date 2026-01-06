-- Account Inactivity Alert--

SELECT s.plan_id,
	p.owner_id,
		-- Categorizing types to 'Savings', 'Investments', 'Others--
	CASE 
		WHEN p.is_regular_savings = 1 THEN "Savings"
		WHEN p.is_a_fund = 1 THEN "Investments"
        ELSE "Others"
	END AS type,
		-- Last_transaction_date
    MAX(s.transaction_date) AS last_transaction_date,
		-- Datediff minus lats_transaction_date from current_date to get inactivity date--
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_day
    -- LEFT JOIN with savings_savingsaccount as Anchor Table --
FROM savings_savingsaccount s
LEFT JOIN plans_plan p
	ON p.id = s.plan_id
    -- is_deleted = 0 is for active plans --
WHERE p.is_deleted = 0
GROUP BY plan_id, owner_id, type
	-- Returns account without transactions in the last year & accounts with no transaction--
HAVING last_transaction_date < (CURDATE() - INTERVAL 365 DAY)
OR last_transaction_date IS NULL
ORDER BY inactivity_day ASC;