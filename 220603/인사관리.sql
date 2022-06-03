-- 220603
-- 객체 권한
SELECT * FROM employees;

GRANT SELECT 
ON employees
TO scott;

-- merge
DROP TABLE emp13;
CREATE TABLE emp13
AS
SELECT *
FROM   employees;

INSERT INTO employees (employee_id, last_name, email, hire_date,job_id)
VALUES (4321, 'MERGE_TEST', 'skj@test.co.kr', SYSDATE, 'ST_MAN');

UPDATE employees
SET    salary = 10000
WHERE  employee_id = 176; 

SELECT * FROM employees;
SELECT * FROM emp13; -- emp13은 10000, employees는 77777

 MERGE INTO emp13 c
  	USING employees e
  	ON   (c.employee_id = e.employee_id)
  	WHEN MATCHED THEN
  		UPDATE SET
  			c.first_name   = e.first_name,
  			c.last_name    = e.last_name,
  			c.email        = e.email,
  			c.phone_number = e.phone_number,
  			c.hire_date    = e.hire_date,
  			c.job_id       = e.job_id,
  			c.salary       = e.salary,
  			c.commission_pct = e.commission_pct,
  			c.manager_id   = e.manager_id,
  			c.department_id = e.department_id
  	WHEN NOT MATCHED THEN
  		INSERT VALUES (e.employee_id, e.first_name,
  			e.last_name, e.email, e.phone_number,
  			e.hire_date, e.job_id, e.salary,
  			e.commission_pct, e.manager_id,
 			e.department_id);

SELECT * FROM emp13; -- 176이 10000으로 update 됨

-- && single&은 일회용, double&&은 값이 저장되어 재사용 가능

-- 정의 방법 두가지 (1) && 사용
SELECT employee_id, last_name, job_id, &&column_name
FROM employees
ORDER BY &column_name;

-- 정의 방법 두가지 (2) DEFINE 사용
-- DEFINE column_name = department_id
-- 사용은 $column_name 뭐 이런식

UNDEFINE column_name; -- 변수 삭제 (수정은 불가능)