-- 220602

DROP TABLE dept30;

RENAME sample TO sam;

-- �̸� �ٲ� �� Ȯ��
SELECT *
from tab;

TRUNCATE TABLE sam;
-- = drop from sam

COMMENT ON TABLE emp
IS 'Employee Information';

-- �ڸ�Ʈ�� ������ ��ųʸ� �並 ���� Ȯ��
select comments
from user_tab_comments
where table_name = 'EMP';

DESC user__comments;

-- ��������
-- �������� ��ȸ by data dictionary
SELECT *
FROM user_constraints;

-- NOT NULL, �÷� ���������� ���� ���� ������

CREATE TABLE emp_test(
  empid NUMBER(5),
  empname VARCHAR2(10) NOT NULL,
  duty VARCHAR2(9),
  sal NUMBER(7,2), -- ��ü �ڸ���, �Ҽ��� ���� �ڸ���
  bonus NUMBER(7,2),
  mgr NUMBER(5),
  hire_date DATE,
  deptid NUMBER(2));

DESC emp_test;  

INSERT INTO emp_test (empid, empname)
VALUES (null, null); -- ����, empname�� not null�� ���������� �ɷ��־ null�� ���� �Ұ�

INSERT INTO emp_test (empid, empname)
VALUES (null, 'yedam'); 

SELECT *
FROM emp_test;

-- unique
CREATE TABLE dept_test(
  deptid NUMBER(2),
  dname VARCHAR2(14),
  loc VARCHAR2(13),
  UNIQUE(dname));
  
-- unique ���������� ����Ȯ�ο����� �� ����
DESC dept_test;

INSERT INTO dept_test(deptid, dname)
VALUES (1, 'a');

INSERT INTO dept_test(deptid, dname)
VALUES (2, 'a'); -- ����, unique �������� ����

INSERT INTO dept_test(deptid, dname)
VALUES (3, null); 

INSERT INTO dept_test(deptid, dname)
VALUES (4, null); -- not null �� �ɸ��� �ʱ� ������ null �� �־ ok

-- primary key

DROP TABLE dept_test;

CREATE TABLE dept_test(
  deptid NUMBER(2),
  dname VARCHAR2(14),
  loc VARCHAR2(13),
  PRIMARY KEY(deptid),
  UNIQUE(dname));

DESC dept_test; -- deptid�� not null �Ǿ��ִٰ� not null ���������� �ɸ� �� �ƴϴ�

INSERT INTO dept_test(deptid, dname)
VALUES (10, 'a');  

INSERT INTO dept_test(deptid, dname)
VALUES (10, 'b'); -- ���� unique constraint violated

INSERT INTO dept_test(deptid, dname)
VALUES (null, 'c'); -- ���� not null ����

DROP TABLE emp_test;

-- foreign key

CREATE TABLE emp_test(
  empid NUMBER(5),
  empname VARCHAR2(10) NOT NULL,
  duty VARCHAR2(9),
  sal NUMBER(7,2), -- ��ü �ڸ���, �Ҽ��� ���� �ڸ���
  bonus NUMBER(7,2),
  mgr NUMBER(5),
  hire_date DATE,
  deptid NUMBER(2),
  FOREIGN KEY (deptid)
  REFERENCES dept (deptno));
    
-- �÷� �������� fk ������ ��
-- deptid NUMBER(2) REFERENCES dept(deptid),

  
DESC dept;
DESC emp_test;

INSERT INTO emp_test(empid, empname, deptid)
VALUES (10, 'a', 10);

INSERT INTO emp_test(empid, empname, deptid)
VALUES (20, 'b', 9); -- ����, 9�� dept�� deptno�� ����

INSERT INTO emp_test(empid, empname, deptid)
VALUES (30, 'c', null);

INSERT INTO emp_test(empid)
VALUES (null);

UPDATE emp_test
SET deptid = 9
where di; -- ? Ÿ���� ��ħ

-- �÷� �ϳ��� �� ���� ���������� �� ������ �ϳ��� �÷� ������, �ٸ� �ϳ��� ���̺� ������ ����
-- ����Ʈ�� NULL (�� �� �� �ִٰ�)
-- ON DELETE CASCADE -- �� ���� �� ���� �� ����
    -- FOREIGN KEY (�÷���)
    -- REFERENCES ������ ���̺��(�÷���) ON DELETE CASCADE
-- ON DELETE SET NULL
    -- FOREIGN KEY (�÷���)
    -- REFERENCES ������ ���̺��(�÷���) ON DELETE SET NULL
DROP TABLE emp_test;

CREATE TABLE emp_test(
  empid NUMBER(5),
  empname VARCHAR2(10) NOT NULL,
  duty VARCHAR2(9),
  sal NUMBER(7,2), -- ��ü �ڸ���, �Ҽ��� ���� �ڸ���
  bonus NUMBER(7,2),
  mgr NUMBER(5),
  hire_date DATE,
  deptid NUMBER(2),
  FOREIGN KEY (deptid)
  REFERENCES dept (deptno));

INSERT INTO emp_test(empid, empname, deptid)
VALUES (10, 'a', 10);

INSERT INTO emp_test(empid, empname, deptid)
VALUES (20, 'b', 40);

DELETE dept
WHERE deptno = 40; -- ����, �ڽ� ���̺��� �����ϰ� �ֱ� ������ ���� �Ұ�

DROP table emp_test;

CREATE TABLE emp_test(
  empid NUMBER(5),
  empname VARCHAR2(10) NOT NULL,
  duty VARCHAR2(9),
  sal NUMBER(7,2), -- ��ü �ڸ���, �Ҽ��� ���� �ڸ���
  bonus NUMBER(7,2),
  mgr NUMBER(5),
  hire_date DATE,
  deptid NUMBER(2),
  FOREIGN KEY (deptid)
  REFERENCES dept (deptno) ON DELETE SET NULL);

INSERT INTO emp_test(empid, empname, deptid)
VALUES (10, 'a', 10);

INSERT INTO emp_test(empid, empname, deptid)
VALUES (20, 'b', 40);

DELETE dept
WHERE deptno = 40; -- on delete set null �߰� �� ������

SELECT *
FROM dept;

SELECT *
FROM emp_test;

-- �������� ����(alter-add, modify)
ALTER TABLE emp_test
ADD FOREIGN KEY(mgr)
    REFERENCES emp(empno);

ALTER TABLE emp_test
MODIFY (duty VARCHAR2(9) NOT NULL); -- ���� duty�� null �־ �ȵ�

TRUNCATE table emp_test; -- ���� �� �߶󳻱�

ALTER TABLE emp_test
MODIFY (duty NOT NULL); -- duty�� varchar2 Ű���� �����ص� ��

DESC emp_test;

-- �������� ����
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints; -- ������ ��ųʸ� ��

-- �������� ����
ALTER TABLE dept_test
DROP PRIMARY KEY CASCADE; 

-- �������� ��Ȱ��ȭ DISABLE - ENABLE

-- ��
-- ������ ������ �����ϱ� ����, ���⤸�� ���� ���� �ۼ��ϱ� ����
-- ������ ������ ����

CREATE VIEW v10 (empno, ename, ann_sal) 
AS SELECT empno, ename, sal*12 -- sal*12�� view�� �÷������� �� �� ���� ������ �� ��Ī�̳� ���ٿ� �� �̸� �����ؾ�
   FROM emp
   WHERE deptno = 10;

DESC v10;

SELECT * FROM v10;

SELECT empno, ename
FROM v10;

CREATE VIEW v10_1
AS SELECT empno, ename, sal*12 AS ann_sal -- emp�� �÷����� �״�� ���� �÷�������
   FROM emp
   WHERE deptno = 10;

SELECT * FROM v10_1;

-- �� ����
SELECT * FROM USER_VIEWS;

-- �� ������ ALTER�� �ƴ� CREATE OR REPLACE(�����)
-- ��ġ�� �����ϸ� ����� ���� ���ο� �並 ����� ��(CREATE)�� ���� 

CREATE OR REPLACE VIEW v10 (id_number, name, sal, department_id)
AS SELECT empno, ename, sal, deptno
   FROM emp
   WHERE deptno = 20;

SELECT * FROM v10;   

CREATE VIEW v10 (empno, ename, ann_sal) 
AS SELECT empno, ename, sal*12 -- sal*12�� view�� �÷������� �� �� ���� ������ �� ��Ī�̳� ���ٿ� �� �̸� �����ؾ�
   FROM emp
   WHERE deptno = 10; -- �̹� �����ϴ� view��� �ȸ������
   
-- �� ����
DROP VIEW v10;

-- �並 ���� ������ ����
CREATE VIEW v_test
AS SELECT deptno, sum(sal) SUM
   FROM emp
   GROUP BY deptno;

DELETE v_test
WHERE deptno = 10; -- ����, �Ұ���

DELETE v10_1
WHERE empno = 7934;

SELECT * FROM v10_1; -- �ε��������� �����
SELECT * FROM emp WHERE empno = 7934; -- ���� ���̺� �����, view�� ���ؼ� ������ ������ �����ϴ�!

ROLLBACK;

UPDATE v10_1
SET sal = 9999 -- invalid identifier
WHERE empno = 7934;

UPDATE v10_1
SET ann_sal = 9999 -- virtual column not allowed here
WHERE empno = 7934;

CREATE VIEW v_ins
AS select dname, loc
   from dept;
   
SELECT * FROM v_ins;

INSERT INTO v_ins
values ('abc', 'daegu'); -- ����, �⺻Ű �Է��� ���ߴٰ�

CREATE OR REPLACE VIEW v_ins
AS select deptno, dname, loc
   from dept;
   
INSERT INTO v_ins
values (88, 'abc', 'daegu'); -- �並 ���� ���� ���̺� ������ ���� ����

SELECT e.empno, e.ename, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

-- �並 �̿��ϸ�, �Ź� �� ������ Ÿ�������� �ʰ� ���� ������ �Ʒ��� ���� ��ȸ�� �� �ִ�.

CREATE VIEW v_join
AS SELECT e.empno, e.ename, d.dname
   FROM emp e, dept d
   WHERE e.deptno = d.deptno;

SELECT * FROM v_join; 

-- WITH CHECK OPTION

CREATE OR REPLACE VIEW empvu20
AS SELECT * 
   FROM emp
   WHERE deptno = 20
   WITH CHECK OPTION CONSTRAINT empvu20_ck;
   
SELECT * FROM empvu20;

UPDATE empvu20
SET deptno = 10
WHERE empno = 7788; -- ����, with check option�� ����ȴ� -- 20������ �μ���ȣ ������ �ɾ���ұ� ����...

UPDATE empvu20
SET sal = 9999
WHERE empno = 7788;

SELECT * FROM emp WHERE empno = 7788;

ROLLBACK;

UPDATE empvu20
SET sal = 9999
WHERE empno = 7900; -- ������ �ƴ����� ������ ����, 0�� ���� ������Ʈ ��, ����(deptno = 20) �ۿ� �ִ� ��(30�� �μ�)�̱� ����

DELETE empvu20
WHERE empno = 7900; -- ��������

DELETE empvu20
WHERE empno = 7788; -- child record found

-- WITH READ ONLY, �� �ɼ� ���� �μ�Ʈ, ����Ʈ, ������Ʈ �Ұ�����, �ǽ��� ����

-- �ε���

CREATE table emp_ix 
as 
 SELECT *
 FROM emp
 WHERE deptno = 30;

CREATE INDEX sal_comm_idx
ON emp_ix(sal,comm);

-- �� ������ ���� �ִ� ��ü�� ��ȸ
SELECT object_name, object_type
FROM user_objects;

DROP TABLE emp_ix; -- ���̺��� �����ϸ� �ε����� ������

-- SEQUENCE, ��ȣ �����ϴ� ��
DELETE dept 
WHERE deptno >= 50;

SELECT *
FROM dept;

CREATE SEQUENCE dept_deptno_seq -- ���� ����ߴٰ� dept ���̺��� �� �� �ִ°͵� �ƴ�,, �������� ���� �����ϱ� ������ ��� ��ü������ �ҷ��� �� �ִ�
       INCREMENT BY 10 -- 10�� ����
       START WITH 50 -- 50������ ����
       MAXVALUE 110 -- �� ���� nomaxvalue
       NOCYCLE -- nocycle�̸� �� �ᵵ ��
       NOCACHE; -- nocache�� �� �ᵵ ��

INSERT INTO dept
VALUES (dept_deptno_seq.NEXTVAL, 'TESTING', 'SEOUL');

SELECT *
FROM dept;

DESC dept; -- ������ �� number�� ���ڸ��� ���س��ұ� ������ sequence���� �ִ밪�� 110���� �س��� 90������ �ö�

CREATE table dept_t
AS SELECT *
   FROM dept
   where deptno = 0; -- ���������� ���� ���̺� ����, dept ���̺��� �����⸸ ������

-- ������ �� ���̿� ������ �߻��ϴ� ���
ALTER table dept_t
MODIFY deptno number(10);

INSERT INTO dept_t
VALUES (dept_deptno_seq.NEXTVAL, 'TESTING', 'SEOUL'); 
-- ���� sequence DEPT_DEPTNO_SEQ.NEXTVAL exceeds MAXVALUE and cannot be instantiated
-- ���� ������ �ʹ� ���� insert�Ϸ��� �ؼ� �̹� maxvalue�� �ʰ� (120)

-- ������ ���� Ȯ��
-- USER_SEQUENCES ������ ��ųʸ� ���̺��� ������ ���� Ȯ��
SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM user_sequences;

-- ������ ����
-- ������ �� start with�� ����
ALTER SEQUENCE dept_deptno_seq
  INCREMENT BY 20
  MAXVALUE 99999
  NOCYCLE
  NOCACHE;

SELECT * FROM dept_t; -- ��Ʈ �ѹ����� 120���� 20�� �����ϰ� ������

-- ������ ����: drop, �ǽ� �� ��