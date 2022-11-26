-- WHERE ----------------------------------------------------------
# The where clause is the mechanism for filtering out unwanted rows from your result set.

# where clause to retrieve only the films rating G and rental_duration >=7
# returns 29 rows
SELECT 
    title
FROM
    film
WHERE
    rating = 'G' AND rental_duration >= 7;
    
# Changing the operator from AND to OR
# Returns 340 rows
SELECT 
    title
FROM
    film
WHERE
    rating = 'G' OR rental_duration >= 7;

# Retrieving only those films that are rated G and are available for 7
# or more days, or are rated PG-13 and are available 3 or fewer days
SELECT 
    title, rating, rental_duration
FROM
    film
WHERE
    (rating = 'G' AND rental_duration >= 7)
        OR (rating = 'PG-13' AND rental_duration < 4);