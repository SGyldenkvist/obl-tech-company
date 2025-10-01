-- Obligatorisk opgave: Tech Company


-- SINGLE TABLE ASSIGNMENTS:

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

-- Use MIN, MAX, AVG, SUM, ORDER BY, BETWEEN and more.

-- Opgave 1: List the number of employees.
SELECT COUNT(*) AS total_employees FROM employees;

-- Opgave 2: List the sum of all salaries (excluding commission)
SELECT SUM(salary) AS total_salaries FROM employees;

-- Opgave 3: List the average salary for employees in department 20.
SELECT AVG(salary) AS average_salary FROM employees WHERE department_number = 20;

-- Opgave 4: List the unique job titles in the company.
SELECT DISTINCT job_title FROM employees ORDER BY job_title;

-- Opgave 5: List the number of employees in each department.
SELECT Count(*) AS total_employees, department_number FROM employees GROUP BY department_number;

-- Opgave 6: List in decreasing order the maximum salary in each department together with the department number.
SELECT department_number, MAX(salary) AS max_salary FROM employees GROUP BY department_number ORDER BY max_salary DESC;

-- Opgave 7: List total sum of salary and commission for all employees.
SELECT SUM(salary + IFNULL(commission, 0)) AS total_salary_and_commission FROM employees;


-- JOIN ASSIGMENTS:

/* Opgave 1: Create an INNER JOIN between employees and departments to get the department name for each employee.
 Show all columns.

   (De har department_number til fælles).*/

SELECT * FROM employees
    INNER JOIN departments
        ON employees.department_number = departments.department_number;


/* Opgave 2: Continue from the last task. Show two columns.
   The employee_name and their corresponding department_name.
   Oh, and can you sort them alphabetically (A-Z)?
 */

 SELECT employees.employee_name, departments.department_name
 FROM employees JOIN departments ON employees.department_number = departments.department_number
 ORDER BY employees.employee_name ASC;


/* Opgave 3: Now is the time to make a LEFT JOIN.
   Let's look at employee_name and department_name only.
   There is one more person this time who didn't show in the previous query.
   Who is it and why?

   (beholder left (FROM) table og tilføjer kun dem fra right (JOIN) ved dem de har til fælles)
   Så den viser alle ansatte også dem uden et department number, som King, der er "president" og derfor uden direkte "tilknytning".


 */


SELECT employees.employee_name, departments.department_name
FROM employees
    LEFT JOIN departments
    ON employees.department_number=departments.department_number;


-- Opgave 4: Consider this query:

SELECT departments.department_name, COUNT(employees.employee_number)
FROM employees
         JOIN departments
              ON departments.department_number = employees.department_number
GROUP BY department_name;

-- One department is missing. Which one and why? (Look in the database).
-- Det er department_name Operations med department_number 40 der mangler, fordi der ikke er nogle ansatte tilknyytet den afdeling.

-- Opgave 5: To get the missing department change the previous query to use a RIGHT JOIN.
SELECT departments.department_name, COUNT(employees.employee_number)
FROM employees
         RIGHT JOIN departments
              ON employees.department_number = departments.department_number
GROUP BY department_name;


/*
 Opgave 6: SCOTT sends you this query and asks you to run it.
 In order to assess whether it is information that SCOTT is privy to, you must first understand it.
 Describe in technical terms what this query does:

 */

SELECT *
FROM employees employee
         JOIN employees manager
              ON employee.manager_id = manager.employee_number
ORDER BY employee.employee_name;

/*
 "Vis alle kolonner fra tabellen employees, som vi kalder "employee"(alias),
 sæt tabellen employees sammen med tabellen employees, som vi kalder manager(alias),
 hvor mangager_id attributten i employees tabellen har samme værdi som employee_number i employees tabellen
 Sorter alfabetisk efter employee_name attributten fra employees tabellen."
 */

 -- Opgave 7: Get two columns: employees and their managers.

SELECT * FROM employees;

SELECT employee.employee_name, manager.employee_name
FROM employees employee
         JOIN employees manager
              ON employee.manager_id = manager.employee_number
ORDER BY employee.employee_name;

/* Opgave 8: Use the HAVING keyword (feel free to look it up) to show the departments with more than 3 employees.
   The as number_of_employees is so that you can reference the value later on in the query:

 */

SELECT employees.department_number, COUNT(employees.department_number) AS number_of_employees
FROM employees
GROUP BY department_number
HAVING COUNT(employees.department_number)>3;

/*
 Opgave 9: Subquery time!
 Select the name and salary of employees whose salary is above average:
 WHERE salary > (SELECT AVG(salary) FROM employees)
 */

 SELECT employee_name, salary FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);