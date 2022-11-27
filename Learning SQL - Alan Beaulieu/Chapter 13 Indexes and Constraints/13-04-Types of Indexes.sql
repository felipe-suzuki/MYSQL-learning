#Types of Indexes

#B-tree indexes
-- All the indexes shown thus far are balanced-tree indexes, which are more commonly
-- known as B-tree indexes. MySQL, Oracle Database, and SQL Server all default to Btree
-- indexing, so you will get a B-tree index unless you explicitly ask for another type.
-- B-tree indexes are organized as trees, with one or more levels of branch nodes
-- leading to a single level of leaf nodes. Branch nodes are used for navigating
-- the tree, while leaf nodes hold the actual values and location information.

-- As rows are inserted, updated, and deleted from the customer table, the server will
-- attempt to keep the tree balanced so that there aren’t far more branch/leaf nodes on
-- one side of the root node than the other.

#Bitmap indexes
-- For columns that contain only a small number of values across a large number of
-- rows (known as low-cardinality data), a different indexing strategy is needed. To handle
-- this situation more efficiently, Oracle Database includes bitmap indexes, which
-- generate a bitmap for each value stored in the column. If you were to build a bitmap
-- index on the customer.active column, the index would maintain two bitmaps: one
-- for the value 0 and another for the value 1. When you write a query to retrieve all
-- inactive customers, the database server can traverse the 0 bitmap and quickly retrieve
-- the desired rows.

-- Oracle users can generate bitmap indexes by simply adding the bitmap keyword to
-- the create index statement, as in:
#CREATE BITMAP INDEX idx_active ON customer (active);

#Text indexes
-- If your database stores documents, you may need to allow users to search for words
-- or phrases in the documents. You certainly don’t want the server to peruse each
-- document and scan for the desired text each time a search is requested, but traditional
-- indexing strategies don’t work for this situation. To handle this situation,
-- MySQL, SQL Server, and Oracle Database include specialized indexing and search
-- mechanisms for documents; both SQL Server and MySQL include what they call fulltext
-- indexes, and Oracle Database includes a powerful set of tools known as Oracle
-- Text. Document searches are specialized enough that it is not practical to show an
-- example, but it is useful to at least know what is available.