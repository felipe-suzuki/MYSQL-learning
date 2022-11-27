#Why Use Views?
#Data Security
-- If you create a table and allow users to query it, they will be able to access every 
-- column and every row in the table. The best approach for these situations is to keep 
-- the table private and then to create one or more views that either omit or obscure 
-- the sensitive columns. You may also constrain which rows a set of users may access by 
-- adding a where clause to your view definition. 
-- For example, the next view definition excludes inactive customers:
CREATE VIEW active_customer_vw
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
FROM customer
WHERE active = 1;