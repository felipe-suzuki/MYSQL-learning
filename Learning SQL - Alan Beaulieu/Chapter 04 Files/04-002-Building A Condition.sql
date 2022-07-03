-- EQUALITY CONDITIONS ---------------------------------------------------
# The following query uses two equality conditions, one in
# the on clause (a join condition) and the other in the where clause
# It will return all email addresses of every customer who rented a film on June 14, 2005.
SELECT 
    c.email
FROM
    customer AS c
        INNER JOIN
    rental AS r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14';
    
-- INEQUALITY CONDITIONS -----------------------------------------------
# This query returns all email addresses for films rented on any 
# other date than June 14, 2005.
SELECT 
    c.email
FROM
    customer AS c
        INNER JOIN
    rental AS r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) <> '2005-06-14'; # OPTION: USE != INSTEAD OF <>
    
-- DATA MODIFICATIONS W/ EQUALITY ---------------------------------------
# remove rows from the rental table where the rental date was in 2004
DELETE FROM rental 
WHERE
    YEAR(rental_date) = 2004;
    
# remove any rows where the rental date was not in 2005 or 2006
DELETE FROM rental 
WHERE
    YEAR(rental_date) <> 2005
    AND YEAR(rental_date) <> 2006;

-- RANGE CONDITIONS ------------------------------------------------------
# This query retrieves all films rented on June 14 or 15 of 2005
SELECT 
    customer_id, rental_date
FROM
    rental
WHERE
    rental_date <= '2005-06-16'
        AND rental_date >= '2005-06-14';

# The BETWEEN operator
# You should always specify the lower limit of the range first (after between) 
# and the upper limit of the range second (after and).
# Upper and lower limits are inclusive
SELECT 
    customer_id, rental_date
FROM
    rental
WHERE
    rental_date BETWEEN '2005-06-14' AND '2005-06-16';

# NUMERIC Ranges    
# All payments between $10 and $11.99 are returned.
SELECT 
    customer_id, payment_date, amount
FROM
    payment
WHERE
    amount BETWEEN 10.0 AND 11.99;
    
# STRING Ranges
# This query returns customers whose last name falls between FA and FR
SELECT 
    last_name, first_name
FROM
    customer
WHERE
    last_name BETWEEN 'FA' AND 'FR';

