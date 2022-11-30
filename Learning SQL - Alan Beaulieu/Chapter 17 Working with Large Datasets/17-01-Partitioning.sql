#PARTITIONING
-- When exactly does a database table become “too big”?
-- The following tasks become more difficult and/or time consuming 
-- as a table grows past a few million rows:

-- • Query execution requiring full table scans
-- • Index creation/rebuild
-- • Data archival/deletion
-- • Generation of table/index statistics
-- • Table relocation (e.g., move to a different tablespace)
-- • Database backups

-- The best way to prevent administrative issues from occurring in the future is to 
-- break large tables into pieces, or partitions, when the table is first created 
-- (although tables can be partitioned later, it is easier to do so initially).

#Partitioning Concepts
-- When a table is partitioned, two or more table partitions are created, each having 
-- the exact same definition but with nonoverlapping subsets of data.

-- While every partition must have the same schema definition (columns, column types, etc.),
-- there are several administrative features that can differ for each partition:
-- • Partitions may be stored on different tablespaces, which can be on different physical
-- storage tiers.
-- • Partitions can be compressed using different compression schemes.
-- • Local indexes (more on this shortly) can be dropped for some partitions.
-- • Table statistics can be frozen on some partitions, while being periodically
-- refreshed on others.
-- • Individual partitions can be pinned into memory or stored in the database’s flash
-- storage tier.