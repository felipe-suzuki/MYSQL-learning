#Analytic Function Concepts
#Data Windows
-- Let’s say you have written a query that generates monthly sales totals for a given 
-- time period. For example, the following query sums up the total monthly payments for
-- film rentals for the period May through August 2005:

SELECT quarter(payment_date) AS quarter,
monthname(payment_date) AS month_nm,
sum(amount) AS monthly_sales
FROM payment
WHERE year(payment_date) = 2005
GROUP BY quarter(payment_date), monthname(payment_date);

-- Looking at the results, you can see that July had the highest monthly total across 
-- all four months and that June had the highest monthly total for quarter 2. In order 
-- to determine the highest values programmatically, however, you will need to add 
-- additional columns to each row showing the maximum values per quarter and over the 
-- entire time period. 
-- Here’s the previous query but with two new columns to calculate these values:
SELECT quarter(payment_date) AS quarter,
monthname(payment_date) AS month_nm,
sum(amount) AS monthly_sales,
max(sum(amount))
over () AS max_overall_sales,
max(sum(amount))
over (partition by quarter(payment_date)) AS max_qrtr_sales
FROM payment
WHERE year(payment_date) = 2005
GROUP BY quarter(payment_date), monthname(payment_date);

-- To accommodate this type of analysis, analytic functions include the ability to group
-- rows into windows, which effectively partition the data for use by the analytic function
-- without changing the overall result set. Windows are defined using the over clause 
-- combined with an optional partition by subclause. In the previous query, both analytic 
-- functions include an over clause, but the first one is empty, indicating that the window
-- should include the entire result set, whereas the second one specifies that the window 
-- should include only rows within the same quarter.
-- Data windows may contain anywhere from a single row to all of the rows in the result set,
-- and different analytic functions can define different data windows.