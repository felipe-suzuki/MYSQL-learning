# Searched case Expressions
-- The CASE expression demonstrated earlier in the chapter is an example of
-- a searched CASE expression, which has the following syntax:

-- CASE
-- WHEN C1 THEN E1
-- WHEN C2 THEN E2
-- ...
-- WHEN CN THEN EN
-- [ELSE ED]
-- END

-- In the previous definition, the symbols C1, C2, ..., CN represent conditions, and the
-- symbols E1, E2, ..., EN represent expressions to be returned by the case expression. If
-- the condition in a when clause evaluates to true, then the case expression returns the
-- corresponding expression. Additionally, the ED symbol represents the default expression,
-- which the case expression returns if none of the conditions C1, C2, ..., CN evaluate to true.

-- All the expressions returned by the various clauses must evaluate to when
-- the same type (e.g., date, number, varchar).

-- Here’s an example of a searched case expression:
SELECT 
    c.first_name,
    c.last_name,
    CASE
        WHEN active = 0 THEN 0
        ELSE (SELECT 
                COUNT(*)
            FROM
                rental AS r
            WHERE
                r.customer_id = c.customer_id)
    END num_rentals
FROM
    customer AS c;