-- 220602 
--------------------- 숙제 Practice 9 
--------------------- 6, 7, 14, 16, 18 제외
-- 1
CREATE TABLE my_employee
(id NUMBER(4) CONSTRAINT my_employee_id_nn NOT NULL,
 last_name VARCHAR2(25),
 first_name VARCHAR2(25),
 userid VARCHAR2(8),
 salary NUMBER(9,2));

-- 2 
DESC my_employee; 

-- 3
INSERT INTO my_employee
VALUES (1111, 'lee', 'july', 'julylee', 3000);

DELETE my_employee
WHERE last_name = 'lee';

SELECT * FROM my_employee;

INSERT INTO my_employee
VALUES (1,'Patel', 'Ralph', 'rpatel', 895);

-- 4
INSERT INTO my_employee(id, last_name, first_name, userid, salary)
VALUES (2,'Dancs', 'Betty', 'bdancs', 860);

-- 5, 8
SELECT * FROM my_employee;

-- 9
COMMIT;

-- 10
INSERT INTO my_employee
VALUES (3, 'Biri', 'Ben', 'Bbiri', 1100);

UPDATE my_employee
SET last_name = 'Drexler'
WHERE id = 3;

-- 11
INSERT INTO my_employee
VALUES (4, 'Newman', 'Chad', 'Cnewman', 750);

INSERT INTO my_employee
VALUES (5, 'Ropeburn', 'Audery', 'Aropebur', 1550);

UPDATE my_employee
SET salary = 1000
WHERE salary < 900;

SELECT * FROM my_employee;

-- 12
DELETE my_employee
WHERE LOWER(first_name) = 'betty';

SELECT first_name, last_name
FROM my_employee;

-- 13
COMMIT;

-- 15, 17
DELETE my_employee;
SELECT * FROM my_employee;

-- 18
ROLLBACK;

-- 19
SELECT * FROM my_employee;

-- 20
COMMIT;

------------------------------- Practice 10
------------------------------- 5, 6, 7 제외
-- 1.
CREATE TABLE dept
(id NUMBER(7) PRIMARY KEY,
 name VARCHAR2(25));
 
 DESC dept;

-- 2
INSERT INTO dept
 SELECT department_id, department_name
 FROM departments;
 
SELECT * FROM dept;

-- 3
CREATE TABLE emp
 (id NUMBER(7),
  last_name VARCHAR2(25),
  first_name VARCHAR2(25),
  dept_id NUMBER(7) REFERENCES dept(id));

DESC emp;
SELECT * FROM emp;  

-- 4
CREATE TABLE employees2(id, first_name, last_name, salary, dept_id)
 AS SELECT employee_id, first_name, last_name, salary, department_id
    FROM employees;

DROP TABLE employees2;    