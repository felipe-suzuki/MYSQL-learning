# If your query fails to yield any results, the mysql will show you the 
# message found at the end of the following example
SELECT 
    first_name, last_name
FROM
    customer
WHERE
    last_name = 'ZIEGLER';
    
-- QUERY CLAUSES -------------------------------------------------------
-- Clause name -> Purpose
-- select -> Determines which columns to include in the query’s result set
-- from -> Identifies the tables from which to retrieve data and how the tables should be joined
-- where -> Filters out unwanted data
-- group by -> Used to group rows together by common column values
-- having -> Filters out unwanted groups
-- order by -> Sorts the rows of the final result set by one or more columns