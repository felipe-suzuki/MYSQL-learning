-- Grouping Concepts --
-- GROUP BY --
-- The database server can group the data for you by 
-- using the group by clause.
SELECT 
    customer_id
FROM
    rental
GROUP BY customer_id;

-- COUNT --
-- The aggregate function count() counts the number of rows in each group, and the
-- asterisk tells the server to count everything in the group. Using the combination of a
-- group by clause and the count() aggregate function, you are able to get the data needed.
SELECT 
    customer_id, COUNT(*)
FROM
    rental
GROUP BY customer_id;

-- In order to determine which customers have rented
-- the most films, simply add an order by clause:
SELECT 
    customer_id, COUNT(*)
FROM
    rental
GROUP BY customer_id
ORDER BY 2 DESC;

-- When grouping data, you may need to filter out undesired data from your 
-- result set based on groups of data rather than based on the raw data. 
-- Since the group by clause  runs after the  where clause has been evaluated,
-- you cannot add filter conditions to your where clause for this purpose.

-- For example, here’s an attempt to filter out any
-- customers who have rented fewer than 40 films:
SELECT 
    customer_id, COUNT(*)
FROM
    rental
WHERE
    COUNT(*) >= 40
GROUP BY customer_id;

-- HAVING --
-- You cannot refer to the aggregate function count(*) in your where clause, because
-- the groups have not yet been generated at the time the where clause is evaluated.
-- Instead, you must put your group filter conditions in the having clause. Here’s what
-- the query would look like using having:
SELECT 
    customer_id, COUNT(*)
FROM
    rental
GROUP BY customer_id
HAVING COUNT(*) >= 40;