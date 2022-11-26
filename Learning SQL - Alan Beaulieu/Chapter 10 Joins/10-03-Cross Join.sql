 # Cross Joins
-- To generate the Cartesian product of two tables, you should specify a cross join.

SELECT 
    c.name category_name, l.name language_name
FROM
    category AS c
        CROSS JOIN
    language AS l;
    
-- One applpication is to generate a table with 366 rows (2020 is a leap year) with a single 
-- column containing a number between 0 and 366 and then add that number of days to 
-- January 1, 2020? Here’s one possible method to generate such a table.
SELECT ones.num + tens.num + hundreds.num
FROM
(SELECT 0 num UNION ALL
SELECT 1 num UNION ALL
SELECT 2 num UNION ALL
SELECT 3 num UNION ALL
SELECT 4 num UNION ALL
SELECT 5 num UNION ALL
SELECT 6 num UNION ALL
SELECT 7 num UNION ALL
SELECT 8 num UNION ALL
SELECT 9 num) AS ones
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 10 num UNION ALL
SELECT 20 num UNION ALL
SELECT 30 num UNION ALL
SELECT 40 num UNION ALL
SELECT 50 num UNION ALL
SELECT 60 num UNION ALL
SELECT 70 num UNION ALL
SELECT 80 num UNION ALL
SELECT 90 num) AS tens
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 100 num UNION ALL
SELECT 200 num UNION ALL
SELECT 300 num) AS hundreds
ORDER BY ones.num + tens.num + hundreds.num;

-- The next step is to convert the set of numbers to a set of dates. Use
-- the date_add() function to add each number in the result set to January 1, 2020.
-- Then add a filter condition to throw away any dates after 2020.
SELECT DATE_ADD('2020-01-01',
INTERVAL (ones.num + tens.num + hundreds.num) DAY) dt
FROM
(SELECT 0 num UNION ALL
SELECT 1 num UNION ALL
SELECT 2 num UNION ALL
SELECT 3 num UNION ALL
SELECT 4 num UNION ALL
SELECT 5 num UNION ALL
SELECT 6 num UNION ALL
SELECT 7 num UNION ALL
SELECT 8 num UNION ALL
SELECT 9 num) AS ones
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 10 num UNION ALL
SELECT 20 num UNION ALL
SELECT 30 num UNION ALL
SELECT 40 num UNION ALL
SELECT 50 num UNION ALL
SELECT 60 num UNION ALL
SELECT 70 num UNION ALL
SELECT 80 num UNION ALL
SELECT 90 num) AS tens
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 100 num UNION ALL
SELECT 200 num UNION ALL
SELECT 300 num) AS hundreds
WHERE DATE_ADD('2020-01-01',
INTERVAL (ones.num + tens.num + hundreds.num) DAY) < '2021-01-01'
ORDER BY 1;

# Generate a report that shows every day in 2020 along with the number 
-- of film rentals on that day. The report needs to include every
-- day of the year, including days when no films are rented.
SELECT days.dt, COUNT(r.rental_id) AS num_rentals
FROM rental AS r
RIGHT OUTER JOIN
(SELECT DATE_ADD('2005-01-01',
INTERVAL (ones.num + tens.num + hundreds.num) DAY) dt
FROM
(SELECT 0 num UNION ALL
SELECT 1 num UNION ALL
SELECT 2 num UNION ALL
SELECT 3 num UNION ALL
SELECT 4 num UNION ALL
SELECT 5 num UNION ALL
SELECT 6 num UNION ALL
SELECT 7 num UNION ALL
SELECT 8 num UNION ALL
SELECT 9 num) AS ones
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 10 num UNION ALL
SELECT 20 num UNION ALL
SELECT 30 num UNION ALL
SELECT 40 num UNION ALL
SELECT 50 num UNION ALL
SELECT 60 num UNION ALL
SELECT 70 num UNION ALL
SELECT 80 num UNION ALL
SELECT 90 num) AS tens
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 100 num UNION ALL
SELECT 200 num UNION ALL
SELECT 300 num) AS hundreds
WHERE DATE_ADD('2005-01-01',
INTERVAL (ones.num + tens.num + hundreds.num) DAY) < '2006-01-01'
) AS days
ON days.dt = date(r.rental_date)
GROUP BY days.dt
ORDER BY 1;