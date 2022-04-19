#Exercise 5

/*Retrieve a list of all employees from the ‘titles’ table who are engineers.
Repeat the exercise, this time retrieving a list of all employees from the ‘titles’ table who are senior
engineers.
After LIKE, you could indicate what you are looking for with or without using parentheses. Both options are
correct and will deliver the same output. We think using parentheses is better for legibility and that’s why
it is the first option we’ve suggested. */

SELECT 
    *
FROM
    titles
WHERE
    title LIKE '%Engineer%';
    
SELECT 
    *
FROM
    titles
WHERE
    title LIKE '%senior engineer%';
	