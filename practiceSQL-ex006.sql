#Exercise 6
/*Create a procedure that asks you to insert an employee number and that will obtain an output containing
the same number, as well as the number and name of the last department the employee has worked in.
Finally, call the procedure for employee number 10010.
If you've worked correctly, you should see that employee number 10010 has worked for department
number 6 - "Quality Management". */

DROP PROCEDURE IF EXISTS emp_last_dept;

DELIMITER $$
CREATE PROCEDURE emp_last_dept (IN p_emp_no INTEGER)
BEGIN
	SELECT
		e.emp_no, d.dept_no, d.dept_name
	FROM
		employees AS e
			JOIN
		dept_emp AS de ON e.emp_no = de.emp_no
			JOIN
		departments AS d ON de.dept_no = d.dept_no
	WHERE
		e.emp_no = p_emp_no
        AND de.from_date = (
        SELECT
			MAX(from_date)
		FROM
			dept_emp
		WHERE
			emp_no = p_emp_no);
END $$
DELIMITER ;

CALL employees.emp_last_dept(10010);
