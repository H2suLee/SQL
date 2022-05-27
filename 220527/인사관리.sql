-- 220527
--------------------------------------------- ����
-- 1
SELECT last_name || ' earns ' || TO_CHAR(salary, '$99,999.99') || ' monthly but wants ' || TO_CHAR(salary*3, '$99,999.99') || '.' AS "Dream Salary"
FROM employees;

-- 2
SELECT last_name, LPAD(salary, 15, '$') AS SALARY
FROM employees;

-- 3
SELECT last_name, hire_date, TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6),2), 'YYYY.MM.DD DAY') AS REVIEW
FROM employees;

-- 4
SELECT last_name, hire_date, TO_CHAR(hire_date, 'DAY') DAY
FROM employees
ORDER BY TO_CHAR(hire_date -1, 'd'); -- ORDER BY DAY;�� �ϴ� ������ ������ ���ĵ�
-- ORDER BY TO_CHAR(hire_date, 'd') - 1; -- �� �� ��, ��, ��, ȭ, ~ �� ���ĵ�

SELECT TO_CHAR(hire_date, 'YYYY.MM.DD DAY'), TO_CHAR(hire_date, 'd')
FROM employees; -- ��¥ -> ���� ��ȯ �Լ����� ���� 'd'�� ������ ���ڰ��� ��Ÿ��, 1�� �Ͽ��� 2�� ������

-- 5
-- SELECT last_name, TO_CHAR(NVL(commission_pct, 0), 'No Commission')
SELECT last_name, NVL(TO_CHAR(commission_pct), 'No commission') COMM
FROM employees;

-- 6 
SELECT salary, RPAD(last_name, 8) || RPAD(' ', salary/1000+1, '*') AS "EMPLOYEES_AND_THEIR_SALARIES"
FROM employees
ORDER BY salary DESC;

SELECT RPAD(' ', 5, '*') AS "practice"
FROM dual; -- ****

SELECT RPAD(' ', 5+1, '*') AS "practice"
FROM dual; -- *****

----------------------------------------------- ���ι� 1��~5��
-- 1
SELECT *
FROM employees;

SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id
FROM employees
WHERE TO_NUMBER(TO_CHAR(hire_date, 'RR')) > 02
AND job_id = 'ST_CLERK';
 
-- ���
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id
FROM employees
WHERE TO_CHAR(hire_date, 'RR') > '02'
AND UPPER(job_id) = 'ST_CLERK';

-- �ٸ� ��
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id
FROM employees
WHERE hire_date > '02/12/31'
AND UPPER(job_id) = 'ST_CLERK';

-- 2 (����)
SELECT last_name, job_id, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC;
-- ORDER BY 3 DESC; �� ����

-- 3 (����)
SELECT 'The salary of ' || last_name || ' after a 10% raise is ' || ROUND(salary*1.1) AS "New salary"
FROM employees
WHERE commission_pct IS NULL
ORDER BY salary DESC;

-- 4 (����)
SELECT last_name, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12) "YEARS", TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, hire_date),12)) "MONTHS"
FROM employees;

-- 5 (����)
-- ������ ��
SELECT last_name
FROM employees
WHERE UPPER(SUBSTR(last_name,1,1)) IN ('J', 'K', 'M', 'L');

-- ���� �� ��
SELECT last_name
FROM employees
WHERE last_name LIKE 'J%'
OR last_name LIKE 'K%'
OR last_name LIKE 'L%'
OR last_name LIKE 'M%';

-- �߰�����, Ǯ�̴� �� ���ֽ�
-- 12
SELECT last_name, hire_date
FROM employees
WHERE TO_NUMBER(TO_CHAR(hire_date, 'DD')) <= 15 ;

-- 13
SELECT last_name, salary, salary/1000 "THOUSANDS"
FROM employees;

-------------------------------------- �� ����
-- practice 4
-- 7
-- DECODE
SELECT last_name, job_id, 
       DECODE(job_id, 'AD_PRES', 'A', 'ST_MAN', 'B', 'IT_PROG', 'C', 'SA_REP', 'D', 'ST_CLERK', 'E', '0') "���"
FROM employees;

-- CASE
SELECT last_name, job_id, 
       CASE job_id when 'AD_PRES' THEN 'A'
                   when 'ST_MAN' THEN 'B'
                   when 'IT_PROG' THEN 'C'
                   when 'SA_REP' THEN 'D'
                   when 'ST_CLERK' THEN 'E'
                   ELSE '0'
       END
       AS "���"
FROM employees;       

-- Practice 5
-- 1. �׷� �Լ��� ���� �࿡ ����Ǿ� �׷� �� �ϳ��� ����� ����Ѵ�. T
-- 2. �׷� �Լ��� ��꿡 ���� �����Ѵ�. F
-- 3. WHERE���� �׷� ��꿡 ���� ���Խ�Ű�� ���� ���� �����Ѵ� F (?)
-- 4
SELECT ROUND(MAX(salary)) "Maximum", ROUND(MIN(salary)) "Minimum", ROUND(SUM(NVL(salary,0))) "Sum", ROUND(AVG(NVL(salary, 0))) "Average"
FROM employees;

-- 5
SELECT job_id, ROUND(MAX(salary)) "Maximum", ROUND(MIN(salary)) "Minimum", ROUND(SUM(NVL(salary,0))) "Sum", ROUND(AVG(NVL(salary, 0))) "Average"
FROM employees
GROUP BY job_id;

-- 6
SELECT job_id, Count(*)
FROM employees
GROUP BY job_id;

-- 7 �� distinct �� ����, 19�� ����
SELECT COUNT(DISTINCT manager_id) "Number of Managers"
FROM employees; -- 8

-- 8 
SELECT MAX(salary) - MIN(salary) DIFFERENCE
FROM employees;
