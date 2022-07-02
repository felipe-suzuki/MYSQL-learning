# When using the group by clause to generate groups of rows, you may also
-- use the having clause, which allows you to filter grouped data in the same way the
-- where clause lets you filter raw data.

SELECT 
    c.first_name, c.last_name, COUNT(*)
FROM
    customer AS c
        INNER JOIN
    rental AS r ON c.customer_id = r.customer_id
GROUP BY c.first_name , c.last_name
HAVING COUNT(*) >= 40;

-- ORDER BY ------------------------------------------------
# The order by clause is the mechanism for sorting your result set using either raw column
-- data or expressions based on column data.

# query that returns all customers who rented a film on June 14, 2005
-- in alphabetical order by last name.
SELECT 
    c.first_name,
    c.last_name,
    TIME(r.rental_date) AS rental_time
FROM
    customer AS c
        INNER JOIN
    rental AS r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14'
ORDER BY c.last_name;

# Adding first_name column after the last_name will order 
-- by the last_name column first, then first_name second
SELECT 
    c.first_name, c.last_name, TIME(r.rental_date) rental_time
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14'
ORDER BY c.last_name , c.first_name;

#The default is ascending, so you will need to add the DESC
-- keyword if you want to use a descending sort
SELECT 
    c.first_name, c.last_name, TIME(r.rental_date) AS rental_time
FROM
    customer AS c
        INNER JOIN
    rental AS r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14'
ORDER BY TIME(r.rental_date) DESC;

-- SORTING VIA NUMERIC PLACEHOLDER ---------------------
# order by clause specifying a descending sort 
-- using the third element in the select clause
SELECT 
    c.first_name,
    c.last_name,
    TIME(r.rental_date) AS rental_time
FROM
    customer AS c
        INNER JOIN
    rental AS r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14'
ORDER BY 3 DESC;