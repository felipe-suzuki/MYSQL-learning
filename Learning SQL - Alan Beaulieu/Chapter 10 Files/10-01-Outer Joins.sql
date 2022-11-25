# Outer Joins
-- The following query counts the number of available copies of each film by
-- joining these table film and table inventory

SELECT 
    f.film_id, f.title, COUNT(*) AS num_copies
FROM
    film AS f
        INNER JOIN
    inventory AS i ON f.film_id = i.film_id
GROUP BY f.film_id , f.title;

# LEFT OUTER JOIN
-- If you want the query to return all 1,000 films, regardless of whether or 
-- not there are rows in the inventory table, you can use an outer join, 
-- which essentially makes the join condition optional.
-- It does instruct the server to include all rows from the table of
-- the left side of the join.

SELECT 
    f.film_id, f.title, COUNT(i.inventory_id) AS num_copies
FROM
    film AS f
        LEFT OUTER JOIN
    inventory AS i ON f.film_id = i.film_id
GROUP BY f.film_id , f.title;

# Left Versus Right Outer Joins
-- The keyword left indicates that the table on the left side of the join is responsible
-- for determining the number of rows in the result set, whereas the table on the
-- right side is used to provide column values whenever a match is found.

-- It will be rarely (if ever) to encounter right outer joins
-- It is recommended to always use left outer joins. 
-- The outer keyword is optional!