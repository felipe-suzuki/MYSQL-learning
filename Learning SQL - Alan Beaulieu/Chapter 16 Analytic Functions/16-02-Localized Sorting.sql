#Localized Sorting
-- Along with partitioning your result set into data windows for your analytic functions,
-- you may also specify a sort order. For example, if you want to define a ranking number
-- for each month, where the value 1 is given to the month having the highest sales, you 
-- will need to specify which column (or columns) to use for the ranking:

SELECT quarter(payment_date) AS quarter,
monthname(payment_date) AS month_nm,
sum(amount) AS monthly_sales,
rank() over (order by sum(amount) desc) AS sales_rank
FROM payment
WHERE year(payment_date) = 2005
GROUP BY quarter(payment_date), monthname(payment_date)
ORDER BY 1, month(payment_date);

-- In some cases, you will want to use both the partition by and order by subclauses in 
-- the same analytic function call. For example, the previous example can be modified to 
-- provide a different set of rankings per quarter, rather than a single ranking across
-- the entire result set:
SELECT quarter(payment_date) AS quarter,
monthname(payment_date) AS month_nm,
sum(amount) AS monthly_sales,
rank() over (partition by quarter(payment_date)
order by sum(amount) desc) AS qtr_sales_rank
FROM payment
WHERE year(payment_date) = 2005
GROUP BY quarter(payment_date), monthname(payment_date)
ORDER BY 1, month(payment_date);