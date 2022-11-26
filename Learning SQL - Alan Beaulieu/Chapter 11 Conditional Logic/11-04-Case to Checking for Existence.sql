-- Here’s a query that uses multiple case expressions to generate three 
-- output columns, one to show whether the actor has appeared in G-rated films,
-- another for PG-rated films, and a third for NC-17-rated films:

SELECT a.first_name, a.last_name,
CASE
	WHEN EXISTS (SELECT 1 FROM film_actor AS fa
	INNER JOIN film AS f ON fa.film_id = f.film_id
	WHERE fa.actor_id = a.actor_id
	AND f.rating = 'G') THEN 'Y'
	ELSE 'N'
END AS g_actor,
CASE
	WHEN EXISTS (SELECT 1 FROM film_actor AS fa
	INNER JOIN film AS f ON fa.film_id = f.film_id
	WHERE fa.actor_id = a.actor_id
	AND f.rating = 'PG') THEN 'Y'
	ELSE 'N'
END AS pg_actor,
CASE
	WHEN EXISTS (SELECT 1 FROM film_actor AS fa
	INNER JOIN film AS f ON fa.film_id = f.film_id
	WHERE fa.actor_id = a.actor_id
	AND f.rating = 'NC-17') THEN 'Y'
	ELSE 'N'
END AS nc17_actor
FROM actor AS a
WHERE a.last_name LIKE 'S%' OR a.first_name LIKE 'S%';

-- In other cases, you may care how many rows are encountered, but only up to a point.
-- For example, the next query uses a simple case expression to count the number of
-- copies in inventory for each film and then returns either 'Out Of Stock', 'Scarce',
-- 'Available', or 'Common':
SELECT f.title,
CASE (SELECT count(*) FROM inventory AS i
WHERE i.film_id = f.film_id)
	WHEN 0 THEN 'Out Of Stock'
	WHEN 1 THEN 'Scarce'
	WHEN 2 THEN 'Scarce'
	WHEN 3 THEN 'Available'
	WHEN 4 THEN 'Available'
	ELSE 'Common'
END AS film_availability
FROM film AS f;