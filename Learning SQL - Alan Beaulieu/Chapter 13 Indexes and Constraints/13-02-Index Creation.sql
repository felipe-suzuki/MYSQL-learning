# Index Creation
-- Returning to the customer table, you might decide to add an index on the email column
-- to speed up any queries that specify a value for this column, as well as any
-- update or delete operations that specify a customer’s email address. 
-- Here’s how you can add such an index to a MySQL database:
ALTER TABLE customer
ADD INDEX idx_email (email);

-- With the index in place, the query optimizer can choose to use the index if it is 
-- deemed beneficial to do so. If there is more than one index on a table, the optimizer
-- must decide which index will be the most beneficial for a particular SQL statement.

-- For both SQL Server and Oracle, therefore, you would generate 
-- an index using the create index command, as in:
#CREATE INDEX idx_email
#ON customer (email);

-- MySQL users can use the show command to see all of the indexes on a specific table, as in:
SHOW INDEX FROM customer;

-- If, after creating an index, you decide that the index is not proving useful, you can
-- remove it via the following:
ALTER TABLE customer
DROP INDEX idx_email;

-- SQL Server and Oracle Database users must use the drop index
-- command to remove an index, as in:
#DROP INDEX idx_email; (Oracle)
#DROP INDEX idx_email ON customer; (SQL Server)