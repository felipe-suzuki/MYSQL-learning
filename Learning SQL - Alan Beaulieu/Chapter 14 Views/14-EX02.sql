-- The film rental company manager would like to have a report that includes the name
-- of every country, along with the total payments for all customers who live in each
-- country. Generate a view definition that queries the country table and uses a scalar
-- subquery to calculate a value for a column named tot_payments.

CREATE VIEW country_tot_pmnt
AS
SELECT c.country,
	(SELECT sum(p.amount)  
    FROM payment AS p
	INNER JOIN customer AS cust
		ON p.customer_id = cust.customer_id
	INNER JOIN address AS a
		ON cust.address_id = a.address_id
	INNER JOIN city AS ct
		ON a.city_id = ct.city_id
    WHERE ct.city_id = c.country_id   
	)  AS tot_payments
FROM country AS c;

SELECT country, tot_payments
FROM country_tot_pmnt;
	