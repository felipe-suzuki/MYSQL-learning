#Ranking Functions
-- There are multiple ranking functions available in the SQL standard, with each one
-- taking a different approach to how ties are handled:
# row_number
-- Returns a unique number for each row, with rankings arbitrarily assigned in case of a tie
# rank
-- Returns the same ranking in case of a tie, with gaps in the rankings
# dense_rank
-- Returns the same ranking in case of a tie, with no gaps in the rankings

-- Say that the marketing department wants to identify the top 10 customers so they can be 
-- offered a free film rental. The following query determines the number of film rentals for 
-- each customer and sorts the results in descending order:
SELECT customer_id, count(*) AS num_rentals
FROM rental
GROUP BY customer_id
ORDER BY 2 desc;

-- To see how each function handles ties when assigning rankings, the next query adds
-- three more columns, each one employing a different ranking function:
SELECT customer_id, count(*) AS num_rentals,
row_number() over (order by count(*) desc) AS row_number_rnk,
rank() over (order by count(*) desc) AS rank_rnk,
dense_rank() over (order by count(*) desc) AS dense_rank_rnk
FROM rental
GROUP BY customer_id
ORDER BY 2 desc;