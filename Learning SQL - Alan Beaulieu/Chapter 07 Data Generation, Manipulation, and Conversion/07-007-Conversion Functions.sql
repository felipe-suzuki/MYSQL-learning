-- CAST() --

-- To use cast(), you provide a value or expression, the as keyword, and the type to
-- which you want the value converted. Here’s an example that converts a string to an
-- integer:
SELECT CAST('1456328' AS SIGNED INTEGER);

-- When converting a string to a number, the cast() function will attempt to convert
-- the entire string from left to right; any nonnumeric character will be discarded.
SELECT CAST('999ABC111' AS UNSIGNED INTEGER);