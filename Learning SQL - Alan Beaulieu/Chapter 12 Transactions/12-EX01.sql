-- Generate a unit of work to transfer $50 from account 123 to account 789. You will
-- need to insert two rows into the transaction table and update two rows in the
-- account table. Use the following table definitions/data:

-- Account:
-- account_id 	avail_balance 	last_activity_date
-- ---------- 	------------- 	------------------
-- 123 			500 			2019-07-10 20:53:27
-- 789 			75 				2019-06-22 15:18:35

-- Transaction:
-- txn_id 		txn_date 		account_id 		txn_type_cd 	amount
-- --------- 	------------ 	----------- 	----------- 	--------
-- 1001 		2019-05-15 		123 			C 				500
-- 1002 		2019-06-01 		789 			C 				75

-- Use txn_type_cd = 'C' to indicate a credit (addition), and use txn_type_cd = 'D'
-- to indicate a debit (subtraction).

# CREATING AND POPULATING TABLES
CREATE TABLE account_ex12_1 (
	account_id SMALLINT,
    avail_balance DECIMAL(14,2),
    last_activity_date DATETIME);

INSERT INTO account_ex12_1 (account_id, avail_balance, last_activity_date)
	VALUES (123, 500, '2019-07-10 20:53:27'),
		(789, 75, '2019-06-22 15:18:35');

CREATE TABLE transaction_ex12_1 (
	txn_id SMALLINT,
    txn_date DATE,
    account_id SMALLINT,
    txn_type_cd ENUM('C','D'),
    amount DECIMAL(14,2));
    
INSERT INTO transaction_ex12_1 (txn_id, txn_date,  account_id, txn_type_cd, amount)
	VALUES (1001, '2019-05-15', 123, 'C', 500),
		(1002, '2019-06-01', 789, 'C', 75);

# EXECUTING THE TRANSACTION
START TRANSACTION;
	UPDATE account_ex12_1
	SET avail_balance = avail_balance - 50,
		last_activity_date = now()
		WHERE account_id = 123;
	UPDATE account_ex12_1	
	SET avail_balance = avail_balance + 50,
		last_activity_date = now()
		WHERE account_id = 789;        
    INSERT INTO transaction_ex12_1
	(txn_id, txn_date, account_id, txn_type_cd, amount)
		VALUES
			(1003, now(), 123, 'D', 50);
	INSERT INTO transaction_ex12_1
	(txn_id, txn_date, account_id, txn_type_cd, amount)
		VALUES
			(1004, now(), 789, 'C', 50);       
COMMIT;
