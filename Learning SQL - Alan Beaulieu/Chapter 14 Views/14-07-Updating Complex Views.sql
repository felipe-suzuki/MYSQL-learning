#Updating Complex Views
-- While single-table views are certainly common, many of the views that you come
-- across will include multiple tables in the from clause of the underlying query. 
-- The next view, for example, joins the customer, address, city, and country tables 
-- so that all the data for customers can be easily queried:
CREATE VIEW customer_details
AS
SELECT c.customer_id,
	c.store_id,
	c.first_name,
	c.last_name,
	c.address_id,
	c.active,
	c.create_date,
	a.address,
	ct.city,
	cn.country,
	a.postal_code
FROM customer AS c
INNER JOIN address AS a
	ON c.address_id = a.address_id
INNER JOIN city AS ct
	ON a.city_id = ct.city_id
INNER JOIN country AS cn
	ON ct.country_id = cn.country_id;
    
-- You may use this view to update data in either the customer or address table, 
-- as the following statements demonstrate:
UPDATE customer_details
SET last_name = 'SMITH-ALLEN', active = 0
WHERE customer_id = 1;

UPDATE customer_details
SET address = '999 Mockingbird Lane'
WHERE customer_id = 1;

-- The first statement modifies the customer.last_name and customer.active columns,
-- whereas the second statement modifies the address.address column. You might be 
-- wondering what happens if you try to update columns from both tables in a single 
-- statement, so let’s find out:
UPDATE customer_details
SET last_name = 'SMITH-ALLEN',
active = 0,
address = '999 Mockingbird Lane'
WHERE customer_id = 1;

-- As you can see, you are allowed to modify both of the underlying tables separately,
-- but not within a single statement.