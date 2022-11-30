#Partitioning Methods

#Range partitioning
-- While range partitioning can be used for several different column types, the most 
-- common usage is to break up tables by date ranges. For example, a table named sales 
-- could be partitioned using the sale_date column such that data for each week is stored 
-- in a different partition:

CREATE TABLE sales
	(sale_id INT NOT NULL,
	cust_id INT NOT NULL,
	store_id INT NOT NULL,
	sale_date DATE NOT NULL,
	amount DECIMAL(9,2)
	)
PARTITION BY RANGE (yearweek(sale_date))
	(PARTITION s1 VALUES LESS THAN (202002),
	PARTITION s2 VALUES LESS THAN (202003),
	PARTITION s3 VALUES LESS THAN (202004),
	PARTITION s4 VALUES LESS THAN (202005),
	PARTITION s5 VALUES LESS THAN (202006),
	PARTITION s999 VALUES LESS THAN (MAXVALUE)
);

-- This statement creates six different partitions, one for each of the first five weeks 
-- of 2020 and a sixth partition named s999 to hold any rows beyond week five of year 2020. 
-- For this table, the yearweek(sale_date) expression is used as the partitioning function, 
-- and the sale_date column serves as the partitioning key. To see the metadata about your
-- partitioned tables, you can use the partitions table in the information_schema database:
SELECT partition_name, partition_method, partition_expression
FROM information_schema.partitions
WHERE table_name = 'sales'
ORDER BY partition_ordinal_position;

-- One of the administrative tasks that will need to be performed on the sales table involves 
-- generating new partitions to hold future data.
ALTER TABLE sales REORGANIZE PARTITION s999 INTO
(PARTITION s6 VALUES LESS THAN (202007),
PARTITION s7 VALUES LESS THAN (202008),
PARTITION s999 VALUES LESS THAN (MAXVALUE)
);

-- Next, let’s add a couple of rows to the table:
INSERT INTO sales
VALUES
	(1, 1, 1, '2020-01-18', 2765.15),
	(2, 3, 4, '2020-02-07', 5322.08);

-- Let's check in which partition the rows were added:
SELECT concat('# of rows in S1 = ', count(*)) AS partition_rowcount
FROM sales PARTITION (s1) UNION ALL
SELECT concat('# of rows in S2 = ', count(*)) AS partition_rowcount
FROM sales PARTITION (s2) UNION ALL
SELECT concat('# of rows in S3 = ', count(*)) AS partition_rowcount
FROM sales PARTITION (s3) UNION ALL
SELECT concat('# of rows in S4 = ', count(*)) AS partition_rowcount
FROM sales PARTITION (s4) UNION ALL
SELECT concat('# of rows in S5 = ', count(*)) AS partition_rowcount
FROM sales PARTITION (s5) UNION ALL
SELECT concat('# of rows in S6 = ', count(*)) AS partition_rowcount
FROM sales PARTITION (s6) UNION ALL
SELECT concat('# of rows in S7 = ', count(*)) AS partition_rowcount
FROM sales PARTITION (s7) UNION ALL
SELECT concat('# of rows in S999 = ', count(*)) partition_rowcount
FROM sales PARTITION (s999);