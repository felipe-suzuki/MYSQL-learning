-- Reformulate your query from Exercise 10-1 to use the other outer join type (e.g., if
-- you used a left outer join in Exercise 10-1, use a right outer join this time) such that
-- the results are identical to Exercise 10-1.

SELECT c.name, sum(p.amount) AS total_payments
FROM payment_ex10_1 AS p
RIGHT JOIN customer_ex10_1 AS c
ON  p.customer_id = c.customer_id
GROUP BY c.name;