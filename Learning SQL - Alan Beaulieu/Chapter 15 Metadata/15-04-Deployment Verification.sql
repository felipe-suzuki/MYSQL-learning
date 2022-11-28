#Deployment Verification
-- After the deployment scripts have been run, it’s a good idea to run a verification
-- script to ensure that the new schema objects are in place with the appropriate 
-- columns, indexes, primary keys, and so forth. Here’s a query that returns the 
-- number of columns, number of indexes, and number of primary key constraints (0 or 1)
-- for each table in the Sakila schema:
SELECT tbl.table_name,
	(SELECT count(*) FROM information_schema.columns AS clm
	WHERE clm.table_schema = tbl.table_schema
	AND clm.table_name = tbl.table_name) AS num_columns,
	(SELECT count(*) FROM information_schema.statistics AS sta
	WHERE sta.table_schema = tbl.table_schema
	AND sta.table_name = tbl.table_name) AS num_indexes,
	(SELECT count(*) FROM information_schema.table_constraints AS tc
	WHERE tc.table_schema = tbl.table_schema
	AND tc.table_name = tbl.table_name
	AND tc.constraint_type = 'PRIMARY KEY') AS num_primary_keys
FROM information_schema.tables AS tbl
WHERE tbl.table_schema = 'sakila' AND tbl.table_type = 'BASE TABLE'
ORDER BY 1;

-- You could execute this statement before and after the deployment and then verify any
-- differences between the two sets of results before declaring the deployment a success.