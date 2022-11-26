-- Rework the query from Exercise 9-1 using a correlated subquery against the category
-- and film_category tables to achieve the same results.

SELECT 
    f.film_id, f.title
FROM
    film AS f
WHERE
    'Action' = (SELECT 
            c.name
        FROM
            film_category AS fc
                JOIN
            category AS c ON fc.category_id = c.category_id
        WHERE
            fc.film_id = f.film_id);