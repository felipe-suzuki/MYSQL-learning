# SIMPLE CASE EXPRESSIONS
-- The simple case expression is quite similar to the searched case expression 
-- but is a bit less flexible. Here’s the syntax:

-- CASE V0
-- WHEN V1 THEN E1
-- WHEN V2 THEN E2
-- ...
-- WHEN VN THEN EN
-- [ELSE ED]
-- END

-- In the preceding definition, V0 represents a value, and the symbols V1, V2, ..., VN represent
-- values that are to be compared to V0. The symbols E1, E2, ..., EN represent
-- expressions to be returned by the case expression, and ED represents the expression
-- to be returned if none of the values in the set V1, V2, ..., VN matches the V0 value.

# RESULT SET TRANSFORMATION
-- The result set to contain a single row with one column per value instead of one row per value
-- The query below shows the number of film rentals for May, June, and July of 2005:
SELECT 
    MONTHNAME(rental_date) AS rental_month, COUNT(*) AS num_rentals
FROM
    rental
WHERE
    rental_date BETWEEN '2005-05-01' AND '2005-08-01'
GROUP BY MONTHNAME(rental_date);

-- Then to return a single row of data with three columns and transform this 
-- result set into a single row with each month in a column, we can use CASE:
SELECT 
    SUM(CASE
        WHEN MONTHNAME(rental_date) = 'May' THEN 1
        ELSE 0
    END) AS May_rentals,
    SUM(CASE
        WHEN MONTHNAME(rental_date) = 'June' THEN 1
        ELSE 0
    END) AS June_rentals,
    SUM(CASE
        WHEN MONTHNAME(rental_date) = 'July' THEN 1
        ELSE 0
    END) AS July_rentals
FROM
    rental
WHERE
    rental_date BETWEEN '2005-05-01' AND '2005-08-01';

-- When the monthname() function returns the desired value for that column, the
-- case expression returns the value 1; otherwise, it returns a 0. When summed 
-- over all rows, each column returns the number of accounts opened for that month.