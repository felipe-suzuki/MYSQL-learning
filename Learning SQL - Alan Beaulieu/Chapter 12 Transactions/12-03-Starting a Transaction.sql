# Starting a Transaction
-- Database servers handle transaction creation in one of two ways:

-- • An active transaction is always associated with a database session, so there is no
-- need or method to explicitly begin a transaction. When the current transaction
-- ends, the server automatically begins a new transaction for your session.

-- • Unless you explicitly begin a transaction, individual SQL statements are automatically
-- committed independently of one another. To begin a transaction, you must
-- first issue a command.

# Turning autocommit off for individual sessions:
-- SQL Server = SET IMPLICIT_TRANSACTIONS ON

-- MySQL = SET AUTOCOMMIT=0

# IMPORTANT NOTE:
-- A word of advice: shut off autocommit mode each time you log in,
-- and get in the habit of running all of your SQL statements within a
-- transaction. If nothing else, it may save you the embarrassment of
-- having to ask your DBA to reconstruct data that you have inadvertently deleted.