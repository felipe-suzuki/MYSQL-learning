-- If your compound query contains more than two queries using different 
-- set operators, you need to think about the order in which to place 
-- the queries in your compound statement to achieve the desired results.
SELECT 
    a.first_name, a.last_name
FROM
    actor AS a
WHERE
    a.first_name LIKE 'J%'
        AND a.last_name LIKE 'D%' 
UNION ALL SELECT 
    a.first_name, a.last_name
FROM
    actor AS a
WHERE
    a.first_name LIKE 'M%'
        AND a.last_name LIKE 'T%' 
UNION SELECT 
    c.first_name, c.last_name
FROM
    customer AS c
WHERE
    c.first_name LIKE 'J%'
        AND c.last_name LIKE 'D%';
        
# Where the UNION and UNION ALL operators are placed does matter.
# Interchanging the UNION and UNION ALL, does create another query result.
SELECT 
    a.first_name, a.last_name
FROM
    actor AS a
WHERE
    a.first_name LIKE 'J%'
        AND a.last_name LIKE 'D%' 
UNION SELECT 
    a.first_name, a.last_name
FROM
    actor AS a
WHERE
    a.first_name LIKE 'M%'
        AND a.last_name LIKE 'T%' 
UNION ALL SELECT 
    c.first_name, c.last_name
FROM
    customer AS c
WHERE
    c.first_name LIKE 'J%'
        AND c.last_name LIKE 'D%';