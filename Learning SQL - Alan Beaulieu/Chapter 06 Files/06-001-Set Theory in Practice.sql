-- Therefore, when performing set operations on two data sets, 
-- the following guidelines must apply:
-- • Both data sets must have the same number of columns.
-- • The data types of each column across the two data sets must be the same (or the
-- server must be able to convert one to the other).

# This query is known as a compound query because
# it comprises multiple, otherwise-independent queries.
# combine all rows from the two sets
SELECT 1 num, 'abc' str 
UNION SELECT 9 num, 'xyz' str;

-- SET OPERATORS ----------------------------------------
-- UNION OPERATOR ---------------------------------------
# UNION ALL operator doesn’t remove duplicates

# Using the union all operator to generate a set of
# first and last names from multiple tables
SELECT 
    'CUST' typ, c.first_name, c.last_name
FROM
    customer AS c 
UNION ALL SELECT 
    'ACTR' typ, a.first_name, a.last_name
FROM
    actor AS a;

# Here is another compound query that returns duplicate data
SELECT 
    c.first_name, c.last_name
FROM
    customer AS c
WHERE
    c.first_name LIKE 'J%'
        AND c.last_name LIKE 'D%' 
UNION ALL SELECT 
    a.first_name, a.last_name
FROM
    actor AS a
WHERE
    a.first_name LIKE 'J%'
        AND a.last_name LIKE 'D%';
        
# If you would like your combined table to exclude duplicate rows, 
# you need to use the union operator instead of union all
SELECT 
    c.first_name, c.last_name
FROM
    customer AS c
WHERE
    c.first_name LIKE 'J%'
        AND c.last_name LIKE 'D%' 
UNION SELECT 
    a.first_name, a.last_name
FROM
    actor AS a
WHERE
    a.first_name LIKE 'J%'
        AND a.last_name LIKE 'D%';
        
-- INTERSECT OPEARTOR -----------------------------------
-- version 8.0 of MySQL does not implement the intersect operator

# THAT IS WHAT IT WOULD LOOK LIKE
-- SELECT c.first_name, c.last_name
-- FROM customer c
-- WHERE c.first_name LIKE 'D%' AND c.last_name LIKE 'T%'
-- INTERSECT
-- SELECT a.first_name, a.last_name
-- FROM actor a
-- WHERE a.first_name LIKE 'D%' AND a.last_name LIKE 'T%';
-- Empty set (0.04 sec)

# While there are both actors and customers having the initials DT, these sets are completely
# nonoverlapping, so the intersection of the two sets yields the empty set. If we
# switch back to the initials JD, however, the intersection will yield a single row:

-- SELECT c.first_name, c.last_name
-- FROM customer c
-- WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
-- INTERSECT
-- SELECT a.first_name, a.last_name
-- FROM actor a
-- WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%';
-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | JENNIFER 	| DAVIS 	|
-- +------------+-----------+
-- 1 row in set (0.00 sec)

-- EXCEPT OPERATOR ---------------------------------------------
# The except operator returns the first result set minus any overlap
# with the second result set.
# version 8.0 of MySQL does not implement the except operator

-- SELECT a.first_name, a.last_name
-- FROM actor a
-- WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
-- EXCEPT
-- SELECT c.first_name, c.last_name
-- FROM customer c
-- WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%';

-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | JUDY 		| DEAN 		|
-- | JODIE 		| DEGENERES |
-- | JULIANNE 	| DENCH 	|
-- +------------+-----------+
-- 3 rows in set (0.00 sec)