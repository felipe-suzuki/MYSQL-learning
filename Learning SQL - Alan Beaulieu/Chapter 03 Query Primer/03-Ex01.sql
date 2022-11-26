-- Retrieve the actor ID, first name, and last name for all actors. Sort by last name and
-- then by first name.

SELECT 
    actor_id, first_name, last_name
FROM
    actor
ORDER BY last_name , first_name;