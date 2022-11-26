-- Rewrite the following query so that the result set contains a single row with five columns
-- (one for each rating). Name the five columns G, PG, PG_13, R, and NC_17.
-- SELECT rating, count(*)
-- FROM film
-- GROUP BY rating;
-- +--------+----------+
-- | rating | count(*) |
-- +--------+----------+
-- | PG 	| 194 	   |
-- | G 		| 178      |
-- | NC-17 	| 210      |
-- | PG-13 	| 223      |
-- | R 		| 195 	   |
-- +--------+----------+

SELECT
SUM(CASE
	WHEN rating = 'PG' THEN 1
	ELSE 0
	END) AS PG_rating,
SUM(CASE
	WHEN rating = 'G' THEN 1
	ELSE 0
	END) AS G_rating,
SUM(CASE
	WHEN rating = 'NC-17' THEN 1
	ELSE 0
	END) AS NC17_rating,
SUM(CASE
	WHEN rating = 'PG-13' THEN 1
	ELSE 0
	END) AS PG13_rating,
SUM(CASE
	WHEN rating = 'R' THEN 1
	ELSE 0
	END) AS R_rating
FROM film;