# Natural Joins
-- allows you to name the tables to be joined but lets the database 
-- server determine what the join conditions need to be. Known as the 
-- natural join, this join type relies on identical column names across 
-- multiple tables to infer the proper join conditions.

SELECT c.first_name, c.last_name, date(r.rental_date)
FROM customer AS c
NATURAL JOIN rental AS r;