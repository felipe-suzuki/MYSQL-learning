USE employees;

#Exercise 1
#Find the average salary of the male and female employees in each department. 

SELECT 
    d.dept_name, e.gender, ROUND(AVG(s.salary), 2) AS avg_salary
FROM
    salaries AS s
        JOIN
    employees AS e ON s.emp_no = e.emp_no
        JOIN
    dept_emp AS de ON e.emp_no = de.emp_no
        JOIN
    departments AS d ON de.dept_no = d.dept_no
GROUP BY d.dept_name , e.gender
ORDER BY d.dept_no , e.gender;