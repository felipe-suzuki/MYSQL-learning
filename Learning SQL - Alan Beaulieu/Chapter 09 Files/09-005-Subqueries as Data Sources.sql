-- Since a subquery generates a result set containing rows
-- and columns of data, it is perfectly valid to include subqueries 
-- in your from clause along with tables.

-- Subqueries used in the from clause must be noncorrelated;1 they are executed first,
-- and the data is held in memory until the containing query finishes execution.

SELECT 
    c.first_name, c.last_name, p.num_rentals, p.tot_payments
FROM
    customer AS c
        INNER JOIN
    (SELECT 
        customer_id,
            COUNT(*) AS num_rentals,
            SUM(amount) AS tot_payments
    FROM
        payment
    GROUP BY customer_id) p ON c.customer_id = p.customer_id;

-- UNDERSTANDING THE SUBQUERY --
-- generates a list of customer IDs along with the number of
-- film rentals and the total payments

SELECT 
    customer_id,
    COUNT(*) AS num_rentals,
    SUM(amount) AS tot_payments
FROM
    payment
GROUP BY customer_id;

#Data fabrication
-- Along with using subqueries to summarize existing data, you can use subqueries to
-- generate data that doesn’t exist in any form within your database.

-- GENERATING GROUP DEFINITIONS --
SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit 
UNION ALL SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit 
UNION ALL SELECT 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit;

-- place it into the from clause of another query to generate your customer groups:
SELECT 
    p_grps.name, COUNT(*) AS num_customers
FROM
    (SELECT 
        customer_id,
            COUNT(*) num_rentals,
            SUM(amount) AS tot_payments
    FROM
        payment
    GROUP BY customer_id) AS p
        INNER JOIN
    (SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit 
    UNION ALL SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit 
    UNION ALL SELECT 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit) AS p_grps 
		ON p.tot_payments BETWEEN p_grps.low_limit AND p_grps.high_limit
GROUP BY p_grps.name;

-- The from clause contains two subqueries; the first subquery, named pymnt, returns
-- the total number of film rentals and total payments for each customer, while the second
-- subquery, named pymnt_grps, generates the three customer groupings. The two
-- subqueries are joined by finding which of the three groups each customer belongs to,
-- and the rows are then grouped by the group name in order to count the number of
-- customers in each group.