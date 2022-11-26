-- Write a query to return just the month portion of the current date.

SELECT MONTH(CURRENT_DATE());

 -- THE BOOK SOLUTION, SAME RESULT
 
 SELECT EXTRACT(MONTH FROM CURRENT_DATE());