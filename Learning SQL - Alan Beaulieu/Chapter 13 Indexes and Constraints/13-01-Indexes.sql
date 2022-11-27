# Indexes
-- When you insert a row into a table, the database server does not attempt to put the
-- data in any particular location within the table.

-- When you query a table, therefore, the server will need to inspect every row of the 
-- table to answer the query.
-- For example, let’s say that you issue the following query:
SELECT first_name, last_name
FROM customer
WHERE last_name LIKE 'Y%';

-- To find all customers whose last name begins with Y, the server must visit each row in
-- the customer table and inspect the contents of the last_name column; if the last name
-- begins with Y, then the row is added to the result set. This type of access is known as
-- a table scan.

-- While this method works fine for a table with only three rows, imagine how long it
-- might take to answer the query if the table contains three million rows.

-- Indexes are special tables that, unlike normal data tables, are kept in a specific 
-- order. Instead of containing all of the data about an entity, however, an index 
-- contains only the column (or columns) used to locate rows in the data table, along 
-- with information describing where the rows are physically located. Therefore, the 
-- role of indexes is to facilitate the retrieval of a subset of a table’s rows and
-- columns without the need to inspect every row in the table.