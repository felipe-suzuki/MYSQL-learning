/*Task 4
Create an SQL stored procedure that will allow you to obtain the average male
and female salary per department within a certain salary range. 
Let this range be defined by two values the user can insert when calling the procedure.*/

USE employees_mod;

DROP PROCEDURE IF EXISTS filter_salary;

DELIMITER $$
CREATE PROCEDURE filter_salary (IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN
SELECT
	e.gender, d.dept_name, AVG(s.salary) AS avg_salary
FROM
	t_salaries AS s
		JOIN
	t_employees AS e ON s.emp_no = e.emp_no
		JOIN
	t_dept_emp AS de ON de.emp_no = e.emp_no
		JOIN
	t_departments AS d ON d.dept_no = de.dept_no
    WHERE s.salary BETWEEN p_min_salary AND p_max_salary
GROUP BY d.dept_no, e.gender;
END $$

DELIMITER ;

CALL filter_salary(50000, 90000);