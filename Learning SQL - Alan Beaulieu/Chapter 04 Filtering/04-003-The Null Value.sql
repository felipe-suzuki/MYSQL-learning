-- When working with null, you should remember:
-- • An expression can be null, but it can never equal null.
-- • Two nulls are never equal to each other.

# This query finds all film rentals that were never returned
SELECT 
    rental_id, customer_id
FROM
    rental
WHERE
    return_date IS NULL;

# Here’s the same query using = null instead of is null
SELECT 
    rental_id, customer_id
FROM
    rental
WHERE
    return_date = NULL;

# This query using  IS NOT NULL shows all film rentals returned
SELECT 
    rental_id, customer_id, return_date
FROM
    rental
WHERE
    return_date IS NOT NULL;
    
# Retrieve all rentals that were not returned during May through August of 2005
# Should include the NULL values, because otherwise would return only rentals
# that were returned before May or After August, and would exclude the rentals
# that were never returned.
SELECT 
    rental_id, customer_id, return_date
FROM
    rental
WHERE
    return_date IS NULL
        OR return_date NOT BETWEEN '2005-05-01' AND '2005-09-01';