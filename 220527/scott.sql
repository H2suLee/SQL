-- 220527
-- 변환 함수 1
-- 숫자 -> 문자 To_Char

SELECT TO_CHAR(777.777, '$99999.9999')
FROM dual;

SELECT ename, TO_CHAR(sal, 'L099,999.9') salary
FROM emp; -- 소프트웨어 설치 시 설정한 국적(?)에 따라 지역화폐 설정됨

-- 변환 함수 2 
-- 문자 -> 숫자 To_Number

SELECT TO_NUMBER('$3,400', '$99,999')
FROM dual; -- 출력 결과 오른쪽으로 정렬됨, 숫자기 때문

SELECT TO_NUMBER('$1200', '$9999')
FROM dual;

SELECT TO_NUMBER('1200')
FROM dual;

SELECT '1200'
FROM dual; -- 왼쪽 정렬됨, 문자기 때문

SELECT TO_DATE('2010년, 02월', 'YYYY"년", MM"월"')
FROM dual; --  출력 결과 10/02/01

SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('January 12, 1983', 'Month DD, YYYY'); -- 오류

SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('1월 12, 1983', 'Month DD, YYYY'); -- 소프트웨어 국적이 한국.. 한글 버젼.. that's why..

SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('83/01/12', 'RR-MM-DD'); -- RR 대신 YY하면 안 나옴

SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('83/1/12', 'RR/MM/DD'); -- RR 대신 YY하면 안 나옴

SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('83/ 01/12', 'RR/MM/DD'); -- RR 대신 YY하면 안 나옴


SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('83/01/12', 'fxRR-MM-DD'); -- 오류남

SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('83/1/12', 'fxRR/MM/DD'); -- 오류남

SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate = TO_DATE('83/01/12', 'fxRR/MM/DD'); -- 나옴

-- 일반함수
-- NVL
SELECT ename, NVL(comm, '보너스 없음') -- 오류남, comm은 숫자 필드, 뒤에건 문자
FROM emp;

SELECT ename, NVL(TO_CHAR(comm), '보너스 없음') -- 오류남, comm은 숫자 필드, 뒤에건 문자
FROM emp;

SELECT ename, NVL(comm, 0)
FROM emp;

-- 사원들의 연봉(sal+comm)*12를 구하시오
-- 단, 사원 이름, 급여, 보너스(comm), 연봉을 출력하시오
SELECT ename "이름", sal "급여", NVL(comm,0) "보너스", (sal+NVL(comm,0))*12 AS "연봉"
FROM emp;

-- NVL2, Oracle에서만 지원
SELECT NVL2(TO_CHAR(comm), TO_CHAR(comm), '보너스 없음')
FROM emp;

-- NULLIF, Oracle에서만 지원
SELECT ename, LENGTH(ename) "expr1", job, LENGTH(job) "expr2", NULLIF(LENGTH(ename), LENGTH(job)) result
FROM emp;

-- COALESCE..

-- CASE 표현식
SELECT ename, job, sal,
       CASE job WHEN 'MANAGER' THEN sal*1.1
                WHEN 'ANALYST' THEN sal*1.2
                WHEN 'CLERK' THEN sal*1.3
                ELSE sal
       END
       AS "인상된 급여"
FROM emp;

SELECT ename, job, sal,
       CASE WHEN sal < 1000 THEN sal*1.1
            WHEN sal < 2000 THEN sal*1.2
            WHEN sal < 3000 THEN sal*1.3
                ELSE sal
       END
       AS "인상된 급여"
FROM emp;

-- DECODE, job 자리에 비교연산자를 못 넣음
SELECT ename, job, sal,
       DECODE(job, 'MANAGER', sal*1.1,
                   'ANALYST', sal*1.2,
                   'CLERK', sal*1.3,
                            sal)
       AS "인상된 급여"
FROM emp;

-- 그룹함수. default가 all
-- COUNT
SELECT *
FROM emp;

SELECT COUNT(*)
FROM emp
WHERE deptno = 10; -- 이 절을 빼면 모든 사원들 수 null값 포함, 중복 포함

SELECT COUNT(comm)
FROM emp;

SELECT COUNT(DISTINCT deptno)
FROM emp;

SELECT SUM(sal), AVG(sal)
FROM emp;

SELECT MIN(hiredate), MAX(hiredate)
FROM emp; -- 입사날짜가 빠르면 더 작은 값

-- SUM이랑 AVG할 때 무조건 NVL 중첩해서 null 값 잡아야
SELECT SUM(comm), SUM(NVL(comm,0))
FROM emp;

SELECT AVG(comm), AVG(NVL(comm,0))
FROM emp;

-- 데이터 그룹화
-- GROUP BY
SELECT deptno, AVG(NVL(sal,0))
FROM emp
GROUP BY deptno;

SELECT AVG(NVL(sal,0))
FROM emp
GROUP BY deptno; -- GROUP BY 절에 쓰이는 컬럼을 SELECT 절에 꼭 안 써도 됨

SELECT deptno, AVG(NVL(sal,0))
FROM emp; --  오류남, SELECT절에서 그룹 함수 안에 없는 열들은 반드시 GROUP BY 절에 포함
--GROUP BY deptno;

SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY deptno, job; -- GROUP BY 절에 1개 이상의 열 사용 가능, 그룹과 서브 그룹에 대한 통계 확인


