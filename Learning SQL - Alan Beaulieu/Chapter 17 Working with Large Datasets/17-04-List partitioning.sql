#List partitioning

-- If the column chosen as the partitioning key contains state codes (e.g., CA, TX, VA,
-- etc.), currencies (e.g., USD, EUR, JPY, etc.), or some other enumerated set of values,
-- you may want to utilize list partitioning, which allows you to specify which values
-- will be assigned to each partition. For example, let’s say that the sales table includes
-- the column geo_region_cd, which contains the following values:

-- +---------------+--------------------------+
-- | geo_region_cd | description 			  |
-- +---------------+--------------------------+
-- | US_NE 		   | United States North East |
-- | US_SE		   | United States South East |
-- | US_MW 		   | United States Mid West	  |
-- | US_NW   	   | United States North West |
-- | US_SW 		   | United States South West |
-- | CAN 		   | Canada					  |
-- | MEX 		   | Mexico					  |
-- | EUR_E 	 	   | Eastern Europe			  |
-- | EUR_W 		   | Western Europe			  |
-- | CHN 		   | China					  |
-- | JPN 		   | Japan 					  |
-- | IND 		   | India					  |
-- | KOR 		   | Korea					  |
-- +---------------+--------------------------+

-- You could group these values into geographic regions and create a partition for each
-- one, as in:
CREATE TABLE sales2
	(sale_id INT NOT NULL,
	cust_id INT NOT NULL,
	store_id INT NOT NULL,
	sale_date DATE NOT NULL,
	geo_region_cd VARCHAR(6) NOT NULL,
	amount DECIMAL(9,2)
	)
PARTITION BY LIST COLUMNS (geo_region_cd)
(PARTITION NORTHAMERICA VALUES IN ('US_NE','US_SE','US_MW',
	'US_NW','US_SW','CAN','MEX'),
PARTITION EUROPE VALUES IN ('EUR_E','EUR_W'),
PARTITION ASIA VALUES IN ('CHN','JPN','IND','KOR')
);

-- Adding some rows to the table:
INSERT INTO sales2
VALUES
	(1, 1, 1, '2020-01-18', 'US_NE', 2765.15),
	(2, 3, 4, '2020-02-07', 'CAN', 5322.08),
	(3, 6, 27, '2020-03-11', 'KOR', 4267.12);
    
-- While range partitioning allows for a maxvalue partition to catch any rows that don’t
-- map to any other partition, it’s important to keep in mind that list partitioning doesn’t.
-- Thus, any time you need to add another column -- value (e.g., the company starts selling 
-- products in Australia), you will need to modify the partitioning definition before rows 
-- with the new value can be added to the table.

-- Let's check in which partition the rows were added:
SELECT concat('# of rows in North America = ', count(*)) AS partition_rowcount
FROM sales2 PARTITION (NORTHAMERICA) UNION ALL
SELECT concat('# of rows in Europe = ', count(*)) AS partition_rowcount
FROM sales2 PARTITION (EUROPE) UNION ALL
SELECT concat('# of rows in Asia = ', count(*)) AS partition_rowcount
FROM sales2 PARTITION (ASIA);