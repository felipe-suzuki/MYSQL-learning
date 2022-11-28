#Window Frames
-- If you want to generate a running total starting from the beginning of the year
-- up to the current row. For these types of calculations, you can include a “frame”
-- subclause to define exactly which rows to include in the data window.
-- Here’s a query that sums payments for each week and includes a reporting function 
-- to calculate the rolling sum:
SELECT yearweek(payment_date) AS payment_week,
	sum(amount) AS week_total,
	sum(sum(amount)) 
		over (order by yearweek(payment_date) 
        rows unbounded preceding) AS rolling_sum
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

-- The rolling_sum column expression includes the rows unbounded preceding subclause
-- to define a data window from the beginning of the result set up to and including
-- the current row. The data window consists of a single row for the first row in the
-- result set, two rows for the second row, etc. The value for the last row is the 
-- summation of the entire result set.

-- Along with rolling sums, you can calculate rolling averages. Here’s a query that 
-- calculates a three-week rolling average of total payments:
SELECT yearweek(payment_date) AS payment_week,
	sum(amount) AS week_total,
	avg(sum(amount)) 
		over (order by yearweek(payment_date)
		rows between 1 preceding and 1 following) AS rolling_3wk_avg
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

-- Specifying a number of rows for your data window works fine in many cases, but if
-- there are gaps in your data, you might want to try a different approach. In the previous
-- result set, for example, there is data for weeks 200521, 200522, and 200524, but
-- no data for week 200523. If you want to specify a date interval rather than a number
-- of rows, you can specify a range for your data window, as shown in the following query:
SELECT date(payment_date), sum(amount),
	avg(sum(amount)) 
		over (order by date(payment_date)
		range between interval 3 day preceding
		and interval 3 day following) AS 7_day_avg
FROM payment
WHERE payment_date BETWEEN '2005-07-01' AND '2005-09-01'
GROUP BY date(payment_date)
ORDER BY 1;