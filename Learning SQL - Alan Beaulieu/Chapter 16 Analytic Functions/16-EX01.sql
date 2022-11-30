-- Write a query that retrieves every row from Sales_Fact, and add a column to generate
-- a ranking based on the tot_sales column values. The highest value should
-- receive a ranking of 1, and the lowest a ranking of 24.
SELECT * FROM sales_fact;

SELECT year_no, month_no, tot_sales,
row_number() over (order by tot_sales desc) AS sales_rank
FROM sales_fact;