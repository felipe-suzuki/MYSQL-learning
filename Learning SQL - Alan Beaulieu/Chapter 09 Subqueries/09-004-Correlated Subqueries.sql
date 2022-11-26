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
            
-- The exists Operator --
-- You use the exists operator when you want to identify that a
-- relationship exists without regard for the quantity.

-- The following query finds all the customers who rented at least one 
-- film prior to May 25, 2005, without regard for how many films were rented:
SELECT 
    c.first_name, c.last_name
FROM
    customer AS c
WHERE
    EXISTS( SELECT 
            1
        FROM
            rental AS r
        WHERE
            r.customer_id = c.customer_id
                AND DATE(r.rental_date) < '2005-05-25');
                
-- Using the exists operator, your subquery can return zero, one, or many rows, and
-- the condition simply checks whether the subquery returned one or more rows.

-- You may also use not exists to check for subqueries that return no rows, as 
-- demonstrated by the following:
SELECT 
    a.first_name, a.last_name
FROM
    actor a
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            film_actor fa
                INNER JOIN
            film f ON f.film_id = fa.film_id
        WHERE
            fa.actor_id = a.actor_id
                AND f.rating = 'R');

-- Data Manipulation Using Correlated Subqueries --

-- Subqueries are used heavily in update, delete, and insert statements 
-- as well, with correlated subqueries appearing frequently in update and 
-- delete statements. 
-- Here’s an example of a correlated subquery used to modify the last_update 
-- column in the customer table:
UPDATE customer AS c 
SET 
    c.last_update = (SELECT 
            MAX(r.rental_date)
        FROM
            rental AS r
        WHERE
            r.customer_id = c.customer_id);

-- Check if every customer will have at least one film rental before attempting to 
-- update the last_update column; otherwise, -- the column will be set to null, 
-- since the subquery would return no rows.
UPDATE customer AS c 
SET 
    c.last_update = (SELECT 
            MAX(r.rental_date)
        FROM
            rental AS r
        WHERE
            r.customer_id = c.customer_id)
WHERE
    EXISTS( SELECT 
            1
        FROM
            rental AS r
        WHERE
            r.customer_id = c.customer_id);
            
-- Correlated subqueries are also common in delete statements.
DELETE FROM customer AS c
WHERE 365 < ALL
	(SELECT datediff(NOW(), r.rental_date) DAYS_SINCE_LAST_RENTAL
    FROM rental AS r
    WHERE r.customer_id = c.customer_id);
