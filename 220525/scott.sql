-- ���� - ���� - ����ȭ�鿡�� skjdb�� scott �������� ����ͼ� F5
/* ���� �� 
�ּ� */

SELECT *
FROM tab; 

-- ��(BIN) ������� �ϱ�
PURGE RECYCLEBIN;

SELECT *
FROM emp;

SELECT *
FROM dept;

SELECT *
FROM salgrade;

SELECT *
FROM bonus; -- ������ ����

SELECT empno
FROM emp;

SELECT empno, ename
FROM emp;

SELECT ename, empno -- select ���� ������ ������ ��µ�, ���� �ݴ�
FROM emp;

SELECT ename, empno, empno, mgr, deptno
FROM emp;

SELECT empno, empno
FROM emp; -- �� �� ������ �� ���� ����

SELECT empno, sal, sal+100
FROM emp;

SELECT empno, sal, comm, sal+comm
FROM emp;

SELECT ename+100
FROM emp; -- ���ڿ� ���� ���ϸ� ����

SELECT ename||'prof'
FROM emp; -- ���ڳ��� ������ ���� ���Ῥ����(||)�� ��������ǥ ���

SELECT sal+comm*12, (sal+comm)*12 
FROM emp; -- ������ �켱���� �߿�

SELECT ename, job, sal, comm
FROM emp;

SELECT ename, sal*12 + comm -- ����� �ȿ� null �� �����ϸ� ��� ���� null
FROM emp;

SELECT sal*12+NVL(comm,0) -- NVL �Լ��� �̿��ϸ� null�� 0���� �νĽ�ų �� �ִ�
FROM emp;

--Column Alias �� �Ӹ��� �̸� ����

SELECT ename AS name, sal salary -- �ٲٷ��� �� �̸��� �� �ܾ��� ��� AS ���� ����
FROM emp;

SELECT ename "Name", sal*12 "Annual Salary" -- ����, ��ҹ��� �����ϹǷ� ū ����ǥ �ȿ�(��� ����Ʈ ���� ���� �빮��)
FROM emp;

SELECT empno, sal ����#, sal "#����" -- �ѱ� �Է��� ���� ������ #, �տ� #�� ������ ū ����ǥ �ȿ�
FROM emp;

-- SQL���� ū ����ǥ ���� �Ŵ� �� �� ����. Column Alias �� �Ӹ��� ������ ��, ��ȯ �Լ� ���� �� ���� ��

-- ���� ������
SELECT ename || job AS "��� ��å"
FROM emp;

SELECT ename || ' ' || sal || empno || 'yedam'
FROM emp;

-- ���ͷ� ���ڿ�: ��¥ �� ���� ���ͷ� ���� ���� ����ǥ�� ����
SELECT ename || '���� ' || job || '�Դϴ�.'
AS "��� ��å"
FROM emp;

-- ���ڴ� '' ��� �νĵ����� �־ ����� ����
SELECT ename||sal||10000
FROM emp;

-- �ߺ��� ����: DISTINCT Ű����
SELECT DISTINCT deptno
FROM emp; -- 3��

SELECT DISTINCT deptno, mgr
FROM emp; -- 9�� DISTINCT Ű���� ������ �÷� �� �� �� ��� �� Į���� ���� ��츸 �ߺ����� ����

-- where������ ���ڿ� �� ��¥

SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10; -- ���ڴ� single quotation �ȿ� �� �־ ��

SELECT empno, ename, deptno
FROM emp
WHERE ename = 'MILLER'; -- ���ڰ� single-quotation

SELECT empno, ename, deptno
FROM emp
WHERE ename = 'miller'; -- ����� ����, ���� ���� ��ҹ��ڸ� ������

SELECT empno, ename, deptno
FROM emp
WHERE hiredate = '83/01/12'; -- ��¥�� single-quotation

SELECT empno, ename, deptno
FROM emp
WHERE hiredate = '12-JAN-83'; -- ����, �� Developer�� ��¥ ������ �ѱ� ���� yy/mm/dd

-- �� ������

SELECT *
FROM emp
WHERE deptno=10;

SELECT *
FROM emp
WHERE deptno>10;

SELECT empno, ename, job
FROM emp
WHERE empno=7934;

-- �� sw���� �����ϴ� ��¥ ���� ��ȸ�ϴ� ��
SELECT value
FROM NLS_SESSION_PARAMETERS
WHERE parameter = 'NLS_DATE_FORMAT';

-- ��¥ ���� �ٲ� ���� ����. ���� ���ǿ� ���Ͽ� ����Ǵ� ���̱� ������ �����ϸ� ������� ����
ALTER SESSION
SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

SELECT empno, hiredate
FROM emp;

-- SQL ������ : BETWEEN, IN, LIKE
-- value BETWEEN A and B 
SELECT ename, sal
FROM emp
WHERE sal BETWEEN 1000 AND 1500; -- 1000 <= sal <= 1500

-- ����� �߿��� 
-- �̸��� ù���ڰ� A�� ������� C�� ����� 
-- ����̸�, �޿��� ����ض�

SELECT ename, sal
FROM emp
WHERE ename BETWEEN 'A' AND 'Czzzzzz'; 
-- �̰� ����ϸ� C�� �����ϴ� ��� ����� �ȵ�
-- 'Czzzzzzzzzzz'�� ���..
-- '�达'�� ������� '�ھ�'�� ���: BETWEEN '��' AND '��������'

SELECT ASCII('Z'), ASCII('z')
FROM dual;

-- IN(����, ����, ����...)
-- IN('����', '����',,,)
SELECT empno, ename
FROM emp
WHERE empno IN(7934, 7502, 7500);

SELECT ename, sal, deptno
FROM emp
WHERE ename IN('JAMES', 'BLAKE');

-- LIKE ������
-- 0�� �̻��� ����: %
-- 1���� ����: _
SELECT empno, ename
FROM emp
WHERE ename LIKE 'A%';

SELECT empno, ename
FROM emp
WHERE ename LIKE '%T';

SELECT empno, ename
FROM emp
WHERE ename NOT LIKE '%T';

SELECT empno, ename
FROM emp
WHERE ename LIKE 'MILLE_';

INSERT INTO dept
VALUES (99, 'SALES_TEST', 'SEOUL');

SELECT *
FROM dept;

SELECT *
FROM dept
WHERE dname LIKE '%_%'; -- '_'�� �˻� �������� �ν��ؼ� ��� �����Ͱ� ��ȸ��

SELECT *
FROM dept
WHERE dname LIKE '%\_%' ESCAPE '\'; 
-- 'SALES_TEST' ���� ������ �ุ ��ȸ��
-- \ �ڸ��� �ϰų� �־ ��~

-- IS NULL ������
-- ����� �߿��� Ŀ�̼�(comm)�� ���� �ʴ� ����� ��ȸ�Ͻÿ�
SELECT *
FROM emp
WHERE comm IS NULL; -- comm = NULL; �ϸ� ����

-- ����� �߿��� Ŀ�̼��� �޴� ����� ��ȸ�Ͻÿ�
SELECT *
FROM emp
WHERE comm IS NOT NULL; 

-- �� ������ AND OR
SELECT empno, ename, job, sal, deptno
FROM emp
WHERE sal < 3000
AND deptno = 10; 

SELECT empno, ename, job, sal, deptno
FROM emp
WHERE sal < 3000
OR deptno = 10; 

SELECT empno, ename, job, sal
FROM emp
WHERE job = 'SALESMAN'
OR job = 'PRESIDENT'
AND sal >= 2000;
-- job�� salesman �̰ų� / president �̸鼭 �޿��� 2000�� �Ѵ� ���

SELECT empno, ename, job, sal
FROM emp
WHERE (job = 'SALESMAN'
OR job = 'PRESIDENT')
AND sal >= 2000;
-- job�� salesman�̳� president �鼭 / �޿��� 2000�� �Ѵ� ���

-- ORDER BY
SELECT empno, ename, hiredate
FROM emp
ORDER BY hiredate; -- ���� = ����Ʈ�� = ��������

SELECT empno, ename, hiredate
FROM emp
ORDER BY hiredate DESC; 

SELECT empno, ename, sal*12 annsal
FROM emp
ORDER BY annsal;

SELECT ename, deptno, sal
FROM emp
ORDER BY deptno, sal DESC;

SELECT empno, ename
FROM emp
ORDER BY deptno; -- SELECT ���� ���� �÷��� �������� ���ĵ� ����

SELECT empno, ename, sal*12
FROM emp
ORDER BY sal*12; -- Column Alias �ϰ� �÷��� �� ���� �� �ָ� �� ���� �״�� �����

SELECT empno, ename, sal*12
FROM emp
ORDER BY 3; -- �÷��� ��� �ʵ��ȣ��

SELECT empno, ename, comm
FROM emp
ORDER BY 3 DESC; -- null ���� ������������ �� �Ʒ�, ������������ ������ ��ġ


