# Division-by-Zero Errors
-- To safeguard your calculations from encountering errors or, even worse, from being
-- mysteriously set to null, you should wrap all denominators in conditional logic, as
-- demonstrated by the following:
SELECT c.first_name, c.last_name,
sum(p.amount) AS tot_payment_amt,
count(p.amount) AS num_payments,
sum(p.amount) /
CASE 
	WHEN count(p.amount) = 0 THEN 1
	ELSE count(p.amount)
END AS avg_payment
FROM customer AS c
LEFT OUTER JOIN payment AS p
	ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name;