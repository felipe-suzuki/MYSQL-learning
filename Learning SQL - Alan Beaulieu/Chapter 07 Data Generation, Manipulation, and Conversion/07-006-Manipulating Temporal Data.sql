-- Temporal functions that return dates --------------------------------------
-- MySQL’s date_add() function, allows you to add any kind
-- of interval to a specified date to generate another date.
-- Here’s an example that demonstrates how to add five days to the current date:
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY);

-- Table 7-5. Common interval types
-- Interval name 			Description
-- second 					Number of seconds
-- minute 					Number of minutes
-- hour 					Number of hours
-- day 						Number of days
-- month 					Number of months
-- year 					Number of years
-- minute_second 			Number of minutes and seconds, separated by “:”
-- hour_second 				Number of hours, minutes, and seconds, separated by “:”
-- year_month 				Number of years and months, separated by “-”

-- If you are told that a film was actually returned 3 hours, 27 minutes, and 11 seconds
-- later than what was originally specified, you can fix it via the following:
UPDATE rental 
SET 
    return_date = DATE_ADD(return_date,
        INTERVAL '3:27:11' HOUR_SECOND)
WHERE
    rental_id = 99999;
    
-- Or, if you work in HR and found out that employee ID 4789 claimed to be older than
-- he actually is, you could add 9 years and 11 months to his birth date, as in:
UPDATE employee 
SET 
    birth_date = DATE_ADD(birth_date,
        INTERVAL '9-11' YEAR_MONTH)
WHERE
    emp_id = 4789;

-- LAST DAY() --
-- 
-- Whether you provide a date or datetime value, the last_day() function always
-- returns a date. Although this function may not seem like an enormous time-saver,
-- the underlying logic can be tricky if you’re trying to find the last day of February and
-- need to figure out whether the current year is a leap year.

-- If the customer asks for the transfer on September 17, 2019, you could find the 
-- last day of September via the following:
SELECT LAST_DAY('2019-09-17');

-- Temporal functions that return strings -----------------------------------
-- MySQL includes the dayname() function to determine
-- which day of the week a certain date falls on, as in:
SELECT DAYNAME('2019-09-18');

-- EXTRACT FUNCTION --
-- The extract() function uses the same interval types as the date_add() function 
-- to define which element of the date interests you. For example, if you want
-- to extract just the year portion of a datetime value, you can do the following:
SELECT EXTRACT(YEAR FROM '2019-09-18 22:19:05');

-- Temporal functions that return numbers -----------------------------------------
-- Take two date values and determine the number of intervals between them.
-- function datediff(), which returns the number of full days between two dates,
-- and it does ignore the time of the day in arguments.
SELECT DATEDIFF('2019-09-03', '2019-06-21'); # returns 74 days

SELECT 
    DATEDIFF('2019-09-03 23:59:59',
            '2019-06-21 00:00:01'); # returns 74 days too!

-- If using the earlier date first, datediff() will return a negative
-- number, as in:
SELECT DATEDIFF('2019-06-21', '2019-09-03');