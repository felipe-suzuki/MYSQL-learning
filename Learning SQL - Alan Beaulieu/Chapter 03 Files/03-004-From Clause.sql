# The from clause defines the tables used by a query, along 
# with the means of linking the tables together.

-- TABLES --------------------------------------------------------
# Permanent tables (i.e., created using the create table statement)
# Derived tables (i.e., rows returned by a subquery and held in memory)
# Temporary tables (i.e., volatile data held in memory)
# Virtual tables (i.e., created using the create view statement)

# A subquery is a query contained within another query.
SELECT 
    CONCAT(cust.last_name, ', ', cust.first_name) full_name
FROM
    (SELECT 
        first_name, last_name, email
    FROM
        customer
    WHERE
        first_name = 'JESSIE') AS cust;