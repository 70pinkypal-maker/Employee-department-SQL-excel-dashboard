CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);


CREATE TABLE JOB
(JOB_ID INT PRIMARY KEY,
DESIGNATION VARCHAR(20) );

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT, 
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT,
 FOREIGN KEY(JOB_ID) REFERENCES JOB(JOB_ID),
 foreign key(DEPARTMENT_ID)
REFERENCES DEPARTMENT(DEPARTMENT_ID));

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'1984-12-17',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'1984-02-20',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'1985-04-04',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'1985-05-15',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'1985-06-10',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'1985-02-22',1250,500,30)
                             -- Simple Queries: 
-- List all the employee details
Select * from employee;
-- List all the department details
select * from department;
-- List all the job details
select * from job;
-- List all the location details
select * from location;
-- list out the First Nmae, Last Name, Salary, Commission for all employees
Select First_Name, last_Name, Salary, Comm from employee
-- List out the Employee ID, Last Name, Department ID for all employees and Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".
select employee_ID AS 'ID of the employee',
 last_Name As 'name of the employee',
 department_ID AS 'dep_ID' from employee;
 
-- List out the annual salary of the employees with their names only. 
select First_Name, Last_Name,
salary * 12 AS 'annual_salary'
from employee

									-- WHERE Condition: 
-- 1. List the details about "Smith". 
select * from employee
where Last_Name = 'SMITH' ;
-- 2. List out the employees who are working in department 20. 
select * from employee
where DEpartment_ID = 20;
-- 3. List out the employees who are earning salary between 2000 and 3000. 
select * from employee
where salary between 2000 and 3000;
-- 4. List out the employees who are working in department 10 or 20. 
select * from employee
where Department_ID in (10,20)
-- 5. Find out the employees who are not working in department 10 or 30. 
select * from employee
where Department_ID  not in (10,20)
-- 6. List out the employees whose name starts with 'L'. 
select * from employee
where first_name like 'L%'
-- 7. List out the employees whose name starts with 'L' and ends with 'E'
select * from employee
where first_name like 'L%E'
-- 8. List out the employees whose name length is 4 and start with 'J'. 
select * from employee
where first_Name like 'J___' ;
-- 9. List out the employees who are working in department 30 and draw the salaries more than 2500. 
select * from employee
where department_ID = 30
and salary > 2500;
-- 10. List out the employees who are not receiving commission.
select * from employee
where COMM IS NULL
                                           --  ORDER BY Clause: 
-- 1. List out the Employee ID and Last Name in ascending order based on the Employee ID. 
select employee_ID, Last_name from employee
order by Employee_ID ASC ;
-- 2. List out the Employee ID and Name in descending order based on salary. 
select employee_ID, First_Name Last_name from employee
order by SALARY DESC ;
-- 3. List out the employee details according to their Last Name in ascending-order. 
select * from employee
order by Last_Name ASC ;
-- 4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.
select * from employee
order by Last_Name ASC, Department_ID DESC
                                     -- GROUP BY and HAVING Clause: 
-- 1. List out the department wise maximum salary, minimum salary and average salary of the employees. 
select department_ID, max(salary) AS max_salary,
min(salary) AS min_salary,
avg(salary) AS avg_salary
from employee
group by department_ID
-- 2. List out the job wise maximum salary, minimum salary and average salary of the employees. 
select Job_ID,
 max(salary) AS max_salary,
min(salary) AS min_salary,
avg(salary) AS avg_salary
from employee
group by Job_ID
-- 3. List out the number of employees who joined each month in ascending order. 
select month(HIRE_DATE) AS month_n0,
count(*) As total_employees
from employee
group by month(HIRE_DATE)
order by month_n0 ASC
-- 4. List out the number of employees for each month and year in ascending order based on the year and month. 
select year(HIRE_DATE) AS year ,
month(HIRE_DATE) AS month,
count(*) As total_employees
from employee
group by year(HIRE_DATE),  month(HIRE_DATE)
order by  year, month ;
-- 5. List out the Department ID having at least four employees. 
select department_ID,
count(*) AS total_employees
from employee
group by department_ID
having count(*) >= 4
-- 6. How many employees joined in February month. 
select count(*) AS total_employees
from employee
where month(HIRE_DATE) =2 ;
-- 7. How many employees joined in May or June month. 
select count(*) AS total_employees
from employee
where month(HIRE_DATE) IN (5,6) ;
-- 8. How many employees joined in 1985? 
select count(*) AS total_employees
from employee
where year(HIRE_DATE) = 1985 ;
-- 9. How many employees joined each month in 1985? 
select month(HIRE_DATE) AS month_n0,
count(*) AS total_employees
from employee
where year(HIRE_DATE) = 1985 
group by month(HIRE_DATE)
order by month_n0

-- 10. How many employees were joined in April 1985? 
select count(*) as total_employees
from employee
where year(HIRE_DATE) = 1985
and month(HIRE_DATE) =4;
-- 11. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
select department_ID, 
count(*) AS total_employees
from employee
where year(HIRE_DATE) = 1985
and month(HIRE_DATE) =4
group  by department_ID
having count(*) >= 3 

                                                -- Joins:
-- 1. List out employees with their department names.
select e.FIRST_NAME,
e.LAST_NAME,
d.NAME AS departmnt_name
from employee e
join department d
on e.department_ID = d.department_ID ;

-- 2. Display employees with their designations. 
select e.First_Name,
e.Last_Name,
j.designation
from employee e
join job j
on e.job_ID = j.job_ID

-- 3. Display the employees with their department names and city. 
select e.First_Name,
e.Last_Name,
d.Name AS Department_Name,
l.city
from employee e
join department d 
on e.department_ID = d.department_ID
join location l
on d.location_Id = l.location_ID ;

-- 4. How many employees are working in different departments? Display with department names. 
select d.name AS Department_name,
count(*) AS total_employees
from employee e 
 join department d
 on e.department_ID = d.department_ID
 group by d.name;
-- 5. How many employees are working in the sales department? 
select count(*) AS total_employees
from employee e 
 join department d
 on e.department_ID = d.department_ID
 where d.name = 'sales'
-- 6. Which is the department having greater than or equal to 3 employees and display the department names in ascending order. 
select d.name AS department_name,
count(*) AS total_employees
from employee e 
 join department d
 on e.department_ID = d.department_ID
 group by d.name
 having count(*) >= 3
 order by d.name ASC
 -- 7. How many employees are working in 'Dallas'? 
 select count(*) AS total_employees
 from employee e
 join department d 
 on e.department_ID = d.department_ID
 join location l
 on d.location_ID = l.location_ID
 where l.city = 'DALLAS'
-- 8. Display all employees in sales or operation departments.
select e.First_Name,
e.Last_Name,
d.name
from employee e
join department d
on e.department_ID = d.department_ID
where d.name IN ('SALES', 'OPERATIONS')
                                                  --- CONDITIONAL STATEMENT 
-- 1. Display the employee details with salary grades. Use conditional statement to create a grade column.  
select *,
CASE
when SALARY < 1000 then 'grade A'
when SALARY between 1000 and 1999 then 'grade B'
when SALARY between 2000 and 2999 then 'grade C'
when SALARY between 3000 and 5000 then 'grade D'
else 'grade E'
END AS grade from employee

-- 2. List out the number of employees grade wise. Use conditional statement to create a grade column. 
select 
CASE
when SALARY < 1000 then 'grade A'
when SALARY between 1000 and 1999 then 'grade B'
when SALARY between 2000 and 2999 then 'grade C'
when SALARY between 3000 and 5000 then 'grade D'
else 'grade E'
END AS grade,
count(*) AS total_eemployees from employee
group by grade

-- 3. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
select 
CASE
when SALARY between 2000 and 2999 then 'grade C'
when SALARY between 3000 and 5000 then 'grade D'
else 'grade E'
END AS grade,
count(*) AS total_eemployees from employee
where SALARY between 2000 and 5000
group by grade
                                           -- Subqueries: 
-- 1. Display the employees list who got the maximum salary. 
select * from employee 
where salary = ( select MAX(salary) 
from employee);

-- 2. Display the employees who are working in the sales department. 
select * from employee
where department_ID = ( select department_Id 
from department
where NAME = 'sales' )
-- 3. Display the employees who are working as 'Clerk'. 
select * from employee
where job_ID = ( select job_Id
from job
where designation = 'clerk')
-- 4. Display the list of employees who are living in 'Boston'. 
select * from employee
where department_ID IN ( 
select department_ID from department
where location_ID = (
select location_ID from location 
where city = 'BOSTON' ) )
-- 5. Find out the number of employees working in the sales department. 
select count(*) AS total_Employees
from employee
where department_ID = (
select department_ID from department 
where name = 'sales' )
-- 6. Update the salaries of employees who are working as clerks on the basis of 10%. 
update employee
set salary = salary *1.10
where job_ID = (
select job_ID from job
where designation = 'clerk')
-- 7. Display the second highest salary drawing employee details. 
select * from employee 
where salary =(
select MAX(salary) from employee
where salary < (select MAX(salary) 
from employee ) ) ;
-- 8. List out the employees who earn more than every employee in department 30. 
select * from employee
where salary > ( 
select MAX(salary)
from employee
where department_ID = 30 )


-- 9. Find out which department has no employees. 
select * from department
where department_ID NOT IN (
select department_ID
from employee )

-- 10. Find out the employees who earn greater than the average salary for their department.
select * from employee e
where salary >
( select AVG(salary)
from employee
where department_ID = e.department_ID )
                                                      -- END
select count(*) from employee       
select * from department
select * from job
select * from location                                               
                                                      
                                                      
                                                      


