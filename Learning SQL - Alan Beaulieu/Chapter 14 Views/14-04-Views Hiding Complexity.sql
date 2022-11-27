#Hiding Complexity
-- One of the most common reasons for deploying views is to shield end users from
-- complexity. For example, let’s say that a report is created each month showing information
-- about all of the films, along with the film category, the number of actors
-- appearing in the film, the total number of copies in inventory, and the number of
-- rentals for each film. Rather than expecting the report designer to navigate six different
-- tables to gather the necessary data, you could provide a view that looks as follows:
CREATE VIEW film_stats
AS
SELECT f.film_id, f.title, f.description, f.rating,
	(SELECT c.name
	FROM category AS c
	INNER JOIN film_category AS fc
	ON c.category_id = fc.category_id
	WHERE fc.film_id = f.film_id) AS category_name,
	(SELECT count(*)
	FROM film_actor AS fa
	WHERE fa.film_id = f.film_id
	) AS num_actors,
	(SELECT count(*)
	FROM inventory AS i
	WHERE i.film_id = f.film_id
	) AS inventory_cnt,
	(SELECT count(*)
	FROM inventory AS i
	INNER JOIN rental AS r
	ON i.inventory_id = r.inventory_id
	WHERE i.film_id = f.film_id
	) AS num_rentals
FROM film AS f;

-- This view definition is interesting because even though data from six different tables
-- can be retrieved through the view, the from clause of the query has only one table
-- (film). Data from the other five tables is generated using scalar subqueries. If someone
-- uses this view but does not reference the category_name, num_actors, inven
-- tory_cnt, or num_rentals column, then none of the subqueries will be executed.
-- This approach allows the view to be used for supplying descriptive information from
-- the film table without unnecessarily joining five other tables.