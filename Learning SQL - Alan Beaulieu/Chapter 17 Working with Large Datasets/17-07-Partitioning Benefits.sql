#Partitioning Benefits

-- One major advantage to partitioning is that you may only need to interact with as few
-- as one partition, rather than the entire table. This concept is called partition pruning.

-- Similarly, if you execute a query that includes a join to a partitioned table and the query 
-- includes a condition on the partitioning column, the server can exclude any partitions that 
-- do not contain data pertinent to the query. This is known as partitionwise joins, and it is 
-- similar to partition pruning in that only those partitions that contain data needed by the 
-- query will be included.

-- From an administrative standpoint, one of the main benefits to partitioning is the ability to 
-- quickly delete data that is no longer needed. For example, financial data may need to be kept 
-- online for seven years; if a table has been partitioned based on transaction dates, any partitions 
-- holding data greater than seven years old can be dropped.
-- Another administrative advantage to partitioned tables is the ability to perform updates on multiple
-- partitions simultaneously, which can greatly reduce the time needed to touch every row in a table.

#Clustering, allows multiple servers to act as a single database.
-- The shared-disk/shared-cache configurations, where every server in the cluster has access to all 
-- disks, and data cached in one server can be accessed by any other server in the cluster. With this 
-- type of architecture, an application server could attach to any one of the database servers in the 
-- cluster, with connections automatically failing over to another server in the cluster in case of 
-- failure. With an eight-server cluster, you should be able to handle a very large number of concurrent
-- users and associated queries/reports/jobs.

#Sharding
-- Known as sharding, this approach partitions the data across multiple databases (called shards), 
-- so it is similar to table partitioning but on a larger scale and with far more complexity. If you 
-- were to employ this strategy for the social media company with 1 billion users, you might decide 
-- to implement 100 separate databases, each one hosting the data for approximately 10 million users.

-- Sharding is a complex topic, but here are a few of the issues that would need to be addressed:
-- • You will need to choose a sharding key, which is the value used to determine to which 
-- database to connect.
-- • While large tables will be divided into pieces, with individual rows assigned to a single shard, 
-- smaller reference tables may need to be replicated to all shards, and a strategy needs to be defined
-- for how reference data can be modified and changes propagated to all shards.
-- • If individual shards become too large (e.g., the social media company now has two billion users), 
-- you will need a plan for adding more shards and redistributing data across the shards.
-- • When you need to make schema changes, you will need to have a strategy for deploying the changes 
-- across all of the shards so that all schemas stay in sync.
-- • If application logic needs to access data stored in two or more shards, you need to have a strategy 
-- for how to query across multiple databases and also how to implement transactions across multiple databases.