#information_schema
-- All of the objects available within the information_schema database (or schema, in
-- the case of SQL Server) are views. Unlike the describe utility, which I used in several
-- chapters of this book as a way to show the structure of various tables and views, the
-- views within information_schema can be queried and, thus, used programmatically
-- (more on this later in the chapter). Here’s an example that demonstrates how to
-- retrieve the names of all of the tables in the Sakila database:

SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'sakila'
ORDER BY 1;

-- As you can see, the information_schema.tables view includes both tables and views; 
-- if you want to exclude the views, simply add another condition to the where clause:
SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'sakila'
AND table_type = 'BASE TABLE'
ORDER BY 1;

-- If you are only interested in information about views, you can query 
-- information_schema.views. Along with the view names, you can retrieve additional 
-- information, such as a flag that shows whether a view is updatable:
SELECT table_name, is_updatable
FROM information_schema.views
WHERE table_schema = 'sakila'
ORDER BY 1;

-- Column information for both tables and views is available via the columns view. 
-- The following query shows column information for the film table:
SELECT column_name, data_type,
character_maximum_length AS char_max_len,
numeric_precision AS num_prcsn, numeric_scale AS num_scale
FROM information_schema.columns
WHERE table_schema = 'sakila' AND table_name = 'film'
ORDER BY ordinal_position;

-- You can retrieve information about a table’s indexes via the 
-- information_schema.statistics view as demonstrated by the following query, 
-- which retrieves information for the indexes built on the rental table:
SELECT index_name, non_unique, seq_in_index, column_name
FROM information_schema.statistics
WHERE table_schema = 'sakila' AND table_name = 'rental'
ORDER BY 1, 3;

-- You can retrieve the different types of constraints (foreign key, primary key, unique)
-- that have been created via the information_schema.table_constraints view. Here’s
-- a query that retrieves all of the constraints in the Sakila schema:
SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'sakila'
ORDER BY 3,1;

