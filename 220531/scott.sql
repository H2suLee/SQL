-- 220531
-- 서브쿼리
SELECT ename, job, sal
FROM emp
WHERE sal = (SELECT MIN(sal)
             FROM emp);
             
-- 이걸 서브쿼리 안 쓰고 할라면 오류남             
SELECT ename, job, sal
FROM emp
WHERE sal = MIN(sal); -- 그룹함수는 where절에서 쓰일 수 없다

SELECT job, AVG(sal)
FROM emp
GROUP BY job;

SELECT MIN(AVG(sal))
FROM emp
GROUP BY job;

-- 서브쿼리를 사용하면 위의 두 질의가 아래와 같이 하나로 합쳐짐

SELECT job, AVG(sal)
FROM emp
GROUP BY job
HAVING AVG(sal) > (SELECT MIN(AVG(sal))
                   FROM emp
                   GROUP BY job);
                   
-- 단일 행 서브쿼리에서 여러 행이 반환되어 오류뜸
SELECT empno, ename
FROM emp
WHERE sal = (SELECT MIN(sal)
             FROM emp
             GROUP BY deptno);

-- IN으로 수정하면 뜸
-- IN, ANY, ALL 중에 IN이 제일 많이 쓰인다..
-- 리턴 값이 하나인 서브쿼리를 받아도 = 대신 IN을 쓰는 사람들이 많다..
-- 근데 컴파일 속도는 =이 빠르다..
-- 가급적이면 단일행이면 =, 복수행이면 in을 쓰는 것이 정확하다
SELECT empno, ename
FROM emp
WHERE sal IN (SELECT MIN(sal)
             FROM emp
             GROUP BY deptno);
/*월 : 김치돼지찌개
화 : 제육볶음
수 : 소고기전골
목 : 돼지갈비
금 : 차돌박이 된장찌개입니다
*/
-- ANY 연산자 사용하기
-- < ANY 최대값보다 작음을 의미
-- > ANY 최소값보다 큼을 의미
-- = ANY  IN과 동일

SELECT *
FROM emp;

SELECT empno, ename, job, sal
FROM emp
WHERE sal < ANY (SELECT sal -- 2975, 2850, 2450 반환
                 FROM emp
                 WHERE job = 'MANAGER')
AND job <> 'MANAGER';

SELECT empno, ename, job
FROM emp
WHERE sal > ANY (SELECT sal
                 FROM emp
                 WHERE job = 'MANAGER')
AND job <> 'MANAGER';

-- ALL 연산자
-- < ALL 최소값보다 작음을 의미
-- > ALL 최대값보다 큼을 의미
-- = ALL 은 쓰레기값 리턴

SELECT empno, ename, job, sal
FROM emp
WHERE sal > ALL (SELECT AVG(sal) -- 2916보다 큰 값들
                 FROM emp
                 GROUP BY deptno); 

SELECT empno, ename, job, sal
FROM emp
WHERE sal < ALL (SELECT AVG(sal) -- 1566보다 작은 값들
                 FROM emp
                 GROUP BY deptno);

SELECT AVG(sal)
FROM emp
GROUP BY deptno; -- 1566, 2175, 2916 반환

UPDATE emp
SET sal = 1250, comm= 1400
WHERE empno = 7782;

UPDATE emp
SET comm= 500
WHERE empno = 7839;

SELECT *
from EMP;

-- pairwise
-- MARTIN, 1250, 1400, 30 행 하나 반환
SELECT ename, sal, comm, deptno
FROM emp
WHERE (sal, NVL(comm, -1)) IN (SELECT sal, NVL(comm, -1)
                               FROM emp
                               WHERE deptno = 10)
AND deptno <> 10;                               

-- non-pairwise
-- WARD랑 MARTIN 총 두 행
SELECT ename, sal, comm, deptno
FROM emp
WHERE sal IN (SELECT sal
              FROM emp
              WHERE deptno = 10)
AND NVL(comm, -1) IN (SELECT NVL(comm, -1)
                      FROM emp
                      WHERE deptno = 10)                      
AND deptno <> 10;                               

-- from절에 서브쿼리 사용
-- 부서별 평균급여보다 급여를 많이 받는 사람들
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

-- 컬럼의 순서는 desc해서 확인 가능
DESC dept;

-- 모든 컬럼에 값을 다 넣고 싶으면 INTO 옆에 컬럼을 명시 안 해줘도 됨
-- 단, 순서는 컬럼의 original 순서와 동일해야하고 데이터 타입도 같아야
INSERT INTO dept
VALUES (51, 'YEDAM', 'DAEGU');

-- 특정 컬럼에 값을 삽입할 경우 컬럼의 original 순서를 꼭 지킬 필요는 없다
-- loc에 null 값 넣어보기
-- 암시적
INSERT INTO dept(deptno, dname)
VALUES (60, 'TESTING01');

-- 명시적
INSERT INTO dept
VALUES (70, 'TESTING02', NULL);

INSERT INTO dept
VALUES (80, '', '');

-- 따옴표 안에 스페이스바로 공백을 주면 null이 아니라 문자열로 인식됨
INSERT INTO dept
VALUES (81, ' ', ' ');

INSERT INTO emp(empno, ename, hiredate, sal, comm, deptno)
VALUES (1111, USER, SYSDATE, 3000, NULL, 20); --user는 scott

INSERT INTO emp(empno, ename, hiredate)
VALUES (3333, 'LEE', TO_DATE('5월/05 2010', 'MON/DD YYYY')); -- 날짜를 일케 입력하면 컴터가 yy/mm/dd로 받아들임

SELECT *
FROM emp;

CREATE TABLE s_emp
  (empid NUMBER(5),
   empname VARCHAR2(10),
   mgr NUMBER(5),
   sal NUMBER(7,2),
   deptid NUMBER(2));

-- 서브쿼리로 INSERT문 작성, 할 때에는 values절 사용하지 않음
-- 모든 컬럼에 다 집어넣을 거기 때문에 s_emp 뒤에 괄호 안 열음
INSERT INTO s_emp
 SELECT empno, ename, mgr, sal, deptno
 FROM emp;

SELECT *
FROM dept;

INSERT INTO dept(dname, loc)
VALUES ('YEDAM', 'DAEGU'); -- 기본키(deptno)가 null, cannot insert NULL into ("SCOTT"."DEPT"."DEPTNO")

INSERT INTO dept
VALUES (10, 'YEDAM', 'DAEGU'); -- 중복

INSERT INTO dept
VALUES (91, 'YEDAM', 'DAEGU'); -- 됨

INSERT INTO dept
VALUES (91, 'YEDAM', 'DAEGU'); -- 중복

-- dept 부모 , emp 자식
-- dept의 기본키(PK)가 deptno, 글구 이건 emp의 외래키(FK)
-- dept에서 PK로 갖고있는 데이타만 emp에서 삽입할 수 있다

INSERT INTO emp(empno, ename, deptno) -- 됨, dept의 deptno에서 99를 갖고 있음
VALUES (9999, 'YEDAM', 99);

INSERT INTO emp(empno, ename, deptno)
VALUES (9991, 'YEDAM', 00); -- 안됨 dept의 deptno에서 0을 안 갖고 있음

INSERT INTO emp(empno, ename, deptno)
VALUES (9991, 'YEDAM', 01); -- 안됨 dept의 deptno에서 1을 안 갖고 있음

INSERT INTO emp(empno, ename, deptno)
VALUES (9991, 'YEDAM', 10); -- 됨, dept의 deptno에서 10을 갖고 있음

INSERT INTO emp(empno, ename, deptno)
VALUES (9992, 'YEDAM', null); -- FK가 null이라도 들어감
-- not null 제약조건이 걸려있는 곳과 기본키 자리를 제외하곤 null값 다 들어감

DELETE FROM emp;

SELECT *
FROM emp;

ROLLBACK; -- 되돌리기

DELETE FROM dept
WHERE deptno = 50;

SELECT *
FROM dept;

COMMIT; -- 영구적으로 데이터베이스에 반영

SELECT *
FROM s_emp;

INSERT INTO s_emp
  SELECT empno, ename, mgr, sal, deptno
  FROM emp;

COMMIT;  

DELETE FROM s_emp;

ROLLBACK;

TRUNCATE TABLE s_emp; -- 일케 하면 rollback 해도 복구 안 됨
-- delete는 dml 명령어, truncate는 ddl 명령어
-- dml명령어는 commit, rollback을 만나기 전까진 데이터베이스에 반영이 안됨
-- truncate는 ddl 명령어고 그 자체가 트랜잭션이기 때문에 실행하는 순간 데이터베이스에 영구적으로 반영됨

-- 서브쿼리를 통해 다른 테이블에 있는 데이터를 기반으로 삭제 가능
DELETE emp
WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'SALES');

ROLLBACK;

DELETE dept
WHERE deptno = 10; -- 오류, (무결성 제약조건) 자식레코드가 발견되었습니다.

SELECT empno
FROM emp
WHERE ename = 'KING';

DELETE emp
WHERE empno = 7839; -- self join, 자식 '컬럼'에서 쓰고있다

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

-- 다른 테이블을 기반으로 행 갱신
UPDATE emp
SET job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'SALES'); 

ROLLBACK;

UPDATE emp
SET deptno = 22
WHERE deptno = 10; -- 오류, dept 테이블에 22번이 없다

SELECT *
FROM dept;
SELECT *
FROM emp;

-- 데이터 딕셔너리 예제, runsql이랑 출력 결과가 다르다..?
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
   WHERE deptno = 30; -- 서브쿼리 내용에 맞춰서 데이터 삽입까지 됨

DESC dept30;
SELECT * FROM dept30;

CREATE TABLE test1(id, name, no)
AS SELECT empno, ename, deptno
   FROM emp
   WHERE empno =1; -- emp의 골격에 맞춰서 테이블을 만들고 싶으면 emp에 없는 데이터를 조회하라고 조건을 걸면 됨
   
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
MODIFY (ename VARCHAR2(4)); -- 문자열 너비보다 데이터가 길이가 더 긴 게 있어서 변경 안 됨

ALTER TABLE dept30
MODIFY (job number(3)); -- job 컬럼에 채워진 데이터가 아무것도 없어서 제약없이 너비, 유형 변경 가능

DESC dept30;

-- DROP, 복구 불가능

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