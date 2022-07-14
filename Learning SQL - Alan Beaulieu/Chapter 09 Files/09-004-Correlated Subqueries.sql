-- Correlated Subqueries -------------------------------------------
-- All of the subqueries shown thus far have been independent of their containing statements,
-- meaning that you can execute them by themselves and inspect the results. 
-- A correlated subquery, on the other hand, is dependent on its containing statement from
-- which it references one or more columns. 

-- For example, the following query uses a correlated subquery to count the
-- number of film rentals for each customer, and the containing query then 
-- retrieves those customers who have rented exactly 20 films:
SELECT 
    c.first_name, c.last_name
FROM
    customer AS c
WHERE
    20 = (SELECT 
            COUNT(*)
        FROM
            rental AS r
        WHERE
            r.customer_id = c.customer_id);

-- The reference to c.customer_id at the very end of the subquery is what makes the
-- subquery correlated; the containing query must supply values for c.customer_id for
-- the subquery to execute.

-- Along with equality conditions, you can use correlated subqueries in other types of
-- conditions, such as the range condition illustrated here:
SELECT 
    c.first_name, c.last_name
FROM
    customer AS c
WHERE
    (SELECT 
            SUM(p.amount)
        FROM
            payment AS p
        WHERE
            p.customer_id = c.customer_id) BETWEEN 180 AND 240;