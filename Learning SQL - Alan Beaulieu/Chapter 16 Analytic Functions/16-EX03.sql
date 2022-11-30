-- Write a query that retrieves all 2020 data, and include a column that will 
-- contain the tot_sales value from the previous month.

SELECT year_no, month_no, tot_sales,
lag(tot_sales) over (order by month_no) AS prev_month_sales
FROM sales_fact
WHERE year_no = 2020;