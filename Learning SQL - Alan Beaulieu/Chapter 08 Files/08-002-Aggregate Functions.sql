-- Aggregate Functions --
-- Aggregate functions perform a specific operation over all rows in a group. Although
-- every database server has its own set of specialty aggregate functions, the common
-- aggregate functions implemented by all major servers include:

# max() -> Returns the maximum value within a set
# min() -> Returns the minimum value within a set
# avg() -> Returns the average value across a set
# sum() -> Returns the sum of the values across a set
# count() -> Returns the number of values in a set

-- Here’s a query that uses all of the common aggregate functions to 
-- analyze the data on film rental payments:

SELECT 
    MAX(amount) max_amt,
    MIN(amount) min_amt,
    AVG(amount) avg_amt,
    SUM(amount) tot_amt,
    COUNT(*) num_payments
FROM
    payment;

-- Implicit Versus Explicit Groups --
-- Since there is no group by clause, there is a single, implicit group (all
-- rows in the payment table).

-- Extend the previous query to execute the same five aggregate functions
-- for each customer, instead of across all customers.
SELECT 
    customer_id,
    MAX(amount) max_amt,
    MIN(amount) min_amt,
    AVG(amount) avg_amt,
    SUM(amount) tot_amt,
    COUNT(*) num_payments
FROM
    payment
GROUP BY customer_id;

-- Counting Distinct Values --
-- When using the count() function to determine the number of members in each
-- group, you have your choice of counting all members in the group or counting 
-- only the distinct values for a column across all members of the group.
SELECT 
    COUNT(customer_id) num_rows,
    COUNT(DISTINCT customer_id) num_customers
FROM
    payment;

-- Using Expressions --
-- Along with using columns as arguments to aggregate functions, you can use 
-- expressions as well. 
-- The maximum number  of days between when a film was rented and subsequently returned. 
SELECT 
    MAX(DATEDIFF(return_date, rental_date))
FROM
    rental;

-- How Nulls Are Handled --
-- When performing aggregations or any type of numeric calculation, 
-- consider how null values might affect the outcome of your calculation.
-- The set {1, 3, 5} will be used as example:

CREATE TABLE number_tbl (
    val SMALLINT
);

INSERT INTO number_tbl VALUES (1);

INSERT INTO number_tbl VALUES (3);

INSERT INTO number_tbl VALUES (5);

SELECT 
    COUNT(*) num_rows,
    COUNT(val) num_vals,
    SUM(val) total,
    MAX(val) max_val,
    AVG(val) avg_val
FROM
    number_tbl;

# Add a null value to the number_tbl table and run the query again:
INSERT INTO number_tbl VALUES (NULL);

SELECT 
    COUNT(*) num_rows,
    COUNT(val) num_vals,
    SUM(val) total,
    MAX(val) max_val,
    AVG(val) avg_val
FROM
    number_tbl;
    
-- Even with the addition of the null value to the table, the sum(), max(), and avg()
-- functions all return the same values, indicating that they ignore any null values
-- encountered.
-- count(*) function now returns the value 4, but count(val) returns the value 3  