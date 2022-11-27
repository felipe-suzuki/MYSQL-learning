#Data Aggregation
-- Reporting applications generally require aggregated data, and views are a great way to
-- make it appear as though data is being preaggregated and stored in the database.
CREATE VIEW sales_by_film_category
AS
SELECT
	c.name AS category,
	SUM(p.amount) AS total_sales
FROM payment AS p
INNER JOIN rental AS r ON p.rental_id = r.rental_id
INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
INNER JOIN film AS f ON i.film_id = f.film_id
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_sales DESC;