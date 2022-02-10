/*HR Schema Tables */
--Employees - Employee Details
--Departments - DEpattment Details
--Locations -Locations Details
--jobs -JOb Details


--Q1. Write the command to print out the structure (describe) of the following tables:
DESC Employees;
DESC Departments;
DESC Locations;
DESC jobs;

--Q2.  Write a query to display the full name (first and last name), and salary for those employees who earn below 3000.
SELECT FIRST_NAME||''||LAST_NAME AS FULL_NAME
FROM EMPLOYEES
WHERE SALARY < 5000;

--Q3. Write a query to display all the information for all employees without a department id.
SELECT EMPNO,FIRST_NAME,LAST_NAME,JOB_id,MANAGER_ID,SALARY,COMMISSION_PCT
FROM  EMPLOYEES;

--Q4. Write a query to display the first and last name, email, salary and manager ID, for those employees whose managers hold the ID 100, 120 ,145, 149.
SELECT FIRST_NAME,LAST_NAME,EMAIL,SALARY,MANAGER_ID
FROM  EMPLOYEES
WHERE MANAGER_ID IN (100,120,145,149);

--Q5. Write a query to display the full name, salary commission percentage (as a decimal is fine), department Id and Hire Date of employees whose salary is in the range of 10000 and 13000 and commission is not null and they have been hired before June 5th, 2005.
SELECT   FIRST_NAME||’ ‘||LAST_NAME AS FULL_NAME,
                  COMMISSION_PCT,
                  DEPARTMENT_ID,
                  HIREDATE
FROM      EMPLOYEES
WHERE   SALARY BETWEEN 10000 AND 13000
        AND COMMISSION_PCT IS NOT NULL
        AND TRUNC(HIREDATE) < ’05-JUN-2005′;

--Q6. What is the average, maximum and minimum salary for each department. Well formatted output. (if an employee had no department still include it in your results)
SELECT AVG(SALARY),
                 MAX(SALARY),
                 MIN(SALARY),
                 DEPARTMENT_ID
FROM     EMPLOYEES
GROUP BY DEPARTMENT_ID;

--Q7. a) How many Employees are there? b) How many is each department?
SELECT  COUNT(DEPARTMENT_ID)
FROM     EMPLOYEES
GROUP BY DEPARTMENT_ID;

SELECT  COUNT(COUNT(DEPARTMENT_ID))
FROM     EMPLOYEES
GROUP BY DEPARTMENT_ID;

--Q8. Display all employees first name, salary and proposed pay whose salary is between 2000 and 5000 and a proposed pay increase of 10% for them.
SELECT FIRST_NAME,
                 SALARY,
                 round (sal*10/100) proposed_pay
FROM    EMPLOYEES
WHERE SALARY BETWEEN 2000 AND 5000;

--Q9. Display all employees, first name, their salary, and their total pay (Total pay is their salary plus commission. Commission is calculated from the commission_pct column which is salary * commission_pct)
SELECT FIRST_NAME,
                 SALARY,
                 (SALARY*COMMISSION_PCT) AS TOTAL_PAY
FROM     EMPLOYEES;

--Q10. What is the minimum salaries grouped by department id for those groups having a minimum salary less than 5000. Listed by the minimum salary.
SELECT  DEPARTMENT_ID
                  MIN(SALARY),
FROM      EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING SALARY < 5000;

Important SQL on Table Joins in Oracle Database (Questions and Answers)
--Q11. Display the first name, last name, department number, and department name for each employee order by employee last name.
SELECT  e.FIRST_NAME,
                 e.LAST_NAME,
                 d.DEPARTMENT_ID,
                 d.DEPARTMENT_NAME
FROM     EMPLOYEES e,
                 DEPARTMENTS d
WHERE  e.DEPARTMENT_ID = d.DEPARTMENT_ID
ORDER BY e.LAST_NAME;

--Q12. Display all employees (employee_id, department name and id) even those that have not been assigned a department, order by department id in descending order.
SELECT   e.EMPLOYEE_ID,
                  (SELECT DEPARTMENT_NAME FROM DEPARTMENTS WHERE DEPARTMENT_ID =                    e.DEPARTMENT_ID)DEPARTMENT_NAME,
                  (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID = e.DEPARTMENT_ID)DEPARTMENT_ID
FROM      EMPLOYEES e
ORDER BY e.DEPARTMENT_ID desc;

--Q13. Display for all employees, their name, their job title, their department name, the city they are located in, the country name and the region.
SELECT  e.employee_id,
                  e.last_name,
                  e.first_name,
                   j.job_title,
                   d.department_name ,
                   l.city ,
                   c.country_name,
                   r.region_name
FROM      Employees e,
                  Jobs j,
                  Departments d,
                  Locations l,
                  Countries c,
                  Regions r
WHERE  e.department_id = d.department_id
         and e.job_id = j.job_id
 AND d.location_id = l.location_id
        AND l.country_id = c.country_id
        AND c.country_id = r.country_id;

--Q14. Display the names and hire dates for all employees who were hired before their managers, along with their manager’s names and hire dates. Label the columns Employee, Emp Hired, Manager, and Mgr Hired, respectively and format your dates like 30-02-2015 (‘dd-mm-yyyy’).
SELECT  E1.FIRST_NAME employee,
                  E1.hiredate emp_hired,
                  E2.FIRST_NAME manager,
                  e2.hiredate mgr_hired
FROM      EMPLOYEES E1,EMPLOYEES E2
WHERE   E1.MANAGER_ID=E2.EMPLOYEE_ID
         AND E1.MANAGER_ID < E2.MANAGER_ID;

Important SQL Subqueries (Questions and Answers)
--Q15. Display today’s date as ‘Report Date’ and the current number of employees and number of departments in the organization.
SELECT  sysdate “Report Date”,
                (SELECT count(*) FROM Employees) “Number of Employees”,
                (SELECT count(*) FROM Departments) “Number of Departments”
FROM    Dual;

--Q16. Find the top 5 job titles with the highest average salary.
SELECT *
from       (SELECT job_id,
                                  avg (salary),
                                  count(*)
                 FROM employees
                 group by job_id
                 order by avg (salary) desc)
where      rownum <=5;

--Q16. List the employees who earn more than the average salary and who work in the IT department.
SELECT   *
FROM      Employees e, departments d
WHERE   e.department_id = d.department_id
         AND salary > (SELECT avg (salary) from Employeesa and job_id = ‘IT_PROG’);
