-- Modify your query from Exercise 8-1 to count the number of payments made by each
-- customer. Show the customer ID and the total amount paid for each customer.

SELECT 
    customer_id,
    COUNT(*) AS number_payments,
    SUM(amount) AS total_amount
FROM
    payment
GROUP BY customer_id;