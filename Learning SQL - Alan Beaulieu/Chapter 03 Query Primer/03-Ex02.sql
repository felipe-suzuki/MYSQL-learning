-- Retrieve the actor ID, first name, and last name for all actors whose last name equals
-- 'WILLIAMS' or 'DAVIS'.

SELECT 
    actor_id, first_name, last_name
FROM
    actor
WHERE
    last_name = 'WILLIAMS'
        OR last_name = 'DAVIS';