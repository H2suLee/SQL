-- ���� �Լ� 1

 SELECT LOWER('YE DAM')
 FROM dual;
 
 SELECT UPPER('ye dam')
 FROM dual;
 
 SELECT INITCAP('ye dam')
 FROM dual;
 
 -- �����Լ� 2
-- CONCAT, SUBSTR, LENGTH, INSTR, LPAD, RPAD, TRIM

SELECT CONCAT(job, ename) -- �÷� �� ���� ������ ���� �ִ�
FROM emp;

SELECT SUBSTR('yedam', 3, 2)
FROM dual; -- da

SELECT SUBSTR('yedam', 3)
FROM dual; -- dam

SELECT SUBSTR('yedam', -4, 2)
FROM dual; -- �ڸ����� ������ �����ϸ� �ڿ������� �ڸ��� ī��Ʈ

SELECT SUBSTR(ename, 3, 2)
FROM emp;

SELECT LENGTH('yedam')
FROM dual; -- 5

SELECT LENGTH('�������������б�')
FROM dual; -- 8

SELECT LENGTH(ename)
FROM emp;

SELECT INSTR('yedamd', 'd')
FROM dual; -- ù��°�� ������ ������ ��ġ�� ����

SELECT INSTR(ename, 'I')
FROM emp; -- ������ ���ڰ� ������ 0�� ����

SELECT LPAD('yedam', 10, '*'), RPAD('yedam', 10, '$')
FROM dual;

SELECT LPAD(ename, 15, '* ^ *')
FROM emp;

SELECT TRIM('d' from 'ddyedamd')
FROM dual;

SELECT LTRIM('ddyedamd', 'd')
FROM dual; -- ���ʿ� �ִ� d�� �߶�, yedamd

SELECT RTRIM('ddyedamd', 'mda')
FROM dual; -- �����ʿ� �ִ� amd �߶�, ddye

-- ���ڿ� �Լ��� �� �ܿ��� ASCII, REPLACE, CHR, LENGTHB �� ����
SELECT ASCII('A')
FROM dual; --65
  
-- ���� �Լ��� ��¥ �Լ�
SELECT ROUND(345.678) AS round1,
       ROUND(345.678,0 ) AS round2,
       ROUND(345.678,1 ) AS round3,
       ROUND(345.678,-1 ) AS round4
FROM dual;

SELECT TRUNC(345.678) AS trunc1,
       TRUNC(345.678,0 ) AS trunc2,
       TRUNC(345.678,1 ) AS trunc3,
       TRUNC(345.678,-1 ) AS trunc4
FROM dual;

SELECT ename, sal, MOD(sal, 1000)
FROM emp;

SELECT ename, (SYSDATE-hiredate)/7 AS WEEKS
FROM emp 
WHERE deptno = 20; -- �ٹ��ּ�

SELECT ename, MONTHS_BETWEEN(SYSDATE, hiredate)
FROM emp
WHERE deptno = 20; -- �ٹ�������

SELECT ename, hiredate, ADD_MONTHS(hiredate, 6)
FROM emp
WHERE deptno = 20;

SELECT ename, NEXT_DAY(hiredate, '��'), LAST_DAY(hiredate) -- �ݿ����� ���ڰ����� 6
FROM emp
WHERE deptno=20;

ALTER SESSION SET 
NLS_DATE_FORMAT = 'RRRR-MM-DD HH24:MI';

SELECT SYSDATE,
ROUND(SYSDATE) ROUND1, -- �ڿ� �ƹ��͵� �Ⱦ��� 'DD'�� ����Ʈ��
ROUND(SYSDATE, 'DD') ROUND2, -- �Ϸ��� ���� ����
ROUND(SYSDATE, 'DAY') ROUND3, -- �������� ���� ������ 12��
ROUND(SYSDATE, 'MON') ROUND4, -- �Ѵ��� ���� 16�� 0��
ROUND(SYSDATE, 'YEAR') ROUND5 -- �ϳ��� ���� 6�� �������� 24��
FROM dual;

SELECT SYSDATE,
TRUNC(SYSDATE) TRUNC1, -- �ڿ� �ƹ��͵� �Ⱦ��� 'DD'�� ����Ʈ��
TRUNC(SYSDATE, 'DD') TRUNC2, -- �Ϸ��� �ݿø��� ������ 0�� 0��
TRUNC(SYSDATE, 'DAY') TRUNC3, -- �������� ���� ������ 12��
TRUNC(SYSDATE, 'MON') TRUNC4, -- �Ѵ��� ���� 16�� 0��
TRUNC(SYSDATE, 'YEAR') TRUNC5 -- �ϳ��� ���� 6�� �������� 24��
FROM dual;

-- RR ��¥ ����
CREATE TABLE test(
id NUMBER(3),
name VARCHAR2(10),
hiredate DATE);

INSERT INTO test
VALUES(1, 'SKJ', '95/03/01'); -- 1995

INSERT INTO test
VALUES(2, 'HKD', '10/03/01'); -- 2010

SELECT *
FROM test;

ALTER SESSION SET
NLS_DATE_FORMAT ='RRRR/MM/DD';

INSERT INTO test
VALUES(3, 'KKK', '95/03/01'); -- 2095

INSERT INTO test
VALUES(4, 'SSS', '10/03/01'); -- 2010

SELECT *
FROM test;

DROP TABLE test;

CREATE TABLE test(
id NUMBER(3),
name VARCHAR2(10),
hiredate DATE);

ALTER SESSION SET 
NLS_DATE_FORMAT = 'RR-MM-DD HH24:MI';

INSERT INTO test
VALUES(1, 'SKJ', '95/03/01'); -- 1995

INSERT INTO test
VALUES(2, 'HKD', '10/03/01'); -- 2010

SELECT *
FROM test;

ALTER SESSION SET 
NLS_DATE_FORMAT = 'RRRR-MM-DD HH24:MI';

SELECT *
FROM test;

SELECT empno, ename,
       TO_CHAR(hiredate, 'YYYY"��"-MM"��"') AS �Ի���
FROM emp;

ALTER SESSION SET
NLS_DATE_LANGUAGE = AMERICAN; -- �Ʒ� ���Ǹ� �׽�Ʈ�ϱ� ���� ��¥ ������ �̱� �������� ���� ����

SELECT TO_CHAR(hiredate, 'yyyy "��" DDSPTH Month hh:mi:ss pm') -- DDSPTH�� �ϸ� �� �빮��, Ddspth�� �ϸ� ù���ڸ� �빮��, ddspth�� �ϸ� �� �ҹ���
FROM emp
WHERE deptno = 30; -- TH ����(4 -> 4TH) / SP ���ڷ� ǥ���� ��(4 -> FOUR) / SPTH, THSP(4 -> FOURTH) ���ڷ� ����� ����

SELECT TO_CHAR(hiredate, 'fm yyyy "��" DDSPTH Month hh:mi:ss pm') -- DDSPTH�� �ϸ� �� �빮��, Ddspth�� �ϸ� ù���ڸ� �빮��, ddspth�� �ϸ� �� �ҹ���
FROM emp
WHERE deptno = 30;
