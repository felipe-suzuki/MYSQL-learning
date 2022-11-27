#What Are Views?
-- A view is simply a mechanism for querying data. Unlike tables, views do not involve
-- data storage; you won’t need to worry about views filling up your disk space.

-- As a simple example, let’s say that you want to partially obscure the email address in
-- the customer table. The marketing department, for example, may need access to
-- email addresses in order to advertise promotions, but otherwise your company’s privacy
-- policy dictates that this data be kept secure. Therefore, instead of allowing direct
-- access to the customer table, you define a view called customer_vw and mandate that
-- all nonmarketing personnel use it to access customer data. Here’s the view definition:

CREATE VIEW customer_vw
	(customer_id,
	first_name,
	last_name,
	email
	)
AS
SELECT
	customer_id,
	first_name,
	last_name,
	concat(substr(email,1,2), '*****', substr(email, -4)) email
FROM customer;

-- When the create view statement is executed, the database server simply stores the view 
-- definition for future use; the query is not executed, and no data is retrieved or stored. 
-- Once the view has been created, users can query it just like they would a table, as in:
SELECT first_name, last_name, email
FROM customer_vw;

-- Even though the customer_vw view definition includes four columns of the customer
-- table, the previous query retrieves only three of the four.

-- If you want to know what columns are available in a view, you can use MySQL’s 
-- (or Oracle’s) describe command to examine it:
DESCRIBE customer_vw;

-- You are free to use any clauses of the select statement when querying through a
-- view, including group by, having, and order by. Here’s an example:
SELECT first_name, count(*), min(last_name), max(last_name)
FROM customer_vw
WHERE first_name LIKE 'J%'
GROUP BY first_name
HAVING count(*) > 1
ORDER BY 1;

-- In addition, you can join views to other tables (or even to other views) 
-- within a query, as in:
SELECT cv.first_name, cv.last_name, p.amount
FROM customer_vw AS cv
INNER JOIN payment AS p
ON cv.customer_id = p.customer_id
WHERE p.amount >= 11;