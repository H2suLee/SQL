-- 220603
-- SYNONYM

CREATE SYNONYM e_sum
FOR empvu20;

SELECT *
FROM e_sum;

SELECT *
FROM empvu20;

-- 동의어 정보 확인
SELECT synonym_name, table_owner, table_name
FROM user_synonyms;

CREATE TABLE yd_test
AS SELECT * FROM dept;

SELECT * FROM yd_test;

CREATE INDEX yd_ix
ON yd_test(dname);

CREATE VIEW testvu
AS SELECT dname
   FROM yd_test;
   
DROP TABLE yd_test; -- 원본 테이블을 삭제  
-- yd_ix 인덱스만 삭제되고 ytest 동의어랑 testvu 뷰는 살아 있음
-- 근데 실행하면 no longer valid 오류남
SELECT * FROM ytest; 
SELECT * FROM testvu;


-- 객체 확인
SELECT object_name, object_type
FROM user_objects;

-- DCL
SELECT *
FROM system_privilege_map;

-- 객체 권한
SELECT * 
FROM hr.employees; -- 오류

SELECT * 
FROM hr.employees; -- hr이 조회 권한 부여해 주고 나서는 실행 가능

REVOKE select -- grant한 적이 없어서 회수도 불가능
ON dept
FROM skj;

-- 휴지통 기능
SELECT object_name, original_name, type
FROM user_recyclebin;

CREATE TABLE yd_2
AS SELECT *
   FROM emp;
   
CREATE TABLE yd_3
AS SELECT *
   FROM emp;

PURGE recyclebin; -- 휴지통비우기

DROP TABLE yd_3;
DROP TABLE yd_2 PURGE; -- 삭제하는 즉시 휴지통 비우기

FLASHBACK TABLE yd_3 TO BEFORE DROP;

DROP TABLE yd_3;

SHOW recyclebin; -- 휴지통을 다 비운 상태에서 show하면 '객체가 부적합합니다' 오류 메시지 뜸

FLASHBACK TABLE yd_3 TO BEFORE DROP;

-- 치환 변수
SELECT * 
FROM emp
WHERE sal = &sal; -- 치환 변수 이게 뭔데 그래서

-- 치환 변수를 이용하여 사원번호를 입력할 경우 사원 이름과 부서번호를 출력하시오
SELECT ename, deptno
FROM emp
WHERE empno = &no; -- 치환 변수는 현재 세션에서만 적용된다

-- &&