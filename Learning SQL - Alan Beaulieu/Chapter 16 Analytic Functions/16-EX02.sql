-- Modify the query from the previous exercise to generate two sets of rankings 
-- from 1 to 12, one for 2019 data and one for 2020.

SELECT year_no, month_no, tot_sales,
rank() over (partition by year_no
order by year_no, tot_sales desc) AS sales_rank
FROM sales_fact;