#Exercise 9
/*Define a function that retrieves the largest contract salary value of an employee. Apply it to employee
number 11356.
In addition, what is the lowest contract salary value of the same employee? You may want to create a new
function that to obtain the result. */

DROP FUNCTION IF EXISTS f_highest_salary;

DELIMITER $$
CREATE FUNCTION f_highest_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

DECLARE v_highest_salary DECIMAL(10,2);

SELECT 
    MAX(s.salary)
INTO v_highest_salary FROM
    employees AS e
        JOIN
    salaries AS s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;

RETURN v_highest_salary;
END $$

DELIMITER ;

SELECT f_highest_salary(11356);

DROP FUNCTION IF EXISTS f_lowest_salary;

DELIMITER $$
CREATE FUNCTION f_lowest_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN

DECLARE v_lowest_salary DECIMAL(10,2);

SELECT
	MIN(s.salary)
INTO v_lowest_salary FROM
	employees AS e
		JOIN
	salaries AS s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;
    
RETURN v_lowest_salary;
END $$

DELIMITER ;

SELECT F_LOWEST_SALARY(11356);