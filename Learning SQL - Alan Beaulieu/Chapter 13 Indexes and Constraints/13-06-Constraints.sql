#Constraints
-- A constraint is simply a restriction placed on one or more columns of a table. There
-- are several different types of constraints, including:

# Primary key constraints
-- Identify the column or columns that guarantee uniqueness within a table

# Foreign key constraints
-- Restrict one or more columns to contain only values found in another table’s primary
-- key columns (may also restrict the allowable values in other tables if update
-- cascade or delete cascade rules are established)

# Unique constraints
-- Restrict one or more columns to contain unique values within a table (primary
-- key constraints are a special type of unique constraint)

# Check constraints
-- Restrict the allowable values for a column

#Constraint Creation
-- Constraints are generally created at the same time as the associated table via the cre
-- ate table statement.
CREATE TABLE customer (
...
PRIMARY KEY (customer_id),
...
CONSTRAINT fk_customer_address FOREIGN KEY (address_id)
	REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_customer_store FOREIGN KEY (store_id)
	REFERENCES store (store_id) ON DELETE RESTRICT ON UPDATE CASCADE
    
-- Alternatively, you could create the customer table without foreign key constraints
-- and add the foreign key constraints later via alter table statements:
ALTER TABLE customer
ADD CONSTRAINT fk_customer_address FOREIGN KEY (address_id)
REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE customer
ADD CONSTRAINT fk_customer_store FOREIGN KEY (store_id)
REFERENCES store (store_id) ON DELETE RESTRICT ON UPDATE CASCADE;

-- Both of these statements include several on clauses:
-- • on delete restrict, which will cause the server to raise an error if a row is
-- deleted in the parent table (address or store) that is referenced in the child table
-- (customer)
-- • on update cascade, which will cause the server to propagate a change to the primary
-- key value of a parent table (address or store) to the child table (customer)

-- The on delete restrict clause protects against orphaned records when rows are
-- deleted from the parent table. To illustrate, let’s pick a row in the address table and
-- show the data from both the address and customer tables that share this value:
SELECT c.first_name, c.last_name, c.address_id, a.address
FROM customer AS c
INNER JOIN address AS a
	ON c.address_id = a.address_id
WHERE a.address_id = 123;

-- Here’s what happens if you try to remove this row from the parent (address) table:
DELETE FROM address WHERE address_id = 123;
