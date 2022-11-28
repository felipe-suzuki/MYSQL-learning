#Reporting Functions
-- Along with generating rankings, another common use for analytic functions is to find
-- outliers (e.g., min or max values) or to generate sums or averages across an entire
-- data set. For these types of uses, you will be using aggregate functions (min, max, avg,
-- sum, count), but instead of using them with a group by clause, you will pair them
-- with an over clause. Here’s an example that generates monthly and grand totals for all
-- payments of $10 or higher:
SELECT monthname(payment_date) AS payment_month,
	amount,
	sum(amount)
over (partition by monthname(payment_date)) AS monthly_total,
sum(amount) over () AS grand_total
FROM payment
WHERE amount >= 10
ORDER BY 1;

-- While it may seem of little value to include a column such as grand_total with the
-- same value for every row, these types of columns can also be used for calculations, 
-- as shown in the following query:
SELECT monthname(payment_date) AS payment_month,
	sum(amount) AS month_total,
	round(sum(amount) / sum(sum(amount)) over () * 100, 2) AS pct_of_total
FROM payment
GROUP BY monthname(payment_date);

-- Reporting functions may also be used for comparisons, such as the next query, which
-- uses a case expression to determine whether a monthly total is the max, min, or
-- somewhere in the middle:
SELECT monthname(payment_date) AS payment_month,
	sum(amount) AS month_total,
CASE sum(amount)
	WHEN max(sum(amount)) over () THEN 'Highest'
	WHEN min(sum(amount)) over () THEN 'Lowest'
	ELSE 'Middle'
END AS descriptor
FROM payment
GROUP BY monthname(payment_date);