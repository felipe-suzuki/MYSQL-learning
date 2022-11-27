-- Generate an alter table statement for the rental table so that an error will be
-- raised if a row having a value found in the rental.customer_id column is deleted
-- from the customer table.
ALTER TABLE rental
ADD CONSTRAINT fk_rental_customer_id FOREIGN KEY (customer_id)
REFERENCES customer (customer_id) ON DELETE RESTRICT ON UPDATE CASCADE;