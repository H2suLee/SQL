-- 220527
-- ��ȯ �Լ� 1
-- ���� -> ���� To_Char

SELECT TO_CHAR(777.777, '$99999.9999')
FROM dual;

SELECT ename, TO_CHAR(sal, 'L099,999.9') salary
FROM emp; -- ����Ʈ���� ��ġ �� ������ ����(?)�� ���� ����ȭ�� ������

-- ��ȯ �Լ� 2 
-- ���� -> ���� To_Number

SELECT TO_NUMBER('$3,400', '$99,999')
FROM dual; -- ��� ��� ���������� ���ĵ�, ���ڱ� ����

SELECT TO_NUMBER('$1200', '$9999')
FROM dual;

SELECT TO_NUMBER('1200')
FROM dual;

SELECT '1200'
FROM dual; -- ���� ���ĵ�, ���ڱ� ����

SELECT TO_DATE('2010��, 02��', 'YYYY"��", MM"��"')
FROM dual; --  ��� ��� 10/02/01

SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('January 12, 1983', 'Month DD, YYYY'); -- ����

SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('1�� 12, 1983', 'Month DD, YYYY'); -- ����Ʈ���� ������ �ѱ�.. �ѱ� ����.. that's why..

SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('83/01/12', 'RR-MM-DD'); -- RR ��� YY�ϸ� �� ����

SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('83/1/12', 'RR/MM/DD'); -- RR ��� YY�ϸ� �� ����

SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('83/ 01/12', 'RR/MM/DD'); -- RR ��� YY�ϸ� �� ����


SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('83/01/12', 'fxRR-MM-DD'); -- ������

SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('83/1/12', 'fxRR/MM/DD'); -- ������

SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('83/01/12', 'fxRR/MM/DD'); -- ����

-- �Ϲ��Լ�
-- NVL
SELECT ename, NVL(comm, '���ʽ� ����') -- ������, comm�� ���� �ʵ�, �ڿ��� ����
FROM emp;

SELECT ename, NVL(TO_CHAR(comm), '���ʽ� ����') -- ������, comm�� ���� �ʵ�, �ڿ��� ����
FROM emp;

SELECT ename, NVL(comm, 0)
FROM emp;

-- ������� ����(sal+comm)*12�� ���Ͻÿ�
-- ��, ��� �̸�, �޿�, ���ʽ�(comm), ������ ����Ͻÿ�
SELECT ename "�̸�", sal "�޿�", NVL(comm,0) "���ʽ�", (sal+NVL(comm,0))*12 AS "����"
FROM emp;

-- NVL2, Oracle������ ����
SELECT NVL2(TO_CHAR(comm), TO_CHAR(comm), '���ʽ� ����')
FROM emp;

-- NULLIF, Oracle������ ����
SELECT ename, LENGTH(ename) "expr1", job, LENGTH(job) "expr2", NULLIF(LENGTH(ename), LENGTH(job)) result
FROM emp;

-- COALESCE..

-- CASE ǥ����
SELECT ename, job, sal,
       CASE job WHEN 'MANAGER' THEN sal*1.1
                WHEN 'ANALYST' THEN sal*1.2
                WHEN 'CLERK' THEN sal*1.3
                ELSE sal
       END
       AS "�λ�� �޿�"
FROM emp;

SELECT ename, job, sal,
       CASE WHEN sal < 1000 THEN sal*1.1
            WHEN sal < 2000 THEN sal*1.2
            WHEN sal < 3000 THEN sal*1.3
                ELSE sal
       END
       AS "�λ�� �޿�"
FROM emp;

-- DECODE, job �ڸ��� �񱳿����ڸ� �� ����
SELECT ename, job, sal,
       DECODE(job, 'MANAGER', sal*1.1,
                   'ANALYST', sal*1.2,
                   'CLERK', sal*1.3,
                            sal)
       AS "�λ�� �޿�"
FROM emp;

-- �׷��Լ�. default�� all
-- COUNT
SELECT *
FROM emp;

SELECT COUNT(*)
FROM emp
WHERE deptno = 10; -- �� ���� ���� ��� ����� �� null�� ����, �ߺ� ����

SELECT COUNT(comm)
FROM emp;

SELECT COUNT(DISTINCT deptno)
FROM emp;

SELECT SUM(sal), AVG(sal)
FROM emp;

SELECT MIN(hiredate), MAX(hiredate)
FROM emp; -- �Ի糯¥�� ������ �� ���� ��

-- SUM�̶� AVG�� �� ������ NVL ��ø�ؼ� null �� ��ƾ�
SELECT SUM(comm), SUM(NVL(comm,0))
FROM emp;

SELECT AVG(comm), AVG(NVL(comm,0))
FROM emp;

-- ������ �׷�ȭ
-- GROUP BY
SELECT deptno, AVG(NVL(sal,0))
FROM emp
GROUP BY deptno;

SELECT AVG(NVL(sal,0))
FROM emp
GROUP BY deptno; -- GROUP BY ���� ���̴� �÷��� SELECT ���� �� �� �ᵵ ��

SELECT deptno, AVG(NVL(sal,0))
FROM emp; --  ������, SELECT������ �׷� �Լ� �ȿ� ���� ������ �ݵ�� GROUP BY ���� ����
--GROUP BY deptno;

SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY deptno, job; -- GROUP BY ���� 1�� �̻��� �� ��� ����, �׷�� ���� �׷쿡 ���� ��� Ȯ��


