-- JOIN ---------------------------------------------------------------
## CARTESIAN PRODUCT ##
# Because the query below didn’t specify how the two tables 
# should be joined, the database server generated the Cartesian
# product, which is every permutation of the two tables 
# -> (599 customers x 603 addresses = 361,197 permutations)
SELECT 
    c.first_name, c.last_name, a.address
FROM
    customer AS c
        JOIN
    address AS a;

 -- INNER JOINS -------------------------------------------------------
 # Using ON we can relate the two tables through address_id
SELECT 
    c.first_name, c.last_name, a.address
FROM
    customer AS c
        JOIN
    address AS a ON c.address_id = a.address_id;

## If a value exists for the column in one table but not the other, 
# then the address_id join fails for the rows containing that value, 
# and those rows are excluded from the result set    

-- JOINING 3 OR MORE TABLES ----------------------------------------------
# To show each customer’s city, you will need to traverse from the customer table to the
# address table using the address_id column and then from the address table to the
# city table using the city_id column
SELECT 
    c.first_name, c.last_name, ct.city
FROM
    customer AS c
        INNER JOIN
    address AS a ON c.address_id = a.address_id
        INNER JOIN
    city AS ct ON a.city_id = ct.city_id;

# At first glance, it might seem like the order in which the 
# tables appear in the clause is important, but if you switch
# from the table order, you will get the exact same results.

-- STRAIGHT JOIN -----------------------------------------------
# You can place the tables in the desired order and then 
# specify the keyword straight_join in MySQL

# Use the city table as the driving table and to then join
# the address and customer tables
SELECT STRAIGHT_JOIN
    c.first_name, c.last_name, ct.city
FROM
    city AS ct
        INNER JOIN
    address AS a ON a.city_id = ct.city_id
        INNER JOIN
    customer AS c ON c.address_id = a.address_id;
