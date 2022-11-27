# Ending a Transaction
-- Once a transaction has begun, whether explicitly via the start transaction command
-- or implicitly by the database server, you must explicitly end your transaction
-- for your changes to become permanent. You do this by way of the commit command,
-- which instructs the server to mark the changes as permanent and release any resources
-- (i.e., page or row locks) used during the transaction.

-- If you decide that you want to undo all the changes made since starting the transaction,
-- you must issue the rollback command, which instructs the server to return the
-- data to its pre-transaction state. After the rollback has been completed, any resources
-- used by your session are released.

-- Along with issuing either the commit or rollback command, there are several other
-- scenarios by which your transaction can end, either as an indirect result of your
-- actions or as a result of something outside your control:

-- • The server shuts down, in which case your transaction will be rolled back automatically
-- when the server is restarted.

-- • You issue an SQL schema statement, such as alter table, which will cause the
-- current transaction to be committed and a new transaction to be started.
-- As far as the second scenario is concerned, alterations to
-- a database, whether it be the addition of a new table or index or the removal of a column
-- from a table, cannot be rolled back, so commands that alter your schema must
-- take place outside a transaction. If a transaction is currently underway, therefore, the
-- server will commit your current transaction, execute the SQL schema statement command(
-- s), and then automatically start a new transaction for your session. The server
-- will not inform you of what has happened, so you should be careful that the statements
-- that comprise a unit of work are not inadvertently broken up into multiple
-- transactions by the server.

-- • You issue another start transaction command, which will cause the previous
-- transaction to be committed.

-- • The server prematurely ends your transaction because the server detects a deadlock
-- and decides that your transaction is the culprit. In this case, the transaction
-- will be rolled back, and you will receive an error message.
-- The fourth scenario deals with deadlock detection. A deadlock occurs when two different
-- transactions are waiting for resources that the other transaction currently
-- holds. For example, transaction A might have just updated the account table and is
-- waiting for a write lock on the transaction table, while transaction B has inserted a
-- row into the transaction table and is waiting for a write lock on the account table. If
-- both transactions happen to be modifying the same page or row (depending on the
-- lock granularity in use by the database server), then they will each wait forever for the
-- other transaction to finish and free up the needed resource. Database servers must
-- always be on the lookout for these situations so that throughput doesn’t grind to a
-- halt; when a deadlock is detected, one of the transactions is chosen (either arbitrarily
-- or by some criteria) to be rolled back so that the other transaction may proceed. Most
-- of the time, the terminated transaction can be restarted and will succeed without
-- encountering another deadlock situation.