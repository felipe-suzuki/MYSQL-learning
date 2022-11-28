#Lag and Lead
-- They can be used to complete tasks comparing values from one row to another.
-- lag: will retrieve a column value from a prior row in the result set
-- lead: will retrieve a column value from a following row

-- Create a column showing the percentage difference for the weekly sales 
-- totals from one week to the prior week. First let's get the weekly sales totals: 
SELECT yearweek(payment_date) AS payment_week,
	sum(amount) AS week_total,
	lag(sum(amount), 1)
	over (order by yearweek(payment_date)) AS prev_wk_tot,
	lead(sum(amount), 1)
	over (order by yearweek(payment_date)) AS next_wk_tot
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

-- Here’s how you could use the lag function to generate the percentage difference 
-- from the prior week:
SELECT yearweek(payment_date) AS payment_week,
	sum(amount) AS week_total,
	round((sum(amount) - lag(sum(amount), 1)
		over (order by yearweek(payment_date)))
		/ lag(sum(amount), 1)
			over (order by yearweek(payment_date))
		* 100, 1) AS pct_diff
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;