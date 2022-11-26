# Natural Joins
-- allows you to name the tables to be joined but lets the database 
-- server determine what the join conditions need to be. Known as the 
-- natural join, this join type relies on identical column names across 
-- multiple tables to infer the proper join conditions.

# Although it does exists, it should be avoided using this type of join
-- and use inner joins with explicit join conditions.

SELECT 
    cust.first_name, cust.last_name, DATE(r.rental_date)
FROM
    (SELECT 
        customer_id, first_name, last_name
    FROM
        customer) AS cust
        NATURAL JOIN
    rental AS r;