-- Write a query that lists all of the indexes in the Sakila schema. 
-- Include the table names.

SELECT DISTINCT table_name, index_name
FROM information_schema.statistics
WHERE table_schema = 'sakila';