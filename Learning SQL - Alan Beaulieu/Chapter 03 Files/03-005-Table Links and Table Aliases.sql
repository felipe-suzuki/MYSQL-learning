-- TABLE LINKS -------------------------------------------------
# The second deviation from the simple clause definition is the mandate that if
-- from more than one table appears in the clause, the conditions used to link 
-- the tables from must be included as well.
# A simple example of an INNER JOIN. It will be discussed later on Chpater 05 and 10
SELECT 
    customer.first_name,
    customer.last_name,
    TIME(rental.rental_date) AS rental_time
FROM
    customer
        INNER JOIN
    rental ON customer.customer_id = rental.customer_id
WHERE
    DATE(rental.rental_date) = '2005-06-14';
    
-- DEFINING TABLE ALIASES -----------------------------------------
# Defining each table an alias and call the alias throughout the query.
SELECT 
    c.first_name, c.last_name, TIME(r.rental_date) AS rental_time
FROM
    customer AS c
        INNER JOIN
    rental AS r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14';