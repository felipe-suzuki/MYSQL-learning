-- Rewrite the following query, which uses a simple case expression, so that the same
-- results are achieved using a searched case expression. 
-- Try to use as few when clauses as possible.

-- SELECT name,
-- CASE name
	-- WHEN 'English' THEN 'latin1'
	-- WHEN 'Italian' THEN 'latin1'
	-- WHEN 'French' THEN 'latin1'
	-- WHEN 'German' THEN 'latin1'
	-- WHEN 'Japanese' THEN 'utf8'
	-- WHEN 'Mandarin' THEN 'utf8'
	-- ELSE 'Unknown'
-- END character_set
-- FROM language;

SELECT name,
CASE name
	WHEN name IN ('English', 'Italian', 'French', 'German') THEN 'latin1'
    WHEN name IN ('Japanese', 'Mandarin') THEN 'utf8'
    ELSE 'Unkown'
END as character_set
FROM language;