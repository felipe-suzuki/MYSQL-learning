# Three-Way Outer Joins
-- Outer-join one table with two other tables

SELECT 
    f.film_id, f.title, i.inventory_id, r.rental_date
FROM
    film AS f
        LEFT JOIN
    inventory AS i ON f.film_id = i.film_id
        LEFT JOIN
    rental AS r ON i.inventory_id = r.inventory_id
WHERE
    f.film_id BETWEEN 13 AND 15;
