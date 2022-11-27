#How Indexes Are Used
-- Indexes are generally used by the server to quickly locate rows in a particular table,
-- after which the server visits the associated table to extract the additional information
-- requested by the user. Consider the following query:
SELECT customer_id, first_name, last_name
FROM customer
WHERE first_name LIKE 'S%' AND last_name LIKE 'P%';

-- For this query, the server can employ any of the following strategies:
-- • Scan all rows in the customer table.

-- • Use the index on the last_name column to find all customers whose last name
-- starts with P; then visit each row of the customer table to find only rows whose
-- first name starts with S.

-- • Use the index on the last_name and first_name columns to find all customers
-- whose last name starts with P and whose first name starts with S.

-- The third choice seems to be the best option, since the index will yield all of the rows
-- needed for the result set, without the need to revisit the table. But how do you know
-- which of the three options will be utilized? To see how MySQL’s query optimizer
-- decides to execute the query, I use the explain statement to ask the server to show
-- the execution plan for the query rather than executing the query:
EXPLAIN #SQL Server: set show plan_text on; #Oracle Database: explain plan
SELECT customer_id, first_name, last_name
FROM customer
WHERE first_name LIKE 'S%' AND last_name LIKE 'P%';

-- Looking at the query results, the possible_keys column tells you that the server
-- could decide to use either the idx_last_name or the idx_full_name index, and the
-- key column tells you that the idx_full_name index was chosen.

-- In general, you should strive to have neither too many indexes nor too few. If you
-- aren’t sure how many indexes you should have, you can use this strategy as a default:

-- • Make sure all primary key columns are indexed (most servers automatically create
-- unique indexes when you create primary key constraints). For multicolumn
-- primary keys, consider building additional indexes on a subset of the primary
-- key columns or on all the primary key columns but in a different order than the
-- primary key constraint definition.

-- • Build indexes on all columns that are referenced in foreign key constraints. Keep
-- in mind that the server checks to make sure there are no child rows when a parent
-- is deleted, so it must issue a query to search for a particular value in the column.
-- If there’s no index on the column, the entire table must be scanned.

-- • Index any columns that will frequently be used to retrieve data. Most date columns
-- are good candidates, along with short (2- to 50-character) string columns.