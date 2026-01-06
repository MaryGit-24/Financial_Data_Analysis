/* High-Value Customers with Multiple Products */

SELECT p.owner_id,
		-- Concat first_name and last_name as name --
	concat(u.first_name, ' ', u.last_name) AS name,
		-- counts when is_regular_savings = 1 --
	COUNT(CASE WHEN p.is_regular_savings = 1 THEN 1 END) AS savings_count,
		-- counts when is_a_fund = 1 --
    COUNT(CASE WHEN p.is_a_fund = 1 THEN 1 END) AS investment_count,
		-- formats total_deposit to comma-separated thousands and 2 decimal place--
    FORMAT(SUM(s.confirmed_amount), 2) AS total_deposit
    -- LEFT JOIN with plans_plan as Anchor Table --
FROM plans_plan p
LEFT JOIN savings_savingsaccount s
	ON p.id = s.plan_id
	-- multiple joins with savings_savingsaccount and users_customuser tables --
JOIN users_customuser u
	ON u.id = p.owner_id
    -- is_deleted = 0 is for active plans --
WHERE p.is_deleted = 0
GROUP BY p.owner_id, u.name
	-- only counts when savings and investment count is greater than 1 --
HAVING savings_count > 0
	AND investment_count > 0
ORDER BY total_deposit DESC;