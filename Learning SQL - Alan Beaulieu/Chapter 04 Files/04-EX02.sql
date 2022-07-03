-- This is the subset of rows that we should work with. --------------------------
SELECT 
    payment_id, customer_id, amount, DATE(payment_date)
FROM
    payment
WHERE
    payment_id BETWEEN 101 AND 120; 
    
# Which of the payment IDs would be returned by the following filter conditions?
# customer_id = 5 AND NOT (amount > 6 OR date(payment_date) = '2005-06-19')
SELECT 
    payment_id, customer_id, amount, DATE(payment_date)
FROM
    payment
WHERE
    payment_id BETWEEN 101 AND 120
        AND customer_id = 5
        AND NOT (amount > 6
        OR DATE(payment_date) = '2005-06-19');