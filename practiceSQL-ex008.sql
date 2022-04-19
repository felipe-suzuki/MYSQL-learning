#Exercise 8

/*Create a trigger that checks if the hire date of an employee is higher than the current date. If true, set the
hire date to equal the current date. Format the output appropriately (YY-mm-dd).
Extra challenge: You can try to declare a new variable called 'today' which stores today's data, and then
use it in your trigger!
After creating the trigger, execute the following code to see if it's working properly. 

INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC;
*/

DROP TRIGGER IF EXISTS trig_check_hire_date;

DELIMITER $$
CREATE TRIGGER trig_check_hire_date
BEFORE INSERT ON employees

FOR EACH ROW
BEGIN
	DECLARE today DATE;
SELECT DATE_FORMAT(SYSDATE(), '%Y-%m-%d') INTO today;
    
    IF NEW.hire_date > today THEN
		SET NEW.hire_date = today;
	END IF;
END $$

DELIMITER ;

INSERT employees VALUES ('999905', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC;
