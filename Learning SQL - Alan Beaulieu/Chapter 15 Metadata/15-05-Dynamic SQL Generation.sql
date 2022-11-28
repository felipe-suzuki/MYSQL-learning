#Dynamic SQL Generation
-- Some languages, such as Oracle’s PL/SQL and Microsoft’s Transact-SQL, are supersets
-- of the SQL language, meaning that they include SQL statements in their grammar
-- along with the usual procedural constructs, such as “if-then-else” and “while.”

-- Most relational database servers, including SQL Server, Oracle Database,
-- and MySQL, allow SQL statements to be submitted to the server as strings. Submitting
-- strings to a database engine rather than utilizing its SQL interface is generally
-- known as dynamic SQL execution. Oracle’s PL/SQL language, for example, includes an
-- execute immediate command, which you can use to submit a string for execution, while 
-- SQL Server includes a system stored procedure called sp_executesql for executing SQL 
-- statements dynamically.

-- MySQL provides the statements prepare, execute, and deallocate to allow for
-- dynamic SQL execution. Here’s a simple example:
SET @qry = 'SELECT customer_id, first_name, last_name FROM customer';
PREPARE dynsql1 FROM @qry;
EXECUTE dynsql1;
DEALLOCATE PREPARE dynsql1;
-- The set statement simply assigns a string to the qry variable, which is then submitted
-- to the database engine (for parsing, security checking, and optimization) using the
-- prepare statement. After executing the statement by calling execute, the statement
-- must be closed using deallocate prepare, which frees any database resources (e.g.,
-- cursors) that have been utilized during execution.

-- The next example shows how you could execute a query that includes placeholders so
-- that conditions can be specified at runtime:
SET @qry = 'SELECT customer_id, first_name, last_name
FROM customer WHERE customer_id = ?';
PREPARE dynsql2 FROM @qry;
SET @custid = 9;
EXECUTE dynsql2 USING @custid;

SET @custid = 145;
EXECUTE dynsql2 USING @custid;
DEALLOCATE PREPARE dynsql2;

-- The following example generates the same dynamic SQL string as the previous example, 
-- but it retrieves the column names from the information_schema.columns view:
SELECT concat('SELECT ',
concat_ws(',', cols.col1, cols.col2, cols.col3, cols.col4,
cols.col5, cols.col6, cols.col7, cols.col8, cols.col9),
' FROM customer WHERE customer_id = ?')
INTO @qry
FROM
	(SELECT
	max(CASE WHEN ordinal_position = 1 THEN column_name
	ELSE NULL END) AS col1,
	max(CASE WHEN ordinal_position = 2 THEN column_name
	ELSE NULL END) AS col2,
	max(CASE WHEN ordinal_position = 3 THEN column_name
	ELSE NULL END) AS col3,
	max(CASE WHEN ordinal_position = 4 THEN column_name
	ELSE NULL END) AS col4,
	max(CASE WHEN ordinal_position = 5 THEN column_name
	ELSE NULL END) AS col5,
	max(CASE WHEN ordinal_position = 6 THEN column_name
	ELSE NULL END) AS col6,
	max(CASE WHEN ordinal_position = 7 THEN column_name
	ELSE NULL END) AS col7,
	max(CASE WHEN ordinal_position = 8 THEN column_name
	ELSE NULL END) AS col8,
	max(CASE WHEN ordinal_position = 9 THEN column_name
	ELSE NULL END) AS col9
	FROM information_schema.columns
	WHERE table_schema = 'sakila' AND table_name = 'customer'
	GROUP BY table_name
) As cols;

-- Checking the query metadata
SELECT @qry;

PREPARE dynsql3 FROM @qry;
SET @custid = 45;
EXECUTE dynsql3 USING @custid;
DEALLOCATE PREPARE dynsql3;
-- The query pivots the first nine columns in the customer table, builds a query string
-- using the concat and concat_ws functions, and assigns the string to the qry variable.
-- The query string is then executed as before.