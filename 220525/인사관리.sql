SELECT *
FROM tab; 

-- scott계정의 emp와 동일
SELECT *
FROM employees;

-- scott계정의 dept와 동일
SELECT *
FROM departments;

SELECT last_name, job_id, salary, commission_pct
FROM employees;

SELECT last_name || ' is a ' || job_id
AS "Employee Details"
FROM employees;

SELECT last_name || '은 ' || department_id || '번 부서에 근무합니다.'
AS "사원 근무 현황" -- AS 생략 가능
FROM employees;

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = 90;

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE last_name = 'Whalen';

SELECT last_name
FROM employees
WHERE hire_date = '97/09/17';

SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 3500 AND 2500; -- 오류는 안 뜨고 데이터도 안 뜸, BETWEEN의 AND 앞 뒤로 최소값 최대값 위치 잘 지켜주기

SELECT employee_id, last_name, job_id
FROM employees
WHERE job_id LIKE '%SAG_%' ESCAPE 'G';

------------------------------- 숙제1
--1

DESCRIBE departments

SELECT *
FROM departments;

--2
DESC employees

SELECT employee_id, last_name, job_id, hire_date STARTDATE
FROM employees;

--3
SELECT DISTINCT job_id
FROM employees;

--4
SELECT employee_id "Emp #", last_name "Employee", job_id "Job", hire_date "Hire Date"
FROM employees;

--5
SELECT last_name || ', ' || job_id AS "Employee and Title"
from employees;

------------------------------- 숙제2
--1
SELECT last_name, salary
FROM employees
WHERE salary > 12000;

--2
SELECT last_name, department_id
FROM employees
WHERE employee_id = 176;

--3
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000;

--4
SELECT last_name, job_id, hire_date
FROM employees
WHERE last_name IN('Matos', 'Taylor')
ORDER BY hire_date;

--5
SELECT last_name, department_id
FROM employees
WHERE department_id IN(20, 50) -- 이거 BETWEEN 으로 함
ORDER BY last_name;

--6
SELECT last_name "Employee", salary "Monthly Salary" 
FROM employees
WHERE salary BETWEEN 5000 AND 12000
AND department_id IN (20, 50); -- 난 AND( department_id = 20 OR department_id = 50 )로 적긴 함

--7
SELECT last_name, hire_date
FROM employees
WHERE hire_date LIKE '04%'; -- 난 WHERE hire_date = '2004%';하고 오류남

--8
SELECT last_name, job_id
FROM employees
WHERE manager_id IS NULL;

--9
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;

--10
SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';

--11
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%' AND last_name LIKE '%e%';

--12
SELECT last_name, job_id, salary
FROM employees
WHERE job_id IN ('SA_REP', 'ST_CLERK')
AND salary NOT IN (2500, 3500, 7000);

--12 내 답
SELECT last_name, job_id, salary
FROM employees
WHERE (job_id = 'SA_REP' OR job_id = 'ST_CLERK')
AND salary NOT IN (2500, 3500, 7000);

SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct = .20; -- 내 답은 WHERE commission_pct = 0.2;

SELECT DISTINCT commission_pct
FROM employees;

