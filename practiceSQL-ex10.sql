#Exercise 10
/*Based on the previous exercise, you can now try to create a third function that 
also accepts a second parameter. Let this parameter be a character sequence. 
Evaluate if its value is 'min' or 'max' and based on that retrieve either the 
lowest or the highest salary, respectively (using the same logic and code structure from Exercise 9). 
If the inserted value is any string value different from ‘min’ or ‘max’, let the function
return the difference between the highest and the lowest salary of that employee.*/

DROP FUNCTION IF EXISTS f_salary;

DELIMITER $$
CREATE FUNCTION f_salary (p_emp_no INTEGER, p_max_or_min VARCHAR(10)) RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN

DECLARE v_salary_info DECIMAL(10,2);

SELECT 
    CASE
        WHEN p_max_or_min = 'max' THEN MAX(s.salary)
        WHEN p_max_or_min = 'min' THEN MIN(s.salary)
        ELSE MAX(s.salary) - MIN(s.salary)
    END AS salary_info
INTO v_salary_info FROM
    employees AS e
        JOIN
    salaries AS s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;

RETURN v_salary_info;
END $$

DELIMITER ;

SELECT employees.f_salary(11356, 'min');
SELECT employees.f_salary(11356, 'max');
SELECT employees.f_salary(11356, 'mni');