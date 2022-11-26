# Handling Null Values
-- While null values are the appropriate thing to store in a table if the value 
-- for a column -- is unknown, it is not always appropriate to retrieve null values 
-- for display or to take part in expressions.

-- When retrieving the data, you can use a case expression to substitute the 
-- string if the value is null, as in:
SELECT c.first_name, c.last_name,
CASE
	WHEN a.address IS NULL THEN 'Unknown'
	ELSE a.address
END AS address,
CASE
	WHEN ct.city IS NULL THEN 'Unknown'
	ELSE ct.city
END AS city,
CASE
	WHEN cn.country IS NULL THEN 'Unknown'
	ELSE cn.country
END AS country
FROM customer AS c
LEFT OUTER JOIN address AS a
	ON c.address_id = a.address_id
LEFT OUTER JOIN city AS ct
	ON a.city_id = ct.city_id
LEFT OUTER JOIN country AS cn
	ON ct.country_id = cn.country_id;