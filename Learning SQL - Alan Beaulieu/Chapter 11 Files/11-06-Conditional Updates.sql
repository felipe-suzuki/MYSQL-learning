# Conditional Updates
-- When updating rows in a table, you sometimes need conditional logic to generate a
-- value for a column. 

-- For example, let’s say that you run a job every week that will set the customer.active 
-- column to 0 for any customers who haven’t rented a film in the last 90 days. 
-- Here’s a statement that will set the value to either 0 or 1 for every customer:
UPDATE customer
SET active =
CASE
	WHEN 90 <= (SELECT datediff(now(), max(rental_date))
	FROM rental AS r
	WHERE r.customer_id = customer.customer_id)
	THEN 0
	ELSE 1
END
WHERE active = 1;