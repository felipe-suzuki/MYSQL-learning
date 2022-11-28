#Column Value Concatenation
-- The group_concat function is used to pivot a set of column values into a single 
-- delimited string, which is a handy way to denormalize your result set for generating 
-- XML or JSON documents. Here’s an example of how this function could be used to 
-- generate a comma-delimited list of actors for each film:
SELECT f.title,
group_concat(a.last_name order by a.last_name
	separator ', ') AS actors
FROM actor AS a
INNER JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
INNER JOIN film AS f
ON fa.film_id = f.film_id
GROUP BY f.title
HAVING count(*) = 3;

-- This query groups rows by film title and only includes films in which exactly three
-- actors appear. The group_concat function acts like a special type of aggregate 
-- function that pivots all of the last names of all actors appearing in each film into a
-- single string. If you are using SQL Server, you can use the string_agg function to
-- generate this type of output, and Oracle users can use the listagg function.