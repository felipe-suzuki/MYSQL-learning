#Updatable Views
-- If you provide users with a set of views to use for data retrieval, what should you do if
-- the users also need to modify the same data? It might seem a bit strange, for example,
-- to force the users to retrieve data using a view but then allow them to directly modify
-- the underlying table using update or insert statements. For this purpose, MySQL,
-- Oracle Database, and SQL Server all allow you to modify data through a view, as long
-- as you abide by certain restrictions. In the case of MySQL, a view is updatable if the
-- following conditions are met:

-- • No aggregate functions are used (max(), min(), avg(), etc.).
-- • The view does not employ group by or having clauses.
-- • No subqueries exist in the select or from clause, and any subqueries in the
-- where clause do not refer to tables in the from clause.
-- • The view does not utilize union, union all, or distinct.
-- • The from clause includes at least one table or updatable view.
-- • The from clause uses only inner joins if there is more than one table or view.

#Updating Simple Views
-- The customer_vw view queries a single table, and only one of the four columns is
-- derived via an expression.
-- Let’s use the view to update Mary Smith’s last name to Smith-Allen:
UPDATE customer_vw
SET last_name = 'SMITH-ALLEN'
WHERE customer_id = 1;

-- Checking the change just to make sure:
SELECT first_name, last_name, email
FROM customer
WHERE customer_id = 1;

-- While you can modify most of the columns in the view in this fashion, you will not
-- be able to modify the email column, since it is derived from an expression:
UPDATE customer_vw
SET email = 'MARY.SMITH-ALLEN@sakilacustomer.org'
WHERE customer_id = 1;

-- Views that contain derived columns cannot be used for inserting data, even if the 
-- derived columns are not included in the statement. For example, the next statement 
-- attempts to populate only the customer_id, first_name, and last_name columns using 
-- the customer_vw view:
INSERT INTO customer_vw
(customer_id,
first_name,
last_name)
VALUES (99999,'ROBERT','SIMPSON');