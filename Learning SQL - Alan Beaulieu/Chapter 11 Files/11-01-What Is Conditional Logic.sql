# What Is Conditional Logic?
-- Conditional logic is simply the ability to take one of several paths 
-- during program execution.

# CASE EXPRESSION
-- This query includes a case expression to generate a value for the activity_type column,
-- which returns the string “ACTIVE” or “INACTIVE” depending on the value of
-- the customer.active column.
SELECT 
    first_name,
    last_name,
    CASE
        WHEN active = 1 THEN 'ACTIVE'
        ELSE 'INACTIVE'
    END activity_type
FROM
    customer;