-- 220603
-- ��ü ����
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
SELECT * FROM emp13; -- emp13�� 10000, employees�� 77777

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

SELECT * FROM emp13; -- 176�� 10000���� update ��

-- && single&�� ��ȸ��, double&&�� ���� ����Ǿ� ���� ����

-- ���� ��� �ΰ��� (1) && ���
SELECT employee_id, last_name, job_id, &&column_name
FROM employees
ORDER BY &column_name;

-- ���� ��� �ΰ��� (2) DEFINE ���
-- DEFINE column_name = department_id
-- ����� $column_name �� �̷���

UNDEFINE column_name; -- ���� ���� (������ �Ұ���)