-- Create a view definition that can be used by the following query to generate 
-- the given results:
SELECT title, category_name, first_name, last_name
FROM film_ctgry_actor
WHERE last_name = 'FAWCETT';

-- +---------------------+---------------+------------+-----------+
-- | title				 | category_name | first_name | last_name |
-- +---------------------+---------------+------------+-----------+
-- | ACE GOLDFINGER		 | Horror		 |		  BOB |	  FAWCETT |
-- | ADAPTATION HOLES	 | Documentary	 | BOB		  |	  FAWCETT |
-- | CHINATOWN GLADIATOR |			 New |	 	  BOB |	  FAWCETT |
-- | CIRCUS YOUTH 		 | Children 	 |		  BOB |	  FAWCETT |
-- ................................................................
-- | WAIT CIDER 		 |	   Animation |	    JULIA |	  FAWCETT |
-- +---------------------+---------------+------------+-----------+
-- 40 rows in set (0.00 sec)

CREATE VIEW film_ctgry_actor
	(title,
    category_name,
    first_name,
    last_name
    )
AS
SELECT
	f.title,
    c.name,
    a.first_name,
    a.last_name
FROM
	film AS f
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id
	INNER JOIN category AS c
		ON fc.category_id = c.category_id
	INNER JOIN film_actor AS fa
		ON f.film_id = fa.film_id
	INNER JOIN actor AS a
		ON fa.actor_id = a.actor_id;
    
