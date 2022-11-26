# MULTIUSER DATABASES
-- If every user is only executing queries, such as might be the case with a
-- data warehouse during normal business hours, then there are very few issues for the
-- database server to deal with. If some of the users are adding and/or modifying data,
-- however, the server must handle quite a bit more bookkeeping.

-- Let’s say, for example, that you are running a report that sums up the current week’s
-- film rental activity. At the same time you are running the report, however, the following
-- activities are occurring:
-- • A customer rents a film.
-- • A customer returns a film after the due date and pays a late fee.
-- • Five new films are added to inventory.

# LOCKING
-- Locks are the mechanism the database server uses to control simultaneous use of data resources.
-- Most database servers use one of two locking strategies:

-- • Database writers must request and receive from the server a write lock to modify
-- data, and database readers must request and receive from the server a read lock to
-- query data. While multiple users can read data simultaneously, only one write
-- lock is given out at a time for each table (or portion thereof), and read requests
-- are blocked until the write lock is released.

-- • Database writers must request and receive from the server a write lock to modify
-- data, but readers do not need any type of lock to query data. Instead, the server
-- ensures that a reader sees a consistent view of the data (the data seems the same
-- even though other users may be making modifications) from the time her query
-- begins until her query has finished. This approach is known as versioning.

# LOCK GRANULARITIES
-- The server may apply a lock at one of three different levels, or granularities:
# Table locks
-- Keep multiple users from modifying data in the same table simultaneously
# Page locks
-- Keep multiple users from modifying data on the same page (a page is a segment
-- of memory generally in the range of 2 KB to 16 KB) of a table simultaneously
# Row locks
-- Keep multiple users from modifying the same row in a table simultaneously