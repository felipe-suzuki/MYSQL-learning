-- Using the following table definitions and data, write a query that returns 
-- each customer name along with their total payments:

-- Customer:
-- Customer_id 	Name
-- ----------- 	---------------
-- 1 			John Smith
-- 2 			Kathy Jones
-- 3 			Greg Oliver

-- Payment:
-- Payment_id 	Customer_id 	Amount
-- ---------- 	----------- 	--------
-- 101 			1 				8.99
-- 102 			3 				4.99
-- 103 			1 				7.99

-- Include all customers, even if no payment records exist for that customer.
# CREATING THE TABLES FIRST

CREATE TABLE customer_ex10_1 (
	customer_id SMALLINT,
    name VARCHAR(20)
    );

CREATE TABLE payment_ex10_1 (
	payment_id SMALLINT,
    customer_id SMALLINT,
    amount DECIMAL(19,2)
    );
    
INSERT INTO customer_ex10_1 (customer_id, name)
VALUES (1, 'John Smith'),
	(2, 'Kathy Jones'),
	(3, 'Greg Oliver');
    
INSERT INTO payment_ex10_1 (payment_id, customer_id, amount)
VALUES (101, 1, 8.99),
	(102, 3, 4.99),
    (103, 1, 7.99);
    
# QUERY TO ANSWER THE QUESTION
SELECT c.name, sum(p.amount) AS total_payments
FROM customer_ex10_1 AS c
LEFT JOIN payment_ex10_1 AS p
ON c.customer_id = p.customer_id
GROUP BY c.name;