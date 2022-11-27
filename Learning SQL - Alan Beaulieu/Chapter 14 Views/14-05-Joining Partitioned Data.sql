#Joining Partitioned Data
-- Some database designs break large tables into multiple pieces in order to improve
-- performance. For example, if the payment table became large, the designers may
-- decide to break it into two tables: payment_current, which holds the latest six
-- months of data, and payment_historic, which holds all data up to six months ago. If
-- a customer wants to see all the payments for a particular customer, you would need to
-- query both tables. By creating a view that queries both tables and combines the
-- results together, however, you can make it look like all payment data is stored in a
-- single table. Here’s the view definition:
CREATE VIEW payment_all
	(payment_id,
	customer_id,
	staff_id,
	rental_id,
	amount,
	payment_date,
	last_update
	)
AS
SELECT payment_id, customer_id, staff_id, rental_id,
amount, payment_date, last_update
FROM payment_historic
UNION ALL
SELECT payment_id, customer_id, staff_id, rental_id,
amount, payment_date, last_update
FROM payment_current;
