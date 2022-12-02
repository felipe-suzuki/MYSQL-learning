#Composite partitioning

-- With composite partitioning, the first partitioning method defines the partitions,
-- and the second partitioning method defines the subpartitions.
-- Here’s an example, again using the sales table, utilizing both range and hash partitioning:
CREATE TABLE sales_hash2
	(sale_id INT NOT NULL,
	cust_id INT NOT NULL,
	store_id INT NOT NULL,
	sale_date DATE NOT NULL,
	amount DECIMAL(9,2)
	)
PARTITION BY RANGE (yearweek(sale_date))
SUBPARTITION BY HASH (cust_id)
(PARTITION s1 VALUES LESS THAN (202002)
	(SUBPARTITION s1_h1,
	SUBPARTITION s1_h2,
	SUBPARTITION s1_h3,
	SUBPARTITION s1_h4),
PARTITION s2 VALUES LESS THAN (202003)
	(SUBPARTITION s2_h1,
	SUBPARTITION s2_h2,
	SUBPARTITION s2_h3,
	SUBPARTITION s2_h4),
PARTITION s3 VALUES LESS THAN (202004)
	(SUBPARTITION s3_h1,
	SUBPARTITION s3_h2,
	SUBPARTITION s3_h3,
	SUBPARTITION s3_h4),
PARTITION s4 VALUES LESS THAN (202005)
	(SUBPARTITION s4_h1,
	SUBPARTITION s4_h2,
	SUBPARTITION s4_h3,
	SUBPARTITION s4_h4),
PARTITION s5 VALUES LESS THAN (202006)
	(SUBPARTITION s5_h1,
	SUBPARTITION s5_h2,
	SUBPARTITION s5_h3,
	SUBPARTITION s5_h4),
PARTITION s999 VALUES LESS THAN (MAXVALUE)
	(SUBPARTITION s999_h1,
	SUBPARTITION s999_h2,
	SUBPARTITION s999_h3,
	SUBPARTITION s999_h4)
);

-- Next, let’s reinsert the 16 rows from the earlier example for hash partitioning:
INSERT INTO sales_hash2
VALUES
	(1, 1, 1, '2020-01-18', 1.1), (2, 3, 4, '2020-02-07', 1.2),
	(3, 17, 5, '2020-01-19', 1.3), (4, 23, 2, '2020-02-08', 1.4),
	(5, 56, 1, '2020-01-20', 1.6), (6, 77, 5, '2020-02-09', 1.7),
	(7, 122, 4, '2020-01-21', 1.8), (8, 153, 1, '2020-02-10', 1.9),
	(9, 179, 5, '2020-01-22', 2.0), (10, 244, 2, '2020-02-11', 2.1),
	(11, 263, 1, '2020-01-23', 2.2), (12, 312, 4, '2020-02-12', 2.3),
	(13, 346, 2, '2020-01-24', 2.4), (14, 389, 3, '2020-02-13', 2.5),
	(15, 472, 1, '2020-01-25', 2.6), (16, 502, 1, '2020-02-14', 2.7);

-- When you query the sales_hash2 table, you can retrieve data from one of the partitions, in
-- which case you retrieve data from the four subpartitions associated with the partition:
SELECT *
FROM sales_hash2 PARTITION (s3);

-- Because the table is subpartitioned, you may also retrieve data from a single subpartition:
SELECT *
FROM sales_hash2 PARTITION (s3_h3);