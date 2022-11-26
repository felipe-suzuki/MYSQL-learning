-- Modify your query from Exercise 8-2 to include only those customers who have
-- made at least 40 payments.

SELECT 
    customer_id,
    COUNT(*) AS number_payments,
    SUM(amount) AS total_amount
FROM
    payment
GROUP BY customer_id
HAVING COUNT(*) >= 40;