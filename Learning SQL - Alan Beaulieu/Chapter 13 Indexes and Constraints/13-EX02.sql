-- Generate a multicolumn index on the payment table that could be 
-- used by both of the following queries:

#SELECT customer_id, payment_date, amount
#FROM payment
#WHERE payment_date > cast('2019-12-31 23:59:59' as datetime);

#SELECT customer_id, payment_date, amount
#FROM payment
#WHERE payment_date > cast('2019-12-31 23:59:59' as datetime)
#AND amount < 5;

ALTER TABLE payment
ADD INDEX idx_pmnt_date_amt (payment_date, amount);

EXPLAIN SELECT customer_id, payment_date, amount
FROM payment
WHERE payment_date > cast('2019-12-31 23:59:59' as datetime);