# Trying to retrieve the IDs of all actors who appeared in a film, will have duplicates
SELECT 
    actor_id
FROM
    film_actor
ORDER BY actor_id;

# Adding the keyword DISTINCT will retrieve only distinct values
SELECT DISTINCT
    actor_id
FROM
    film_actor
ORDER BY actor_id;

