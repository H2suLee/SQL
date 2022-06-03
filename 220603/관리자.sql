-- 220603
-- 관리자 비번 oracle

-- 사용자 생성
CREATE USER skj
IDENTIFIED BY test;

GRANT CREATE SESSION -- 접속 권한
TO skj;

-- 사용자 수정 = 비밀번호 변경
ALTER USER skj
IDENTIFIED BY lion;

GRANT CREATE TABLE, CREATE VIEW
TO skj;

GRANT CREATE TABLESPACE to skj; -- 요 구문은 실행되는데 skj 계정으로 가서 create문을 실행하려니 오류남

-- unlimited tablespace 권한 부여하는 걸로 다시

CREATE USER lhs
IDENTIFIED BY test;

GRANT CREATE SESSION, CREATE TABLE
TO lhs;

GRANT unlimited tablespace to lhs; -- 원래는 tablespace 자동 할당받기 때문에 사용자 계정 생성할 때 안 해줘도 되는데 이제는 해줘야 된대요

select * from system_privilege_map where lower(name) = 'unlimited tablespace';

REVOKE create table, create view
FROM skj;

CREATE ROLE manager;

GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW
TO manager;

GRANT manager 
TO skj;

DROP ROLE manager;

