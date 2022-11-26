-- Subqueries --
-- A subquery is a query contained within another SQL statement. A subquery is always enclosed
-- within parentheses, and it is usually executed prior to the containing statement.

# Here’s a simple example to get started:
SELECT 
    customer_id, first_name, last_name
FROM
    customer
WHERE
    customer_id = (SELECT 
            MAX(customer_id)
        FROM
            customer);
-- The subquery returns the maximum value found in the customer_id
-- column in the customer table, and the containing statement then 
-- returns data about that customer.