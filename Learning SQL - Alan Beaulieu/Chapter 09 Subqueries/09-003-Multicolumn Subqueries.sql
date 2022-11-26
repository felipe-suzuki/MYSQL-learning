-- Multicolumn Subqueries -----------------------------------------------------
-- It is possible to use subqueries that return two or more columns.
SELECT 
    fa.actor_id, fa.film_id
FROM
    film_actor AS fa
WHERE
    fa.actor_id IN (SELECT 
            actor_id
        FROM
            actor
        WHERE
            last_name = 'MONROE')
        AND fa.film_id IN (SELECT 
            film_id
        FROM
            film
        WHERE
            rating = 'PG');
            
