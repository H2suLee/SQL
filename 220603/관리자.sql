-- 220603
-- ������ ��� oracle

-- ����� ����
CREATE USER skj
IDENTIFIED BY test;

GRANT CREATE SESSION -- ���� ����
TO skj;

-- ����� ���� = ��й�ȣ ����
ALTER USER skj
IDENTIFIED BY lion;

GRANT CREATE TABLE, CREATE VIEW
TO skj;

GRANT CREATE TABLESPACE to skj; -- �� ������ ����Ǵµ� skj �������� ���� create���� �����Ϸ��� ������

-- unlimited tablespace ���� �ο��ϴ� �ɷ� �ٽ�

CREATE USER lhs
IDENTIFIED BY test;

GRANT CREATE SESSION, CREATE TABLE
TO lhs;

GRANT unlimited tablespace to lhs; -- ������ tablespace �ڵ� �Ҵ�ޱ� ������ ����� ���� ������ �� �� ���൵ �Ǵµ� ������ ����� �ȴ��

select * from system_privilege_map where lower(name) = 'unlimited tablespace';

REVOKE create table, create view
FROM skj;

CREATE ROLE manager;

GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW
TO manager;

GRANT manager 
TO skj;

DROP ROLE manager;

