-- 220526
-- ���� ������

DESC employees

SELECT *
FROM employees;

SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '09%'; -- 3��

SELECT employee_id, first_name
FROM employees
WHERE department_id = 50; -- 5��

-- ���� �� ���� UNION

SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '09%'
UNION ALL
SELECT employee_id, first_name
FROM employees
WHERE department_id = 50; 
-- UNION �ϸ� 8���� �ƴ϶� 7��, �� ���� 09�⵵�� �Ի��ؼ� �����ȣ�� 50, �ߺ��̶� ���ܵ�
-- UNION ALL�ϸ� �ߺ� ���� �������� �ʱ� ������ 8��, ���ĵ� �� ��

-- ������
SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '09%'
MINUS
SELECT employee_id, first_name
FROM employees
WHERE department_id = 50; -- 2��, diana, kimberly

SELECT employee_id, first_name
FROM employees
WHERE department_id = 50
MINUS
SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '09%'; -- 4��

-- ������

SELECT employee_id, first_name
FROM employees
WHERE department_id = 50
INTERSECT
SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '09%'; -- 1��


-- dual�� SYS ������ �����ϰ� �ִ� ���̺�, ��� ����ڰ� ����� �� �ֵ��� ���������� Ǯ�����
DESC dual;

SELECT *
FROM dual; 

SELECT SYSDATE
FROM dual;

SELECT SYSDATE
FROM employees;

-- �����Լ� 1
-- UPPER, LOWER, INITCAP

SELECT employee_id, first_name
FROM employees
WHERE LOWER(first_name) = 'ellen';

SELECT INITCAP(first_name)
FROM employees;

-- �����Լ� 2
-- CONCAT, SUBSTR, LENGTH, INSTR, LPAD, RPAD, TRIM

SELECT CONCAT('Ye', 'Dam')
FROM dual;

-- ���� �Լ��� ��¥ �Լ�

------------------------------------------ ����

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
ORDER BY TENURE DESC; -- �� �� ORDER BY TRUNC((SYSDATE-hire_date)/7) DESC;