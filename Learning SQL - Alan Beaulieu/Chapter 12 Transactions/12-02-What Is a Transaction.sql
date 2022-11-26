# What Is a Transaction?
-- This element is necessary to allow multiple users to access the same data.
-- It is a device for grouping together multiple SQL statements such that either 
-- all or none of the statements succeed (a property known as atomicity).

-- The example below try to transfer $500 from savings account to checking account:
START TRANSACTION;

/* withdraw money from first account, making sure balance is sufficient */
UPDATE account SET avail_balance = avail_balance - 500
	WHERE account_id = 9988
	AND avail_balance > 500;
IF <exactly one row was updated by the previous statement> THEN
	/* deposit money into second account */
	UPDATE account SET avail_balance = avail_balance + 500
	WHERE account_id = 9989;
	IF <exactly one row was updated by the previous statement> THEN
		/* everything worked, make the changes permanent */
		COMMIT;
		ELSE
		/* something went wrong, undo all changes in this transaction */
		ROLLBACK;
	END IF;
ELSE
	/* insufficient funds, or error encountered during update */
	ROLLBACK;
END IF;

-- The previous code block begins by starting a transaction and then attempts to remove
-- $500 from the checking account and add it to the savings account. If all goes well, the
-- transaction is committed; if anything goes awry, however, the transaction is rolled
-- back, meaning that all data changes since the beginning of the transaction are
-- undone.