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
        
-- TEMPORARY TABLES ------------------------------------------
# Temporary Table with actors whose last names start with J
CREATE TEMPORARY TABLE actors_j
(actor_id smallint(5),
first_name varchar(45),
last_name varchar(45)
);

# Inserting into table 
INSERT INTO actors_j
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE 'J%';

# Retrieving the table
SELECT 
    *
FROM
    actors_j;
    
# Most database servers also drop the temporary table when the session
-- ends. The exception is Oracle Database, which keeps the definition
-- of the temporary table available for future sessions.

-- VIEWS ------------------------------------------------------------
# A view is a query that is stored in the data dictionary.
# Creating a view with 4 columns from customer table
CREATE VIEW cust_vw AS
    SELECT 
        customer_id, first_name, last_name, active
    FROM
        customer;

# Retrieving the view
SELECT 
    first_name, last_name
FROM
    cust_vw
WHERE
    active = 0;