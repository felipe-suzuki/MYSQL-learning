-- Construct a query that returns all addresses that are in 
-- the same city. You will need to join the address table to 
-- itself, and each row should include two different addresses.

SELECT 
    add1.address, add2.address, c.city
FROM
    address AS add1
        INNER JOIN
    address AS add2 ON add1.city_id = add2.city_id
        INNER JOIN
    city AS c ON add1.city_id = c.city_id
WHERE
    add1.address <> add2.address;