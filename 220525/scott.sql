-- 파일 - 열기 - 바탕화면에서 skjdb를 scott 계정으로 갖고와서 F5
/* 여러 줄 
주석 */

SELECT *
FROM tab; 

-- 빈(BIN) 사라지게 하기
PURGE RECYCLEBIN;

SELECT *
FROM emp;

SELECT *
FROM dept;

SELECT *
FROM salgrade;

SELECT *
FROM bonus; -- 데이터 없음

SELECT empno
FROM emp;

SELECT empno, ename
FROM emp;

SELECT ename, empno -- select 절에 나열된 순서로 출력됨, 위와 반대
FROM emp;

SELECT ename, empno, empno, mgr, deptno
FROM emp;

SELECT empno, empno
FROM emp; -- 두 번 나오게 할 수도 있음

SELECT empno, sal, sal+100
FROM emp;

SELECT empno, sal, comm, sal+comm
FROM emp;

SELECT ename+100
FROM emp; -- 문자에 숫자 더하면 에러

SELECT ename||'prof'
FROM emp; -- 문자끼리 결합할 때는 연결연산자(||)와 작은따옴표 사용

SELECT sal+comm*12, (sal+comm)*12 
FROM emp; -- 연산자 우선순위 중요

SELECT ename, job, sal, comm
FROM emp;

SELECT ename, sal*12 + comm -- 산술식 안에 null 을 포함하면 결과 값도 null
FROM emp;

SELECT sal*12+NVL(comm,0) -- NVL 함수를 이용하면 null을 0으로 인식시킬 수 있다
FROM emp;

--Column Alias 열 머리글 이름 변경

SELECT ename AS name, sal salary -- 바꾸려는 열 이름이 한 단어일 경우 AS 생략 가능
FROM emp;

SELECT ename "Name", sal*12 "Annual Salary" -- 공백, 대소문자 구분하므로 큰 따옴표 안에(출력 디폴트 값은 전원 대문자)
FROM emp;

SELECT empno, sal 연봉#, sal "#연봉" -- 한글 입력할 때는 오른편에 #, 앞에 #을 넣으면 큰 따옴표 안에
FROM emp;

-- SQL에서 큰 따옴표 쓰는 거는 단 두 군데. Column Alias 열 머리글 수정할 때, 변환 함수 형식 모델 기입 시

-- 연결 연산자
SELECT ename || job AS "사원 직책"
FROM emp;

SELECT ename || ' ' || sal || empno || 'yedam'
FROM emp;

-- 리터럴 문자열: 날짜 및 문자 리터럴 값은 작은 따옴표로 묶음
SELECT ename || '씨는 ' || job || '입니다.'
AS "사원 직책"
FROM emp;

-- 숫자는 '' 없어도 인식되지만 있어도 상관은 없다
SELECT ename||sal||10000
FROM emp;

-- 중복행 제거: DISTINCT 키워드
SELECT DISTINCT deptno
FROM emp; -- 3개

SELECT DISTINCT deptno, mgr
FROM emp; -- 9개 DISTINCT 키워드 다음에 컬럼 두 개 쓸 경우 두 칼럼이 같은 경우만 중복으로 인지

-- where절에서 문자열 및 날짜

SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10; -- 숫자는 single quotation 안에 안 넣어도 됨

SELECT empno, ename, deptno
FROM emp
WHERE ename = 'MILLER'; -- 문자값 single-quotation

SELECT empno, ename, deptno
FROM emp
WHERE ename = 'miller'; -- 결과값 없음, 문자 값은 대소문자를 구분함

SELECT empno, ename, deptno
FROM emp
WHERE hiredate = '83/01/12'; -- 날짜값 single-quotation

SELECT empno, ename, deptno
FROM emp
WHERE hiredate = '12-JAN-83'; -- 오류, 이 Developer의 날짜 형식은 한국 형식 yy/mm/dd

-- 비교 연산자

SELECT *
FROM emp
WHERE deptno=10;

SELECT *
FROM emp
WHERE deptno>10;

SELECT empno, ename, job
FROM emp
WHERE empno=7934;

-- 이 sw에서 제공하는 날짜 형식 조회하는 법
SELECT value
FROM NLS_SESSION_PARAMETERS
WHERE parameter = 'NLS_DATE_FORMAT';

-- 날짜 형식 바꿀 수도 있음. 현재 세션에 한하여 적용되는 것이기 때문에 종료하면 변경사항 날라감
ALTER SESSION
SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

SELECT empno, hiredate
FROM emp;

-- SQL 연산자 : BETWEEN, IN, LIKE
-- value BETWEEN A and B 
SELECT ename, sal
FROM emp
WHERE sal BETWEEN 1000 AND 1500; -- 1000 <= sal <= 1500

-- 사원들 중에서 
-- 이름의 첫글자가 A인 사원부터 C인 사원의 
-- 사원이름, 급여를 출력해라

SELECT ename, sal
FROM emp
WHERE ename BETWEEN 'A' AND 'Czzzzzz'; 
-- 이거 출력하면 C로 시작하는 사람 출력이 안됨
-- 'Czzzzzzzzzzz'로 써야..
-- '김씨'인 사원부터 '박씨'인 사원: BETWEEN 'ㄱ' AND '비히히히'

SELECT ASCII('Z'), ASCII('z')
FROM dual;

-- IN(숫자, 숫자, 숫자...)
-- IN('문자', '문자',,,)
SELECT empno, ename
FROM emp
WHERE empno IN(7934, 7502, 7500);

SELECT ename, sal, deptno
FROM emp
WHERE ename IN('JAMES', 'BLAKE');

-- LIKE 연산자
-- 0개 이상의 문자: %
-- 1개의 문자: _
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
WHERE dname LIKE '%_%'; -- '_'를 검색 조건으로 인식해서 모든 데이터가 조회됨

SELECT *
FROM dept
WHERE dname LIKE '%\_%' ESCAPE '\'; 
-- 'SALES_TEST' 값을 포함한 행만 조회됨
-- \ 자리에 암거나 넣어도 됨~

-- IS NULL 연산자
-- 사원들 중에서 커미션(comm)을 받지 않는 사원을 조회하시오
SELECT *
FROM emp
WHERE comm IS NULL; -- comm = NULL; 하면 오류

-- 사원들 중에서 커미션을 받는 사원을 조회하시오
SELECT *
FROM emp
WHERE comm IS NOT NULL; 

-- 논리 연산자 AND OR
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
-- job이 salesman 이거나 / president 이면서 급여가 2000불 넘는 사람

SELECT empno, ename, job, sal
FROM emp
WHERE (job = 'SALESMAN'
OR job = 'PRESIDENT')
AND sal >= 2000;
-- job이 salesman이나 president 면서 / 급여가 2000불 넘는 사람

-- ORDER BY
SELECT empno, ename, hiredate
FROM emp
ORDER BY hiredate; -- 생략 = 디폴트값 = 오름차순

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
ORDER BY deptno; -- SELECT 절에 없는 컬럼을 기준으로 정렬도 가능

SELECT empno, ename, sal*12
FROM emp
ORDER BY sal*12; -- Column Alias 하고 컬럼명 값 따로 안 주면 그 내용 그대로 적어야

SELECT empno, ename, sal*12
FROM emp
ORDER BY 3; -- 컬럼명 대신 필드번호를

SELECT empno, ename, comm
FROM emp
ORDER BY 3 DESC; -- null 값은 오름차순에선 맨 아래, 내림차순에선 맨위에 위치


