-- Fill in the blanks (denoted by <#>) for this multitable query to achieve the following
-- results:
-- mysql> SELECT c.email, r.return_date
-- -> FROM customer c
-- -> INNER JOIN rental <1>
-- -> ON c.customer_id = <2>
-- -> WHERE date(r.rental_date) = '2005-06-14'
-- -> ORDER BY <3> <4>;
-- +---------------------------------------+---------------------+
-- | email | return_date |
-- +---------------------------------------+---------------------+
-- | DANIEL.CABRAL@sakilacustomer.org | 2005-06-23 22:00:38 |
-- | TERRANCE.ROUSH@sakilacustomer.org | 2005-06-23 21:53:46 |
-- | MIRIAM.MCKINNEY@sakilacustomer.org | 2005-06-21 17:12:08 |

SELECT 
    c.email, r.return_date
FROM
    customer AS c
        INNER JOIN
    rental AS r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14'
ORDER BY r.return_date DESC;