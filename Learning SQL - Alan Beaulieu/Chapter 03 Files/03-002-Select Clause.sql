# Even though the select clause is the first clause of a statement, 
# it is one of the last clauses that the database server evaluates.

# Select all (*) columns and rows from Table language
SELECT 
    *
FROM
    language;
    
# The select clause determines which of all possible columns 
# should be included in the query’s result set.

# The next query demonstrates the use of a table column, a literal, an expression, and a
# built-in function call in a single query against the employee table
# Adding a column alias after each element of your select clause using AS
SELECT 
    language_id,
    'COMMON' AS language_usage,
    language_id * 3.1415927 AS lang_pi_value,
    UPPER(name) AS language_name
FROM
    language;

# To execute a built-in function or evaluate a simple expression
# it is possible to skip the FROM clause     
SELECT VERSION(), USER(), DATABASE();