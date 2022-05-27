-- 220526
-- 집합 연산자

DESC employees

SELECT *
FROM employees;

SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '09%'; -- 3명

SELECT employee_id, first_name
FROM employees
WHERE department_id = 50; -- 5명

-- 위에 두 개를 UNION

SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '09%'
UNION ALL
SELECT employee_id, first_name
FROM employees
WHERE department_id = 50; 
-- UNION 하면 8명이 아니라 7명, 한 명이 09년도에 입사해서 사원번호가 50, 중복이라 제외됨
-- UNION ALL하면 중복 값을 제거하지 않기 때문에 8명, 정렬도 안 됨

-- 차집합
SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '09%'
MINUS
SELECT employee_id, first_name
FROM employees
WHERE department_id = 50; -- 2개, diana, kimberly

SELECT employee_id, first_name
FROM employees
WHERE department_id = 50
MINUS
SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '09%'; -- 4개

-- 교집합

SELECT employee_id, first_name
FROM employees
WHERE department_id = 50
INTERSECT
SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '09%'; -- 1개


-- dual은 SYS 계정이 소유하고 있는 테이블, 모든 사용자가 사용할 수 있도록 접근제한을 풀어놓음
DESC dual;

SELECT *
FROM dual; 

SELECT SYSDATE
FROM dual;

SELECT SYSDATE
FROM employees;

-- 문자함수 1
-- UPPER, LOWER, INITCAP

SELECT employee_id, first_name
FROM employees
WHERE LOWER(first_name) = 'ellen';

SELECT INITCAP(first_name)
FROM employees;

-- 문자함수 2
-- CONCAT, SUBSTR, LENGTH, INSTR, LPAD, RPAD, TRIM

SELECT CONCAT('Ye', 'Dam')
FROM dual;

-- 숫자 함수와 날짜 함수

------------------------------------------ 숙제

-- 1
SELECT SYSDATE "Date"
FROM dual;

-- 2
SELECT employee_id, last_name, salary, ROUND(salary * 1.15, 0) AS "New Salary"
FROM employees;

-- 3
SELECT employee_id, last_name, salary, ROUND(salary * 1.15, 0) AS "New Salary", ROUND(salary * 1.15, 0) - salary AS "Increase"
FROM employees;

-- 5
SELECT UPPER(last_name) AS "Name", LENGTH(last_name) AS "Name Length"
FROM employees
WHERE last_name LIKE 'J%' 
OR last_name LIKE 'A%' 
OR last_name LIKE 'M%' 
ORDER BY last_name;

-- 6
SELECT last_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date), 0) AS "MONTH_WORKED"
FROM employees
ORDER BY MONTHS_BETWEEN(SYSDATE, hire_date);

-- 7
SELECT last_name, LPAD(salary, 15, '$') SALARY
FROM employees;

-- 8
SELECT last_name, TRUNC((SYSDATE-hire_date)/7) AS TENURE
FROM employees
WHERE department_id=90
ORDER BY TENURE DESC; -- 내 답 ORDER BY TRUNC((SYSDATE-hire_date)/7) DESC;