# Transaction Savepoints
-- In some cases, you may encounter an issue within a transaction that requires a rollback,
-- but you may not want to undo all of the work that has transpired. For these
-- situations, you can establish one or more savepoints within a transaction and use
-- them to roll back to a particular location within your transaction rather than rolling
-- all the way back to the start of the transaction.

# Choosing a Storage Engine
-- The MySQL server, however, has been designed so that multiple storage engines 
-- may be utilized to provide low-level database functionality, including resource locking and 
-- transaction management. As of version 8.0, MySQL includes the following storage engines:

# MyISAM
-- A nontransactional engine employing table locking
# MEMORY
-- A nontransactional engine used for in-memory tables
# CSV
-- A transactional engine that stores data in comma-separated files
# InnoDB
-- A transactional engine employing row-level locking
# Merge
-- A specialty engine used to make multiple identical MyISAM tables appear as a
-- single table (a.k.a. table partitioning)
# Archive
-- A specialty engine used to store large amounts of unindexed data, mainly for
-- archival purposes

-- All savepoints must be given a name, which allows you to have multiple savepoints
-- within a single transaction. To create a savepoint named my_savepoint, you can do
-- the following:
SAVEPOINT my_savepoint;

-- To roll back to a particular savepoint, you simply issue the rollback command followed
-- by the keywords to savepoint and the name of the savepoint, as in:
ROLLBACK TO SAVEPOINT my_savepoint;

-- Here’s an example of how savepoints may be used:
START TRANSACTION;
	UPDATE product
	SET date_retired = CURRENT_TIMESTAMP()
	WHERE product_cd = 'XYZ';
    
SAVEPOINT before_close_accounts;

UPDATE account
	SET status = 'CLOSED', close_date = CURRENT_TIMESTAMP(),
	last_activity_date = CURRENT_TIMESTAMP()
	WHERE product_cd = 'XYZ';
    
ROLLBACK TO SAVEPOINT before_close_accounts;
COMMIT;

-- The net effect of this transaction is that the mythical XYZ product is retired but none
-- of the accounts are closed.
-- When using savepoints, remember the following:
-- • Despite the name, nothing is saved when you create a savepoint. You must eventually
-- issue a commit if you want your transaction to be made permanent.
-- • If you issue a rollback without naming a savepoint, all savepoints within the
-- transaction will be ignored, and the entire transaction will be undone.