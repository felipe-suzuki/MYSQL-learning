/*Task 2
Compare the number of male managers to the number of female managers
from different departments for each year, starting from 1990.*/

SELECT 
    d.dept_name,
    ee.gender,
    dm.emp_no,
    dm.from_date,
    dm.to_date,
    e.calendar_year,
    CASE
        WHEN
            YEAR(dm.to_date) >= e.calendar_year
                AND YEAR(dm.from_date) <= e.calendar_year
        THEN
            1
        ELSE 0
    END AS active
FROM
    (SELECT 
        YEAR(hire_date) AS calendar_year
    FROM
        t_employees
    GROUP BY calendar_year) AS e
        CROSS JOIN
    t_dept_manager AS dm
        JOIN
    t_departments AS d ON dm.dept_no = d.dept_no
        JOIN
    t_employees AS ee ON dm.emp_no = ee.emp_no
ORDER BY dm.emp_no , calendar_year;