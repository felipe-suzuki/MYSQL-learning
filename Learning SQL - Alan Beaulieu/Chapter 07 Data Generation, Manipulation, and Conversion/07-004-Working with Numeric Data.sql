-- You can type a number, retrieve it from another column,
-- or generate it via a calculation. All the usual arithmetic operators (+, -, *, /) are available
-- for performing calculations, and parentheses may be used to dictate precedence
SELECT (37 * 59) / (78 - (8 * 6));

-- Performing Arithmetic Functions ------------------------------------
-- Table 7-1. Single-argument numeric functions

-- Function name 		Description
-- acos( x ) 			Calculates the arc cosine of x
-- asin( x ) 			Calculates the arc sine of x
-- atan( x ) 			Calculates the arc tangent of x
-- cos( x ) 			Calculates the cosine of x
-- cot( x ) 			Calculates the cotangent of x
-- exp( x ) 			Calculates e^x
-- ln( x ) 				Calculates the natural log of x
-- sin( x ) 			Calculates the sine of x
-- sqrt( x ) 			Calculates the square root of x
-- tan( x ) 			Calculates the tangent of x

-- MOD() -------------------------------------------------------
-- the modulo operator, which calculates the remainder when one number
-- is divided into another number, is implemented in MySQL and Oracle Database via
-- the mod() function
SELECT MOD(10, 4);

-- While the mod() function is typically used with integer arguments, with MySQL you
-- can also use real numbers
SELECT MOD(22.75, 5);

-- POW() --------------------------------------------------------
-- returns one number raised to the power of a second number
SELECT POW(2, 8);

-- Controlling Number Precision -----------------------------------
-- Four functions are useful when limiting the precision of floating-point numbers: 
-- ceil(), floor(), round(), and truncate()

-- CEIL() AND FLOOR() -------------------------------------------
-- functions are used to round either up or down to the closest integer
SELECT CEIL(72.445), FLOOR(72.445);

-- Remember that ceil() will round up even if the decimal portion of a number is very small
-- floor() will round down even if the decimal portion is quite significant 
SELECT CEIL(72.000000001), FLOOR(72.999999999);

-- ROUND() --------------------------------------------------
-- round up or down from the midpoint between two integers
SELECT ROUND(72.49999), ROUND(72.5), ROUND(72.50001);

-- round() allows to specify how many digits to the 
-- right of the decimal place to round to.
SELECT ROUND(72.0909, 1), ROUND(72.0909, 2), ROUND(72.0909, 3);

-- TRUNCATE() -------------------------------------------------
-- simply discards the unwanted digits without rounding.
SELECT 
    TRUNCATE(72.0909, 1),
    TRUNCATE(72.0909, 2),
    TRUNCATE(72.0909, 3);

-- Both truncate() and round() also allow a negative value for the second argument,
-- meaning that numbers to the left of the decimal place are truncated or rounded.
SELECT ROUND(17, - 1), TRUNCATE(17, - 1);

-- Handling Signed Data --------------------------------------------------------
-- Numeric columns that allow negative values

-- Let’s say, for example, that you are asked to generate a
-- report showing the current status of a set of bank
-- accounts using the following data from the account table
-- +------------+--------------+---------+
-- | account_id | acct_type    | balance |
-- +------------+--------------+---------+
-- | 123 		| MONEY MARKET | 785.22	 |
-- | 456 		| SAVINGS 	   | 0.00    |
-- | 789		| CHECKING	   | -324.22 |
-- +------------+--------------+---------+
-- The following query returns three columns useful for generating the report:
-- mysql> SELECT account_id, SIGN(balance), ABS(balance)
-- -> FROM account;
-- +------------+---------------+--------------+
-- | account_id | SIGN(balance) | ABS(balance) |
-- +------------+---------------+--------------+
-- | 123 		| 1 			| 785.22	   |
-- | 456 		| 0 			| 0.00 		   |
-- | 789        | -1 			| 324.22 	   |
-- +------------+---------------+--------------+
-- 3 rows in set (0.00 sec)