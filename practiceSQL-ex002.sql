#Exercise 2
#Find the lowest department number encountered in the 'dept_emp' table. 
#Then, find the highest department number.

USE employees;

SELECT 
    MIN(dept_no)
FROM
    dept_emp;

SELECT 
    MAX(dept_no)
FROM
    dept_emp;
