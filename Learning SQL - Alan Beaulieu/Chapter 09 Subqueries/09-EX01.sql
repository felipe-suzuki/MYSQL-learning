-- Construct a query against the film table that uses a filter condition with a noncorrelated
-- subquery against the category table to find all action films (category.name = 'Action').

SELECT 
    film_id, title
FROM
    film
WHERE
    film_id IN (SELECT 
            fc.film_id
        FROM
            film_category AS fc
                JOIN
            category AS c ON fc.category_id = c.category_id
        WHERE
            c.name = 'Action');