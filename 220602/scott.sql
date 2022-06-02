-- 220602

DROP TABLE dept30;

RENAME sample TO sam;

-- 이름 바뀐 지 확인
SELECT *
from tab;

TRUNCATE TABLE sam;
-- = drop from sam

COMMENT ON TABLE emp
IS 'Employee Information';

-- 코멘트는 데이터 딕셔너리 뷰를 통해 확인
select comments
from user_tab_comments
where table_name = 'EMP';

DESC user__comments;

-- 제약조건
-- 제약조건 조회 by data dictionary
SELECT *
FROM user_constraints;

-- NOT NULL, 컬럼 레벨에서만 조건 지정 가능함

CREATE TABLE emp_test(
  empid NUMBER(5),
  empname VARCHAR2(10) NOT NULL,
  duty VARCHAR2(9),
  sal NUMBER(7,2), -- 전체 자리수, 소수점 이하 자리수
  bonus NUMBER(7,2),
  mgr NUMBER(5),
  hire_date DATE,
  deptid NUMBER(2));

DESC emp_test;  

INSERT INTO emp_test (empid, empname)
VALUES (null, null); -- 오류, empname은 not null로 제약조건이 걸려있어서 null값 삽입 불가

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
  
-- unique 제약조건은 구조확인에서는 안 보임
DESC dept_test;

INSERT INTO dept_test(deptid, dname)
VALUES (1, 'a');

INSERT INTO dept_test(deptid, dname)
VALUES (2, 'a'); -- 오류, unique 제약조건 위배

INSERT INTO dept_test(deptid, dname)
VALUES (3, null); 

INSERT INTO dept_test(deptid, dname)
VALUES (4, null); -- not null 엔 걸리지 않기 때문에 null 들 넣어도 ok

-- primary key

DROP TABLE dept_test;

CREATE TABLE dept_test(
  deptid NUMBER(2),
  dname VARCHAR2(14),
  loc VARCHAR2(13),
  PRIMARY KEY(deptid),
  UNIQUE(dname));

DESC dept_test; -- deptid에 not null 되어있다고 not null 제약조건이 걸린 건 아니다

INSERT INTO dept_test(deptid, dname)
VALUES (10, 'a');  

INSERT INTO dept_test(deptid, dname)
VALUES (10, 'b'); -- 오류 unique constraint violated

INSERT INTO dept_test(deptid, dname)
VALUES (null, 'c'); -- 오류 not null 위배

DROP TABLE emp_test;

-- foreign key

CREATE TABLE emp_test(
  empid NUMBER(5),
  empname VARCHAR2(10) NOT NULL,
  duty VARCHAR2(9),
  sal NUMBER(7,2), -- 전체 자리수, 소수점 이하 자리수
  bonus NUMBER(7,2),
  mgr NUMBER(5),
  hire_date DATE,
  deptid NUMBER(2),
  FOREIGN KEY (deptid)
  REFERENCES dept (deptno));
    
-- 컬럼 레벨에서 fk 지정할 때
-- deptid NUMBER(2) REFERENCES dept(deptid),

  
DESC dept;
DESC emp_test;

INSERT INTO emp_test(empid, empname, deptid)
VALUES (10, 'a', 10);

INSERT INTO emp_test(empid, empname, deptid)
VALUES (20, 'b', 9); -- 오류, 9가 dept의 deptno에 없음

INSERT INTO emp_test(empid, empname, deptid)
VALUES (30, 'c', null);

INSERT INTO emp_test(empid)
VALUES (null);

UPDATE emp_test
SET deptid = 9
where di; -- ? 타이핑 놓침

-- 컬럼 하나에 두 개의 제약조건을 걸 때에는 하나는 컬럼 레벨에, 다른 하나는 테이블 레벨에 기재
-- 디폴트로 NULL (널 들어갈 수 있다고)
-- ON DELETE CASCADE -- 요 놈은 안 쓰는 걸 권장
    -- FOREIGN KEY (컬럼명)
    -- REFERENCES 참조할 테이블명(컬럼명) ON DELETE CASCADE
-- ON DELETE SET NULL
    -- FOREIGN KEY (컬럼명)
    -- REFERENCES 참조할 테이블명(컬럼명) ON DELETE SET NULL
DROP TABLE emp_test;

CREATE TABLE emp_test(
  empid NUMBER(5),
  empname VARCHAR2(10) NOT NULL,
  duty VARCHAR2(9),
  sal NUMBER(7,2), -- 전체 자리수, 소수점 이하 자리수
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
WHERE deptno = 40; -- 오류, 자식 테이블에서 참조하고 있기 때문에 삭제 불가

DROP table emp_test;

CREATE TABLE emp_test(
  empid NUMBER(5),
  empname VARCHAR2(10) NOT NULL,
  duty VARCHAR2(9),
  sal NUMBER(7,2), -- 전체 자리수, 소수점 이하 자리수
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
WHERE deptno = 40; -- on delete set null 추가 후 삭제됨

SELECT *
FROM dept;

SELECT *
FROM emp_test;

-- 제약조건 수정(alter-add, modify)
ALTER TABLE emp_test
ADD FOREIGN KEY(mgr)
    REFERENCES emp(empno);

ALTER TABLE emp_test
MODIFY (duty VARCHAR2(9) NOT NULL); -- 오류 duty에 null 있어서 안됨

TRUNCATE table emp_test; -- 내용 다 잘라내기

ALTER TABLE emp_test
MODIFY (duty NOT NULL); -- duty에 varchar2 키워드 생략해도 됨

DESC emp_test;

-- 제약조건 보기
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints; -- 데이터 딕셔너리 뷰

-- 제약조건 삭제
ALTER TABLE dept_test
DROP PRIMARY KEY CASCADE; 

-- 제약조건 비활성화 DISABLE - ENABLE

-- 뷰
-- 데이터 엑세스 제한하기 위해, 복잡ㅈ한 질의 쉽게 작성하기 위해
-- 데이터 독립성 제공

CREATE VIEW v10 (empno, ename, ann_sal) 
AS SELECT empno, ename, sal*12 -- sal*12는 view의 컬럼명으로 쓸 수 없기 때문에 열 별칭이나 윗줄에 열 이름 지정해야
   FROM emp
   WHERE deptno = 10;

DESC v10;

SELECT * FROM v10;

SELECT empno, ename
FROM v10;

CREATE VIEW v10_1
AS SELECT empno, ename, sal*12 AS ann_sal -- emp의 컬럼명이 그대로 뷰의 컬럼명으로
   FROM emp
   WHERE deptno = 10;

SELECT * FROM v10_1;

-- 뷰 보기
SELECT * FROM USER_VIEWS;

-- 뷰 수정은 ALTER가 아닌 CREATE OR REPLACE(덮어쓰기)
-- 그치만 웬만하면 덮어쓰지 말고 새로운 뷰를 만드는 것(CREATE)이 좋다 

CREATE OR REPLACE VIEW v10 (id_number, name, sal, department_id)
AS SELECT empno, ename, sal, deptno
   FROM emp
   WHERE deptno = 20;

SELECT * FROM v10;   

CREATE VIEW v10 (empno, ename, ann_sal) 
AS SELECT empno, ename, sal*12 -- sal*12는 view의 컬럼명으로 쓸 수 없기 때문에 열 별칭이나 윗줄에 열 이름 지정해야
   FROM emp
   WHERE deptno = 10; -- 이미 존재하는 view라고 안만들어짐
   
-- 뷰 삭제
DROP VIEW v10;

-- 뷰를 통한 데이터 조작
CREATE VIEW v_test
AS SELECT deptno, sum(sal) SUM
   FROM emp
   GROUP BY deptno;

DELETE v_test
WHERE deptno = 10; -- 오류, 불가능

DELETE v10_1
WHERE empno = 7934;

SELECT * FROM v10_1; -- 인덱스에서는 사라짐
SELECT * FROM emp WHERE empno = 7934; -- 원본 테이블도 사라짐, view를 통해서 데이터 삭제가 가능하다!

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
values ('abc', 'daegu'); -- 오류, 기본키 입력을 안했다고

CREATE OR REPLACE VIEW v_ins
AS select deptno, dname, loc
   from dept;
   
INSERT INTO v_ins
values (88, 'abc', 'daegu'); -- 뷰를 통해 원본 테이블에 데이터 삽입 가능

SELECT e.empno, e.ename, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

-- 뷰를 이용하면, 매번 위 내용을 타이핑하지 않고 같은 내용을 아래와 같이 조회할 수 있다.

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
WHERE empno = 7788; -- 오류, with check option에 위배된다 -- 20번으로 부서번호 제약을 걸어놓았기 때문...

UPDATE empvu20
SET sal = 9999
WHERE empno = 7788;

SELECT * FROM emp WHERE empno = 7788;

ROLLBACK;

UPDATE empvu20
SET sal = 9999
WHERE empno = 7900; -- 오류는 아니지만 되지도 않음, 0개 행이 업데이트 됨, 범위(deptno = 20) 밖에 있는 값(30번 부서)이기 때문

DELETE empvu20
WHERE empno = 7900; -- 마찬가지

DELETE empvu20
WHERE empno = 7788; -- child record found

-- WITH READ ONLY, 이 옵션 쓰면 인서트, 딜리트, 업데이트 불가능함, 실습은 안함

-- 인덱스

CREATE table emp_ix 
as 
 SELECT *
 FROM emp
 WHERE deptno = 30;

CREATE INDEX sal_comm_idx
ON emp_ix(sal,comm);

-- 이 계정이 갖고 있는 객체들 조회
SELECT object_name, object_type
FROM user_objects;

DROP TABLE emp_ix; -- 테이블을 삭제하면 인덱스도 삭제됨

-- SEQUENCE, 번호 생성하는 거
DELETE dept 
WHERE deptno >= 50;

SELECT *
FROM dept;

CREATE SEQUENCE dept_deptno_seq -- 일케 명명했다고 dept 테이블에만 쓸 수 있는것도 아님,, 시퀀스는 공유 가능하기 때문에 어느 객체에서든 불러올 수 있다
       INCREMENT BY 10 -- 10씩 증가
       START WITH 50 -- 50번부터 시작
       MAXVALUE 110 -- 안 쓰면 nomaxvalue
       NOCYCLE -- nocycle이면 안 써도 됨
       NOCACHE; -- nocache는 안 써도 됨

INSERT INTO dept
VALUES (dept_deptno_seq.NEXTVAL, 'TESTING', 'SEOUL');

SELECT *
FROM dept;

DESC dept; -- 생성할 때 number를 두자리로 정해놓았기 때문에 sequence에서 최대값을 110으로 해놔도 90까지만 올라감

CREATE table dept_t
AS SELECT *
   FROM dept
   where deptno = 0; -- 서브쿼리를 통한 테이블 생성, dept 테이블의 껍데기만 빌려옴

-- 시퀀스 값 사이에 공백이 발생하는 경우
ALTER table dept_t
MODIFY deptno number(10);

INSERT INTO dept_t
VALUES (dept_deptno_seq.NEXTVAL, 'TESTING', 'SEOUL'); 
-- 오류 sequence DEPT_DEPTNO_SEQ.NEXTVAL exceeds MAXVALUE and cannot be instantiated
-- 저기 위에서 너무 많이 insert하려고 해서 이미 maxvalue값 초과 (120)

-- 시퀀스 정보 확인
-- USER_SEQUENCES 데이터 딕셔너리 테이블에서 시퀀스 값을 확인
SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM user_sequences;

-- 시퀀스 수정
-- 수정할 땐 start with가 없다
ALTER SEQUENCE dept_deptno_seq
  INCREMENT BY 20
  MAXVALUE 99999
  NOCYCLE
  NOCACHE;

SELECT * FROM dept_t; -- 라스트 넘버였던 120에서 20씩 증가하게 수정됨

-- 시퀀스 삭제: drop, 실습 안 함