-- SORTING COMPOUND QUERY RESULTS ------------------------------------
# When specifying column names in the order by clause, you 
# will need to choose from the column names in the first query 
# of the compound query.
SELECT 
    a.first_name AS fname, a.last_name AS lname
FROM
    actor AS a
WHERE
    a.first_name LIKE 'J%'
        AND a.last_name LIKE 'D%' 
UNION ALL SELECT 
    c.first_name, c.last_name
FROM
    customer AS c
WHERE
    c.first_name LIKE 'J%'
        AND c.last_name LIKE 'D%'
ORDER BY lname , fname;

# If you specify a column name from the second query in 
# your order by clause, you will see the following error:

SELECT 
    a.first_name fname, a.last_name lname
FROM
    actor AS a
WHERE
    a.first_name LIKE 'J%'
        AND a.last_name LIKE 'D%' 
UNION ALL SELECT 
    c.first_name, c.last_name
FROM
    customer AS c
WHERE
    c.first_name LIKE 'J%'
        AND c.last_name LIKE 'D%'
ORDER BY last_name , first_name;
