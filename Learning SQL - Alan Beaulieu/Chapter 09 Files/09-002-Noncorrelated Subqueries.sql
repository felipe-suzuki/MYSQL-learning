-- Noncorrelated Subqueries -------------------------------------------------------------
-- The example from 09-001 is a noncorrelated subquery; it may be executed
-- alone and does not reference anything from the containing statement.
-- It returns a result set containing a single row and column. This type of subquery is
-- known as a scalar subquery and can appear on either side of a condition using the
-- usual operators (=, <>, <, >, <=, >=). The next example shows how you can use a scalar
-- subquery in an inequality condition:

SELECT 
    city_id, city
FROM
    city
WHERE
    country_id <> (SELECT 
            country_id
        FROM
            country
        WHERE
            country = 'India');
            
-- If you use a subquery in an equality condition but the subquery returns more 
-- than one row, you will receive an error. 
SELECT 
    city_id, city
FROM
    city
WHERE
    country_id <> (SELECT 
            country_id
        FROM
            country
        WHERE
            country <> 'India');

-- Multiple-Row, Single-Column Subqueries --------------------------------------------
-- The in and not in operators --
-- While you can’t equate a single value to a set of values, you can 
-- check to see whether a single value can be found within a set of values.
SELECT 
    country_id
FROM
    country
WHERE
    country IN ('Canada' , 'Mexico');
    
-- Although you will occasionally create a set of strings, dates, or numbers to use on one
-- side of a condition, you are more likely to generate the set using a subquery that
-- returns one or more rows. 

-- The following query uses the in operator with a subquery on the righthand side of 
-- the filter condition to return all cities that are in Canada or Mexico:
SELECT 
    city_id, city
FROM
    city
WHERE
    country_id IN (SELECT 
            country_id
        FROM
            country
        WHERE
            country IN ('Canada' , 'Mexico'));

-- NOT IN --
-- Check the converse of in operator using the not in operator.
SELECT 
    city_id, city
FROM
    city
WHERE
    country_id NOT IN (SELECT 
            country_id
        FROM
            country
        WHERE
            country IN ('Canada' , 'Mexico'));

-- THE ALL OPERATOR --
-- The all operator allows you to make comparisons between a single
-- value and every value in a set.

-- The next query finds all customers who have never gotten a free film rental:
SELECT 
    first_name, last_name
FROM
    customer
WHERE
    customer_id <> ALL (SELECT 
            customer_id
        FROM
            payment
        WHERE
            amount = 0);
            
-- Here’s another example using the all operator, but this time 
-- the subquery is in the having clause:
SELECT 
    customer_id, COUNT(*)
FROM
    rental
GROUP BY customer_id
HAVING COUNT(*) > ALL (SELECT 
        COUNT(*)
    FROM
        rental AS r
            INNER JOIN
        customer AS c ON r.customer_id = c.customer_id
            INNER JOIN
        address AS a ON c.address_id = a.address_id
            INNER JOIN
        city AS ct ON a.city_id = ct.city_id
            INNER JOIN
        country AS co ON ct.country_id = co.country_id
    WHERE
        co.country IN ('United States' , 'Mexico', 'Canada')
    GROUP BY r.customer_id);
    
-- THE ANY OPERATOR --
-- Like the all operator, the any operator allows a value to be compared to the members
-- of a set of values; unlike all, however, a condition using the any operator evaluates to
-- true as soon as a single comparison is favorable.

-- This example will find all customers whose total film rental payments exceed the total
-- payments for all customers in Bolivia, Paraguay, or Chile:
SELECT 
    customer_id, SUM(amount)
FROM
    payment
GROUP BY customer_id
HAVING SUM(amount) > ANY (SELECT 
        SUM(p.amount)
    FROM
        payment AS p
            INNER JOIN
        customer AS c ON p.customer_id = c.customer_id
            INNER JOIN
        address AS a ON c.address_id = a.address_id
            INNER JOIN
        city AS ct ON a.city_id = ct.city_id
            INNER JOIN
        country AS co ON ct.country_id = co.country_id
    WHERE
        co.country IN ('Bolivia' , 'Paraguay', 'Chile')
    GROUP BY co.country);