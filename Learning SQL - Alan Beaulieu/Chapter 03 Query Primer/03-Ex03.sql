-- Write a query against the rental table that returns the IDs of the customers who rented
-- a film on July 5, 2005 (use the rental.rental_date column, and you can use the
-- date() function to ignore the time component). Include a single row for each distinct
-- customer ID.

SELECT 
    c.customer_id
FROM
    customer AS c
        INNER JOIN
    rental AS r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-07-05'
GROUP BY c.customer_id;

#The second method does works too!

SELECT 
    customer_id
FROM
    rental
WHERE
    DATE(rental_date) = '2005-07-05'
ORDER BY customer_id;