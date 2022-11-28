#Working with Metadata
#Schema Generation Scripts
-- Let’s build a script that will create the sakila.category table. Here’s the
-- command used to build the table, which I extracted from the script used to 
-- build the example database:
CREATE TABLE category (
category_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
name VARCHAR(25) NOT NULL,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- To write the query that will generate the create table statement. The first step 
-- is to query the information_schema.columns table to retrieve information about 
-- the columns in the table:
SELECT 'CREATE TABLE category (' create_table_statement
UNION ALL
SELECT cols.txt
FROM
(SELECT concat(' ',column_name, ' ', column_type,
CASE
	WHEN is_nullable = 'NO' THEN ' not null'
	ELSE ''
END,
CASE
	WHEN extra IS NOT NULL AND extra LIKE 'DEFAULT_GENERATED%'
	THEN concat(' DEFAULT ',column_default,substr(extra,18))
	WHEN extra IS NOT NULL THEN concat(' ', extra)
	ELSE ''
END,
',') AS txt
FROM information_schema.columns
WHERE table_schema = 'sakila' AND table_name = 'category'
ORDER BY ordinal_position
) AS cols
UNION ALL
SELECT ')';

-- Well, that got us pretty close; we just need to add queries against the 
-- table_con straints and key_column_usage views to retrieve information about the
-- primary key constraint:
SELECT 'CREATE TABLE category (' create_table_statement
UNION ALL
SELECT cols.txt
FROM
(SELECT concat(' ',column_name, ' ', column_type,
CASE
	WHEN is_nullable = 'NO' THEN ' not null'
	ELSE ''
END,
CASE
	WHEN extra IS NOT NULL AND extra LIKE 'DEFAULT_GENERATED%'
	THEN concat(' DEFAULT ',column_default,substr(extra,18))
	WHEN extra IS NOT NULL THEN concat(' ', extra)
	ELSE ''
END,
',') AS txt
FROM information_schema.columns
WHERE table_schema = 'sakila' AND table_name = 'category'
ORDER BY ordinal_position
) AS cols
UNION ALL
SELECT concat(' constraint primary key (')
FROM information_schema.table_constraints
WHERE table_schema = 'sakila' AND table_name = 'category'
AND constraint_type = 'PRIMARY KEY'
UNION ALL
SELECT cols.txt
FROM
(SELECT concat(CASE WHEN ordinal_position > 1 THEN ' ,'
ELSE ' ' END, column_name) AS txt
FROM information_schema.key_column_usage
WHERE table_schema = 'sakila' AND table_name = 'category'
AND constraint_name = 'PRIMARY'
ORDER BY ordinal_position
) AS cols
UNION ALL
SELECT ' )'
UNION ALL
SELECT ')';

-- To see whether the statement is properly formed, let's run query output:
CREATE TABLE category2 (
	category_id tinyint(3) unsigned not null auto_increment,
	name varchar(25) not null ,
	last_update timestamp not null DEFAULT CURRENT_TIMESTAMP
	on update CURRENT_TIMESTAMP,
	constraint primary key (
		category_id
		)
	);