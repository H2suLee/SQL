
------------------------------------- 유인물 7, 14
-- 7
SELECT d.department_name, d.location_id, e.last_name, e.job_id, e.salary
FROM employees e, departments d
WHERE location_id = 1800
AND e.department_id = d.department_id;

SELECT d.department_name, d.location_id, e.last_name, e.job_id, e.salary
FROM employees e JOIN departments d ON(e.department_id = d.department_id)
WHERE location_id = 1800;

-- 9 outer join
SELECT d.department_id, d.department_name, d.location_id, COUNT(e.employee_id)
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id
GROUP BY d.department_id, d.department_name, d.location_id;

SELECT d.department_id, d.department_name, d.location_id, COUNT(e.employee_id)
FROM employees e RIGHT OUTER JOIN departments d ON (e.department_id = d.department_id)
GROUP BY d.department_id, d.department_name, d.location_id;

-- 11
SELECT e.job_id, COUNT(*) frequency
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND d.department_name IN ('Administration', 'Executive')
GROUP BY e.job_id
ORDER BY 2 DESC;

SELECT e.job_id, COUNT(*) frequency
FROM employees e JOIN departments d ON(e.department_id = d.department_id)
WHERE d.department_name IN ('Administration', 'Executive')
GROUP BY e.job_id
ORDER BY 2 DESC;

-- 14
SELECT w.last_name, m.last_name manager, m.salary, j.grade_level GRA
FROM employees w, employees m, job_grades j
WHERE w.manager_id = m.employee_id
AND m.salary BETWEEN j.lowest_sal AND j.highest_sal
AND m.salary > 15000;

SELECT w.last_name, m.last_name manager, m.salary, j.grade_level GRA
FROM employees w JOIN employees m ON (w.manager_id = m.employee_id)
JOIN job_grades j ON (m.salary BETWEEN j.lowest_sal AND j.highest_sal)
WHERE m.salary > 15000; -- WHERE을 AND로 써도 됨

-- 추가 문제
-- oracle 구문
SELECT e.last_name, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;

-- ANSI 구문
SELECT e.last_name, d.department_name, l.city
FROM employees e 
JOIN departments d ON (e.department_id = d.department_id)
JOIN locations l ON (d.location_id = l.location_id);

-- 단, 부서 위치가 1800인 경우만 출력
SELECT e.last_name, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND l.location_id = 1800;

-- 소속부서가 없는 사원도 출력
SELECT e.last_name, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id(+)
AND d.location_id = l.location_id;

-- ANSI로
SELECT e.last_name, d.department_name, l.city
FROM employees e 
LEFT OUTER JOIN departments d ON (e.department_id = d.department_id)
JOIN locations l ON (d.location_id = l.location_id);

SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT *
FROM job_grades;

SELECT *
FROM locations;

SELECT * 
FROM countries;
----------------------------- 숙제 Practice 6
-- 1
SELECT l.location_id, l.street_address, l.city, l.state_province, c.country_name
FROM locations l NATURAL JOIN countries c;

-- 2
SELECT e.last_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- 3
SELECT e.last_name, e.job_id, d.department_id, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id 
AND d.location_id = l.location_id
AND LOWER(l.city) = 'toronto';

-- 4
SELECT w.last_name "Employee", w.employee_id "Emp#", m.last_name "Manager", m.employee_id "Mgr#"
FROM employees w, employees m
WHERE w.manager_id = m.employee_id;

-- 5
SELECT w.last_name "Employee", w.employee_id "Emp#", m.last_name "Manager", m.employee_id "Mgr#"
FROM employees w, employees m
WHERE w.manager_id = m.employee_id(+)
ORDER BY w.employee_id;

--ANSI
SELECT w.last_name "Employee", w.employee_id "Emp#", m.last_name "Manager", m.employee_id "Mgr#"
FROM employees w LEFT OUTER JOIN employees m
ON(w.manager_id = m.employee_id)
ORDER BY 2;

-- 6 ??
SELECT emp.department_id, emp.last_name employee, co.last_name coworkers
FROM employees emp, employees co
WHERE emp.department_id = co.department_id
AND emp.employee_id <> co.employee_id
ORDER BY 1, 2, 3;

-- 7
DESC job_grades;
SELECT e.last_name, e.job_id, d.department_name, e.salary, j.grade_level
FROM employees e, departments d, job_grades j
WHERE e.department_id = d.department_id
AND e.salary BETWEEN j.lowest_sal AND j.highest_sal;

----------------------------- 숙제 practice5, 9, 10
-- 8
SELECT MAX(salary) - MIN(salary) difference
FROM employees;

-- 9
SELECT manager_id, MIN(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) >= 6000
ORDER BY MIN(salary);

-- 10
SELECT job_id, SUM(salary)
FROM employees
WHERE department_id IN (20, 50, 80, 90)
GROUP BY department_id, job_id;