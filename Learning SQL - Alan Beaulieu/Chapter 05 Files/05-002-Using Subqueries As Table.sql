-- SUBQUERIES ----------------------------------------------------
# The following query joins the customer table to a subquery against
# the address and city tables. The subquery, which starts on line 4 
# and is given the alias addr, finds all addresses that are in California.

# The outer query joins the subquery results to the customer table to 
# return the first name, last name, street address, and city of all 
# customers who live in California.
SELECT 
    c.first_name, c.last_name, addr.address, addr.city
FROM
    customer AS c
        INNER JOIN
    (SELECT 
        a.address_id, a.address, ct.city
    FROM
        address AS a
    INNER JOIN city AS ct ON a.city_id = ct.city_id
    WHERE
        a.district = 'California') addr ON c.address_id = addr.address_id;
        
-- USING THE SAME TABLE TWICE ----------------------------------------
# Retrieve only films in which both Cate McQueen and Cuba Birch appeared
# To find all rows in the film table that have two rows in the film_actor table, 
# one of which is associated with Cate McQueen, and the other associated with 
# Cuba Birch, including the film_actor and actor tables twice.
SELECT 
    f.title
FROM
    film AS f
        INNER JOIN
    film_actor AS fa1 ON f.film_id = fa1.film_id
        INNER JOIN
    actor AS a1 ON fa1.actor_id = a1.actor_id
        INNER JOIN
    film_actor AS fa2 ON f.film_id = fa2.film_id
        INNER JOIN
    actor AS a2 ON fa2.actor_id = a2.actor_id
WHERE
    (a1.first_name = 'CATE'
        AND a1.last_name = 'MCQUEEN')
        AND (a2.first_name = 'CUBA'
        AND a2.last_name = 'BIRCH');