#Exercise 3
/* Obtain a table containing the following three fields for all individuals whose employee number is not
greater than 10040:
- employee number
- the lowest department number among the departments where the employee has worked in (Hint: use
a subquery to retrieve this value from the 'dept_emp' table)
- assign '110022' as 'manager' to all individuals whose employee number is lower than or equal to 10020,
and '110039' to those whose number is between 10021 and 10040 inclusive.
Use a CASE statement to create the third field.
If you've worked correctly, you should obtain an output containing 40 rows */

SELECT 
    e.emp_no,
    (SELECT 
            MIN(dept_no)
        FROM
            dept_emp AS de
        WHERE
            e.emp_no = de.emp_no) AS dept_no,
    CASE
        WHEN e.emp_no <= 10020 THEN 110022
        ELSE 110039
    END AS manager
FROM
    employees AS e
WHERE
    emp_no <= 10040;