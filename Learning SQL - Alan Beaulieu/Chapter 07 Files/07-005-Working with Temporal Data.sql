-- the date on which I wrote this paragraph can be described in all the following ways:
-- • Wednesday, June 5, 2019
-- • 6/05/2019 2:14:56 P.M. EST
-- • 6/05/2019 19:14:56 GMT
-- • 1562019 (Julian format)
-- • Star date [−4] 97026.79 14:14:56 (Star Trek format)

-- Dealing with Time Zones --------------------------------------------
-- MySQL keeps two different time zone settings: a global time zone and a session time
-- zone, which may be different for each user logged in to a database. You can see both
-- settings via the following query:
SELECT @@GLOBAL .time_zone, @@SESSION .time_zone;

-- to set a new time zone, should use the command:
#SET time_zone = 'Specific Zone Name';

-- Generating Temporal Data ----------------------------------------
-- You can generate temporal data via any of the following means:
-- • Copying data from an existing date, datetime, or time column 
-- • Executing a built-in function that returns a date, datetime, or time
-- • Building a string representation of the temporal data to be evaluated by the server

-- String representations of temporal data --------------------------
-- Table 7-2. Date format components
-- Component 		Definition 					Range
-- YYYY 			Year, including century 	1000 to 9999
-- MM 				Month 						01 (January) to 12 (December)
-- DD 				Day 						01 to 31
-- HH 				Hour 						00 to 23
-- HHH 				Hours (elapsed) 			−838 to 838
-- MI 				Minute						00 to 59
-- SS 				Second 						00 to 59

#To build a string that the server can interpret as a date, datetime, 
-- or time, you need to put the various components together in the order:
-- Table 7-3. Required date components
-- Type 		Default format
-- date 		YYYY-MM-DD
-- datetime 	YYYY-MM-DD HH:MI:SS
-- timestamp 	YYYY-MM-DD HH:MI:SS
-- time 		HHH:MI:SS

-- Thus, to populate a datetime column with 3:30 P.M. on September 17, 2019, you will
-- need to build the following string: '2019-09-17 15:30:00'

-- here’s a statement used to modify the return date of a film rental:
UPDATE rental 
SET 
    return_date = '2019-09-17 15:30:00'
WHERE
    rental_id = 99999;
    
-- String-to-date conversions -------------------------------------
-- If the server is not expecting a datetime value or if you would like to represent the
-- datetime using a nondefault format, you will need to tell the server to convert the
-- string to a datetime. For example, here is a simple query that returns a datetime
-- value using the cast() function:
SELECT CAST('2019-09-17 15:30:00' AS DATETIME);

-- The following query uses the cast() function to generate a date value
-- and a time value:
SELECT 
    CAST('2019-09-17' AS DATE) date_field,
    CAST('108:17:57' AS TIME) time_field;
    
-- When strings are converted to temporal values—whether explicitly or implicitly—
-- you must provide all the date components in the required order.
-- MySQL is more flexible and will accept all of the following strings as valid
-- representations of 3:30 P.M. on September 17, 2019:
-- '2019-09-17 15:30:00'
-- '2019/09/17 15:30:00'
-- '2019,09,17,15,30,00'
-- '20190917153000'

-- Functions for generating dates --------------------------------
-- Generate temporal data from a string not properly formatted
-- you need to use a built-in function that allows you to
-- provide a format string along with the date string. 
-- MySQL includes the str_to_date() function for this purpose.

UPDATE rental 
SET 
    return_date = STR_TO_DATE('September 17, 2019', '%M %d, %Y')
WHERE
    rental_id = 99999;

-- The second argument in the call to str_to_date() defines the format of the date
-- string, with, in this case, a month name (%M), a numeric day (%d), and a four-digit
-- numeric year (%Y)

-- Table 7-4. Date format components
-- Format component 			Description
-- %M Month name 				(January to December)
-- %m Month numeric 			(01 to 12)
-- %d Day numeric 				(01 to 31)
-- %j Day of year 				(001 to 366)
-- %W Weekday name 				(Sunday to Saturday)
-- %Y 							Year, four-digit numeric
-- %y 							Year, two-digit numeric
-- %H 							Hour (00 to 23)
-- %h 							Hour (01 to 12)
-- %i 							Minutes (00 to 59)
-- %s							Seconds (00 to 59)
-- %f 							Microseconds (000000 to 999999)
-- %p 							A.M. or P.M.

-- Generate the current date/time using built-in functions
SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();