-- This is the subset of rows that we should work with. --------------------------
SELECT 
    payment_id, customer_id, amount, DATE(payment_date)
FROM
    payment
WHERE
    payment_id BETWEEN 101 AND 120; 
    
# Which of the payment IDs would be returned by the following filter conditions?
-- customer_id <> 5 AND (amount > 8 OR date(payment_date) = '2005-08-23')
SELECT 
    payment_id, customer_id, amount, DATE(payment_date)
FROM
    payment
WHERE
    payment_id BETWEEN 101 AND 120
        AND customer_id <> 5
        AND (amount > 8
        OR DATE(payment_date) = '2005-08-23');

-- IT WOULD RETURN payment_id 101 and 107. ---------------------