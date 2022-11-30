#Table Partitioning
-- The partitioning scheme available in most relational databases is horizontal partitioning,
-- which assigns entire rows to exactly one partition. Tables may also be partitioned
-- vertically, which involves assigning sets of columns to different partitions, but this
-- must be done manually. When partitioning a table horizontally, you must choose a partition key,
-- which is the column whose values are used to assign a row to a particular partition. 
-- In most cases, a table’s partition key consists of a single column, and a partitioning function 
-- is applied to this column to determine in which partition each row should reside.

#Index Partitioning
-- If your partitioned table has indexes, you will get to choose whether a particular
-- index should stay intact, known as a global index, or be broken into pieces such that
-- each partition has its own index, which is called a local index. Global indexes span all
-- partitions of the table and are useful for queries that do not specify a value for the
-- partition key. For example, let’s say your table is partitioned on the sale_date column,
-- and a user executes the following query:
SELECT sum(amount) FROM sales WHERE geo_region_cd = 'US';

-- Since this query does not include a filter condition on the sale_date column, the server 
-- will need to search every partition in order to find the total US sales. If a global
-- index is built on the geo_region_cd column, however, then the server could use this
-- index to quickly find all of the rows containing US sales.
