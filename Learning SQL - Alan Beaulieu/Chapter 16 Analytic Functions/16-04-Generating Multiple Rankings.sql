#Generating Multiple Rankings
-- The example in the previous section generates a single ranking across the entire set of
-- customers, but what if you want to generate multiple sets of rankings within the same
-- result set? To extend the prior example, let’s say the marketing department decides to
-- offer free film rentals to the top five customers every month. To generate the data, the
-- rental_month column can be added to the previous query:
SELECT customer_id,
monthname(rental_date) AS rental_month,
count(*) AS num_rentals
FROM rental
GROUP BY customer_id, monthname(rental_date)
ORDER BY 2, 3 desc;

-- In order to create a new set of rankings for each month, you will need to add something
-- to the rank function to describe how to divide the result set into different data
-- windows (months, in this case). This is done using the partition by clause, which is
-- added to the over clause:
SELECT customer_id,
monthname(rental_date) AS rental_month,
count(*) AS num_rentals,
rank() over (partition by monthname(rental_date)
order by count(*) desc) AS rank_rnk
FROM rental
GROUP BY customer_id, monthname(rental_date)
ORDER BY 2, 3 desc;

-- Looking at the results, you can see that the rankings are reset to 1 for each month. In
-- order to generate the desired results for the marketing department (top five customers
-- from each month), you can simply wrap the previous query in a subquery and add
-- a filter condition to exclude any rows with a ranking higher than five:
SELECT customer_id, rental_month, num_rentals,
	rank_rnk AS ranking
FROM
	(SELECT customer_id,
	monthname(rental_date) AS rental_month,
	count(*) AS num_rentals,
	rank() over (partition by monthname(rental_date)
	order by count(*) desc) AS rank_rnk
	FROM rental
	GROUP BY customer_id, monthname(rental_date)
	) AS cust_rankings
WHERE rank_rnk <= 5
ORDER BY rental_month, num_rentals desc, rank_rnk;