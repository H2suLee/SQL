-- 220531
-- ��������
SELECT ename, job, sal
FROM emp
WHERE sal = (SELECT MIN(sal)
             FROM emp);
             
-- �̰� �������� �� ���� �Ҷ�� ������             
SELECT ename, job, sal
FROM emp
WHERE sal = MIN(sal); -- �׷��Լ��� where������ ���� �� ����

SELECT job, AVG(sal)
FROM emp
GROUP BY job;

SELECT MIN(AVG(sal))
FROM emp
GROUP BY job;

-- ���������� ����ϸ� ���� �� ���ǰ� �Ʒ��� ���� �ϳ��� ������

SELECT job, AVG(sal)
FROM emp
GROUP BY job
HAVING AVG(sal) > (SELECT MIN(AVG(sal))
                   FROM emp
                   GROUP BY job);
                   
-- ���� �� ������������ ���� ���� ��ȯ�Ǿ� ������
SELECT empno, ename
FROM emp
WHERE sal = (SELECT MIN(sal)
             FROM emp
             GROUP BY deptno);

-- IN���� �����ϸ� ��
-- IN, ANY, ALL �߿� IN�� ���� ���� ���δ�..
-- ���� ���� �ϳ��� ���������� �޾Ƶ� = ��� IN�� ���� ������� ����..
-- �ٵ� ������ �ӵ��� =�� ������..
-- �������̸� �������̸� =, �������̸� in�� ���� ���� ��Ȯ�ϴ�
SELECT empno, ename
FROM emp
WHERE sal IN (SELECT MIN(sal)
             FROM emp
             GROUP BY deptno);
/*�� : ��ġ�����
ȭ : ��������
�� : �Ұ������
�� : ��������
�� : �������� ������Դϴ�
*/
-- ANY ������ ����ϱ�
-- < ANY �ִ밪���� ������ �ǹ�
-- > ANY �ּҰ����� ŭ�� �ǹ�
-- = ANY  IN�� ����

SELECT *
FROM emp;

SELECT empno, ename, job, sal
FROM emp
WHERE sal < ANY (SELECT sal -- 2975, 2850, 2450 ��ȯ
                 FROM emp
                 WHERE job = 'MANAGER')
AND job <> 'MANAGER';

SELECT empno, ename, job
FROM emp
WHERE sal > ANY (SELECT sal
                 FROM emp
                 WHERE job = 'MANAGER')
AND job <> 'MANAGER';

-- ALL ������
-- < ALL �ּҰ����� ������ �ǹ�
-- > ALL �ִ밪���� ŭ�� �ǹ�
-- = ALL �� �����Ⱚ ����

SELECT empno, ename, job, sal
FROM emp
WHERE sal > ALL (SELECT AVG(sal) -- 2916���� ū ����
                 FROM emp
                 GROUP BY deptno); 

SELECT empno, ename, job, sal
FROM emp
WHERE sal < ALL (SELECT AVG(sal) -- 1566���� ���� ����
                 FROM emp
                 GROUP BY deptno);

SELECT AVG(sal)
FROM emp
GROUP BY deptno; -- 1566, 2175, 2916 ��ȯ

UPDATE emp
SET sal = 1250, comm= 1400
WHERE empno = 7782;

UPDATE emp
SET comm= 500
WHERE empno = 7839;

SELECT *
from EMP;

-- pairwise
-- MARTIN, 1250, 1400, 30 �� �ϳ� ��ȯ
SELECT ename, sal, comm, deptno
FROM emp
WHERE (sal, NVL(comm, -1)) IN (SELECT sal, NVL(comm, -1)
                               FROM emp
                               WHERE deptno = 10)
AND deptno <> 10;                               

-- non-pairwise
-- WARD�� MARTIN �� �� ��
SELECT ename, sal, comm, deptno
FROM emp
WHERE sal IN (SELECT sal
              FROM emp
              WHERE deptno = 10)
AND NVL(comm, -1) IN (SELECT NVL(comm, -1)
                      FROM emp
                      WHERE deptno = 10)                      
AND deptno <> 10;                               

-- from���� �������� ���
-- �μ��� ��ձ޿����� �޿��� ���� �޴� �����
SELECT a.ename, a.sal, a.deptno, b.salavg
FROM emp a, (SELECT deptno, avg(sal) salavg
             FROM emp
             GROUP BY deptno) b
WHERE a.deptno = b.deptno
AND a.sal > b.salavg;

SELECT a.ename, a.sal, a.deptno, b.salavg
FROM emp a, (SELECT deptno, avg(sal) salavg
             FROM emp
             GROUP BY deptno) b
WHERE a.deptno = b.deptno;
--AND a.sal > b.salavg;

-- DML
-- INSERT
INSERT INTO dept(deptno, dname, loc)
VALUES (50, 'TESTING', 'SEOUL');

SELECT *
FROM dept;

-- �÷��� ������ desc�ؼ� Ȯ�� ����
DESC dept;

-- ��� �÷��� ���� �� �ְ� ������ INTO ���� �÷��� ��� �� ���൵ ��
-- ��, ������ �÷��� original ������ �����ؾ��ϰ� ������ Ÿ�Ե� ���ƾ�
INSERT INTO dept
VALUES (51, 'YEDAM', 'DAEGU');

-- Ư�� �÷��� ���� ������ ��� �÷��� original ������ �� ��ų �ʿ�� ����
-- loc�� null �� �־��
-- �Ͻ���
INSERT INTO dept(deptno, dname)
VALUES (60, 'TESTING01');

-- �����
INSERT INTO dept
VALUES (70, 'TESTING02', NULL);

INSERT INTO dept
VALUES (80, '', '');

-- ����ǥ �ȿ� �����̽��ٷ� ������ �ָ� null�� �ƴ϶� ���ڿ��� �νĵ�
INSERT INTO dept
VALUES (81, ' ', ' ');

INSERT INTO emp(empno, ename, hiredate, sal, comm, deptno)
VALUES (1111, USER, SYSDATE, 3000, NULL, 20); --user�� scott

INSERT INTO emp(empno, ename, hiredate)
VALUES (3333, 'LEE', TO_DATE('5��/05 2010', 'MON/DD YYYY')); -- ��¥�� ���� �Է��ϸ� ���Ͱ� yy/mm/dd�� �޾Ƶ���

SELECT *
FROM emp;

CREATE TABLE s_emp
  (empid NUMBER(5),
   empname VARCHAR2(10),
   mgr NUMBER(5),
   sal NUMBER(7,2),
   deptid NUMBER(2));

-- ���������� INSERT�� �ۼ�, �� ������ values�� ������� ����
-- ��� �÷��� �� ������� �ű� ������ s_emp �ڿ� ��ȣ �� ����
INSERT INTO s_emp
 SELECT empno, ename, mgr, sal, deptno
 FROM emp;

SELECT *
FROM dept;

INSERT INTO dept(dname, loc)
VALUES ('YEDAM', 'DAEGU'); -- �⺻Ű(deptno)�� null, cannot insert NULL into ("SCOTT"."DEPT"."DEPTNO")

INSERT INTO dept
VALUES (10, 'YEDAM', 'DAEGU'); -- �ߺ�

INSERT INTO dept
VALUES (91, 'YEDAM', 'DAEGU'); -- ��

INSERT INTO dept
VALUES (91, 'YEDAM', 'DAEGU'); -- �ߺ�

-- dept �θ� , emp �ڽ�
-- dept�� �⺻Ű(PK)�� deptno, �۱� �̰� emp�� �ܷ�Ű(FK)
-- dept���� PK�� �����ִ� ����Ÿ�� emp���� ������ �� �ִ�

INSERT INTO emp(empno, ename, deptno) -- ��, dept�� deptno���� 99�� ���� ����
VALUES (9999, 'YEDAM', 99);

INSERT INTO emp(empno, ename, deptno)
VALUES (9991, 'YEDAM', 00); -- �ȵ� dept�� deptno���� 0�� �� ���� ����

INSERT INTO emp(empno, ename, deptno)
VALUES (9991, 'YEDAM', 01); -- �ȵ� dept�� deptno���� 1�� �� ���� ����

INSERT INTO emp(empno, ename, deptno)
VALUES (9991, 'YEDAM', 10); -- ��, dept�� deptno���� 10�� ���� ����

INSERT INTO emp(empno, ename, deptno)
VALUES (9992, 'YEDAM', null); -- FK�� null�̶� ��
-- not null ���������� �ɷ��ִ� ���� �⺻Ű �ڸ��� �����ϰ� null�� �� ��

DELETE FROM emp;

SELECT *
FROM emp;

ROLLBACK; -- �ǵ�����

DELETE FROM dept
WHERE deptno = 50;

SELECT *
FROM dept;

COMMIT; -- ���������� �����ͺ��̽��� �ݿ�

SELECT *
FROM s_emp;

INSERT INTO s_emp
  SELECT empno, ename, mgr, sal, deptno
  FROM emp;

COMMIT;  

DELETE FROM s_emp;

ROLLBACK;

TRUNCATE TABLE s_emp; -- ���� �ϸ� rollback �ص� ���� �� ��
-- delete�� dml ��ɾ�, truncate�� ddl ��ɾ�
-- dml��ɾ�� commit, rollback�� ������ ������ �����ͺ��̽��� �ݿ��� �ȵ�
-- truncate�� ddl ��ɾ�� �� ��ü�� Ʈ������̱� ������ �����ϴ� ���� �����ͺ��̽��� ���������� �ݿ���

-- ���������� ���� �ٸ� ���̺� �ִ� �����͸� ������� ���� ����
DELETE emp
WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'SALES');

ROLLBACK;

DELETE dept
WHERE deptno = 10; -- ����, (���Ἲ ��������) �ڽķ��ڵ尡 �߰ߵǾ����ϴ�.

SELECT empno
FROM emp
WHERE ename = 'KING';

DELETE emp
WHERE empno = 7839; -- self join, �ڽ� '�÷�'���� �����ִ�

COMMIT;

SELECT *
FROM emp;

UPDATE emp
SET deptno = 40;

UPDATE emp
SET deptno = 30, ename = 'yedam';

ROLLBACK;

UPDATE emp
SET deptno = 30, ename = 'yedam'
WHERE empno = 7902;

-- �ٸ� ���̺��� ������� �� ����
UPDATE emp
SET job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'SALES'); 

ROLLBACK;

UPDATE emp
SET deptno = 22
WHERE deptno = 10; -- ����, dept ���̺� 22���� ����

SELECT *
FROM dept;
SELECT *
FROM emp;

-- ������ ��ųʸ� ����, runsql�̶� ��� ����� �ٸ���..?
SELECT *
FROM all_objects;

SELECT *
FROM user_objects;

SELECT * FROM all_objects;

SELECT table_name
FROM user_tables;

SELECT * FROM tab;

-- CREATE
CREATE TABLE sample 
( sam1 NUMBER(4),
  sam2 VARCHAR2(10),
  sam3 VARCHAR2(20));
  
DESC sample;

CREATE TABLE dept30
AS SELECT empno, ename, sal*12 ANNSAL, hiredate
   FROM emp
   WHERE deptno = 30; -- �������� ���뿡 ���缭 ������ ���Ա��� ��

DESC dept30;
SELECT * FROM dept30;

CREATE TABLE test1(id, name, no)
AS SELECT empno, ename, deptno
   FROM emp
   WHERE empno =1; -- emp�� ��ݿ� ���缭 ���̺��� ����� ������ emp�� ���� �����͸� ��ȸ�϶�� ������ �ɸ� ��
   
DESC test1;   
SELECT * from test1;

-- ALTER
DESC dept30;

ALTER TABLE dept30
ADD (job VARCHAR2(9));

DESC dept30;
SELECT * FROM dept30;

ALTER TABLE dept30 
ADD (yedam DATE DEFAULT SYSDATE);

ALTER TABLE dept30
MODIFY (ename VARCHAR2(4)); -- ���ڿ� �ʺ񺸴� �����Ͱ� ���̰� �� �� �� �־ ���� �� ��

ALTER TABLE dept30
MODIFY (job number(3)); -- job �÷��� ä���� �����Ͱ� �ƹ��͵� ��� ������� �ʺ�, ���� ���� ����

DESC dept30;

-- DROP, ���� �Ұ���

ALTER TABLE dept30
DROP COLUMN job;

ALTER TABLE dept30
DROP COLUMN yedam; 

-- SET UNUSED

ALTER TABLE dept30
SET UNUSED (hiredate);

DESC dept30;

ALTER TABLE dept30
DROP UNUSED COLUMNS;