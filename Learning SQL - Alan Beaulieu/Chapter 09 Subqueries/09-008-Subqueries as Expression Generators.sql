#Subqueries as Expression Generators
-- Along with being used in filter conditions, scalar subqueries
-- may be used wherever an expression can appear, including the select and order by
-- clauses of a query and the values clause of an insert statement.

SELECT 
    (SELECT 
            c.first_name
        FROM
            customer AS c
        WHERE
            c.customer_id = p.customer_id) AS first_name,
    (SELECT 
            c.last_name
        FROM
            customer AS c
        WHERE
            c.customer_id = p.customer_id) AS last_name,
    (SELECT 
            ct.city
        FROM
            customer AS c
                INNER JOIN
            address AS a ON c.address_id = a.address_id
                INNER JOIN
            city AS ct ON a.city_id = ct.city_id
        WHERE
            c.customer_id = p.customer_id) AS city,
    SUM(p.amount) AS tot_payments,
    COUNT(*) AS tot_rentals
FROM
    payment AS p
GROUP BY p.customer_id;

-- There are two main differences between this query and the earlier version using a
-- subquery in the from clause:
-- • Instead of joining the customer, address, and city tables to the payment data,
-- correlated scalar subqueries are used in the select clause to look up the customer’s
-- first/last names and city.
-- • The customer table is accessed three times (once in each of the three subqueries)
-- rather than just once.