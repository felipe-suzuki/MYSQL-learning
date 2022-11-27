# Unique indexes
-- A unique index plays multiple roles; along with providing all the benefits of a regular
-- index, it also serves as a mechanism for disallowing duplicate values in the indexed
-- column. Whenever a row is inserted or when the indexed column is modified, the
-- database server checks the unique index to see whether the value already exists in
-- another row in the table. Here’s how you would create a unique index on the
-- customer.email column:
ALTER TABLE customer
ADD UNIQUE idx_email (email);

-- SQL Server and Oracle Database users need only add the unique
-- keyword when creating an index, as in:
#CREATE UNIQUE INDEX idx_email
#ON customer (email);

-- With the index in place, you will receive an error if you try to add a new customer
-- with an email address that already exists:
INSERT INTO customer
(store_id, first_name, last_name, email, address_id, active)
VALUES
(1,'ALAN','KAHN', 'ALAN.KAHN@sakilacustomer.org', 394, 1);

#Multicolumn indexes
-- Build an index on both customers first and last name:
ALTER TABLE customer
ADD INDEX idx_full_name (last_name, first_name);

-- When building multiple-column indexes, think carefully about
-- which column to list first, which column to list second, and so on.