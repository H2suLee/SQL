-- 문자 함수 1

 SELECT LOWER('YE DAM')
 FROM dual;
 
 SELECT UPPER('ye dam')
 FROM dual;
 
 SELECT INITCAP('ye dam')
 FROM dual;
 
 -- 문자함수 2
-- CONCAT, SUBSTR, LENGTH, INSTR, LPAD, RPAD, TRIM

SELECT CONCAT(job, ename) -- 컬럼 두 개를 결합할 수도 있다
FROM emp;

SELECT SUBSTR('yedam', 3, 2)
FROM dual; -- da

SELECT SUBSTR('yedam', 3)
FROM dual; -- dam

SELECT SUBSTR('yedam', -4, 2)
FROM dual; -- 자리값을 음수로 지정하면 뒤에서부터 자리수 카운트

SELECT SUBSTR(ename, 3, 2)
FROM emp;

SELECT LENGTH('yedam')
FROM dual; -- 5

SELECT LENGTH('예담직업전문학교')
FROM dual; -- 8

SELECT LENGTH(ename)
FROM emp;

SELECT INSTR('yedamd', 'd')
FROM dual; -- 첫번째로 만나는 문자의 위치값 리턴

SELECT INSTR(ename, 'I')
FROM emp; -- 만나는 문자가 없으면 0을 리턴

SELECT LPAD('yedam', 10, '*'), RPAD('yedam', 10, '$')
FROM dual;

SELECT LPAD(ename, 15, '* ^ *')
FROM emp;

SELECT TRIM('d' from 'ddyedamd')
FROM dual;

SELECT LTRIM('ddyedamd', 'd')
FROM dual; -- 왼쪽에 있는 d만 잘라냄, yedamd

SELECT RTRIM('ddyedamd', 'mda')
FROM dual; -- 오른쪽에 있는 amd 잘라냄, ddye

-- 문자열 함수는 이 외에도 ASCII, REPLACE, CHR, LENGTHB 등 많음
SELECT ASCII('A')
FROM dual; --65
  
-- 숫자 함수와 날짜 함수
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
WHERE deptno = 20; -- 근무주수

SELECT ename, MONTHS_BETWEEN(SYSDATE, hiredate)
FROM emp
WHERE deptno = 20; -- 근무개월수

SELECT ename, hiredate, ADD_MONTHS(hiredate, 6)
FROM emp
WHERE deptno = 20;

SELECT ename, NEXT_DAY(hiredate, '금'), LAST_DAY(hiredate) -- 금요일은 숫자값으로 6
FROM emp
WHERE deptno=20;

ALTER SESSION SET 
NLS_DATE_FORMAT = 'RRRR-MM-DD HH24:MI';

SELECT SYSDATE,
ROUND(SYSDATE) ROUND1, -- 뒤에 아무것도 안쓰면 'DD'가 디폴트값
ROUND(SYSDATE, 'DD') ROUND2, -- 하루의 반은 정오
ROUND(SYSDATE, 'DAY') ROUND3, -- 일주일의 반은 수요일 12시
ROUND(SYSDATE, 'MON') ROUND4, -- 한달의 반은 16일 0시
ROUND(SYSDATE, 'YEAR') ROUND5 -- 일년의 반은 6월 마지막날 24시
FROM dual;

SELECT SYSDATE,
TRUNC(SYSDATE) TRUNC1, -- 뒤에 아무것도 안쓰면 'DD'가 디폴트값
TRUNC(SYSDATE, 'DD') TRUNC2, -- 하루의 반올림은 다음날 0시 0분
TRUNC(SYSDATE, 'DAY') TRUNC3, -- 일주일의 반은 수요일 12시
TRUNC(SYSDATE, 'MON') TRUNC4, -- 한달의 반은 16일 0시
TRUNC(SYSDATE, 'YEAR') TRUNC5 -- 일년의 반은 6월 마지막날 24시
FROM dual;

-- RR 날짜 형식
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
       TO_CHAR(hiredate, 'YYYY"년"-MM"월"') AS 입사년월
FROM emp;

ALTER SESSION SET
NLS_DATE_LANGUAGE = AMERICAN; -- 아래 질의를 테스트하기 위해 날짜 포맷을 미국 형식으로 세션 변경

SELECT TO_CHAR(hiredate, 'yyyy "년" DDSPTH Month hh:mi:ss pm') -- DDSPTH로 하면 다 대문자, Ddspth로 하면 첫글자만 대문자, ddspth로 하면 다 소문자
FROM emp
WHERE deptno = 30; -- TH 서수(4 -> 4TH) / SP 문자로 표시한 수(4 -> FOUR) / SPTH, THSP(4 -> FOURTH) 문자로 명시한 서수

SELECT TO_CHAR(hiredate, 'fm yyyy "년" DDSPTH Month hh:mi:ss pm') -- DDSPTH로 하면 다 대문자, Ddspth로 하면 첫글자만 대문자, ddspth로 하면 다 소문자
FROM emp
WHERE deptno = 30;
