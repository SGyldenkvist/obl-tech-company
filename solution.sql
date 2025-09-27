-- Obligatorisk opgave: Tech Company

-- Min test:
SELECT * FROM employees;

-- Opgave 1: Find the employee number for employees named MARTIN

SELECT employee_number FROM employees WHERE employee_name='Martin';

-- Opgave 2: Find the employee(s) with a salary greater than 1500.

SELECT * FROM employees WHERE salary > 1500;

-- Opgave 3: List the names of salesmen that earn more than 1300.
SELECT employee_name FROM employees WHERE job_title='salesman' AND salary>=1300;

-- Opgave 4: List the names of employees that are not salesmen.

SELECT employee_name FROM employees WHERE job_title!='salesman';

-- Opgave 5: List the names of all clerks together with their salary with a deduction of 10%.
SELECT employee_name, salary * 0.9 AS salary_after_deduction FROM employees WHERE job_title='clerk';

-- Opgave 6: Find the name of employees hired before May 1981.
SELECT employee_name FROM employees WHERE hire_date < '1981-05-01';


-- Opgave 7: List employees sorted by salary in descending order (i.e. highest salary first).

SELECT * FROM employees ORDER BY salary DESC;


-- Min "test":
SELECT * FROM departments;

-- Opgave 8: List departments sorted by location.

SELECT * FROM departments ORDER BY office_location;

-- Opgave 9: Find name of the department located in New York.
SELECT department_name FROM departments WHERE office_location='New York';

/*
Opgave 10: You have proven your worth at the company.
Your colleague comes to you trying to remember what's-his-name.
It starts with a J and ends with S. Can you help her?
 */

SELECT employee_name FROM employees WHERE employee_name LIKE 'J%S';

/*
Opgave 11:Maybe that wasn't helpful.
"Oh yeah, I remember now!" they say and tell you that he is a manager.
 */

SELECT employee_name FROM employees WHERE employee_name LIKE 'J%S' AND job_title='manager';

-- Opgave 12: How many employees are there in each department?

SELECT department_number, COUNT(*) AS number_of_emplyees_dep FROM employees GROUP BY department_number;



-- AGGREGATE FUNCTIONS:

-- Opgave 1: