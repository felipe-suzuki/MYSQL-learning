-- Join the following query to a subquery against the film_actor table to show the level
-- of each actor:

-- 		SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
-- 		UNION ALL
-- 		SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
-- 		UNION ALL
-- 		SELECT 'Newcomer' level, 1 min_roles, 19 max_roles

-- The subquery against the film_actor table should count the number of rows for each
-- actor using group by actor_id, and the count should be compared to the
-- min_roles/max_roles columns to determine which level each actor belongs to.

SELECT 
    fa.actor_id,
    a.first_name,
    a.last_name,
    level_grps.level,
    fa.tot_films AS total_roles
FROM
    actor AS a
        INNER JOIN
    (SELECT 
        actor_id, COUNT(*) AS tot_films
    FROM
        film_actor
    GROUP BY actor_id) AS fa 
    ON a.actor_id = fa.actor_id
        INNER JOIN
    (SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles 
     UNION ALL SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles 
     UNION ALL SELECT 'Newcomer' level, 1 min_roles, 19 max_roles) AS level_grps 
     ON fa.tot_films BETWEEN level_grps.min_roles AND level_grps.max_roles;