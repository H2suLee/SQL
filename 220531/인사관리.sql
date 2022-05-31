-- 220531

-- Practice 6-6 문제 수정
-- 176번 사원과 동일한 부서에 근무하는 모든 사원의 성과 부서 번호를 표시하는 보고서를 작성하시오.
SELECT emp.department_id, emp.last_name employee, co.last_name coworkers
FROM employees emp, employees co
WHERE emp.department_id = co.department_id
AND emp.employee_id <> co.employee_id
AND emp.employee_id = 176
ORDER BY 1, 2, 3;

-- 이걸 서브쿼리로 하면 두 개의 질의가 하나의 질의로 끝날 수 있음
SELECT last_name, department_id
FROM employees
WHERE department_id = (SELECT department_id
                       FROM employees
                       WHERE employee_id = 176)
AND last_name NOT LIKE (SELECT last_name
                       FROM employees
                       WHERE employee_id = 176);

SELECT *
FROM employees;

------------------------------ 숙제 practice 7
-- 1
SELECT last_name, hire_date
FROM employees
WHERE department_id = (SELECT department_id 
                       FROM employees
                       WHERE lower(last_name) = 'zlotkey')
AND lower(last_name) != 'zlotkey';       

-- 2
SELECT employee_id, last_name
FROM employees
WHERE salary > (SELECT AVG(NVL(salary, 0))
                FROM employees)
ORDER BY salary;                

-- 3
SELECT employee_id, last_name
FROM employees
WHERE department_id IN (SELECT department_id FROM employees WHERE lower(last_name) LIKE '%u%');

-- 4
SELECT e.last_name, e.department_id, e.job_id
FROM employees e, departments d
WHERE e.department_id = d.department_id 
AND d.location_id = 1700;

SELECT last_name, department_id, job_id
FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE location_id = 1700);

-- 5
SELECT last_name, salary
FROM employees
WHERE manager_id = (SELECT employee_id FROM employees WHERE lower(last_name) = 'king');

-- 6
SELECT department_id, last_name, job_id
FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE lower(department_name) = 'executive');

-- 7
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(NVL(salary,0)) FROM employees)
AND department_id IN (SELECT department_id FROM employees WHERE lower(last_name) LIKE '%u%');
