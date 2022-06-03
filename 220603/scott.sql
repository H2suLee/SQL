-- 220603
-- SYNONYM

CREATE SYNONYM e_sum
FOR empvu20;

SELECT *
FROM e_sum;

SELECT *
FROM empvu20;

-- ���Ǿ� ���� Ȯ��
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
   
DROP TABLE yd_test; -- ���� ���̺��� ����  
-- yd_ix �ε����� �����ǰ� ytest ���Ǿ�� testvu ��� ��� ����
-- �ٵ� �����ϸ� no longer valid ������
SELECT * FROM ytest; 
SELECT * FROM testvu;


-- ��ü Ȯ��
SELECT object_name, object_type
FROM user_objects;

-- DCL
SELECT *
FROM system_privilege_map;

-- ��ü ����
SELECT * 
FROM hr.employees; -- ����

SELECT * 
FROM hr.employees; -- hr�� ��ȸ ���� �ο��� �ְ� ������ ���� ����

REVOKE select -- grant�� ���� ��� ȸ���� �Ұ���
ON dept
FROM skj;

-- ������ ���
SELECT object_name, original_name, type
FROM user_recyclebin;

CREATE TABLE yd_2
AS SELECT *
   FROM emp;
   
CREATE TABLE yd_3
AS SELECT *
   FROM emp;

PURGE recyclebin; -- ���������

DROP TABLE yd_3;
DROP TABLE yd_2 PURGE; -- �����ϴ� ��� ������ ����

FLASHBACK TABLE yd_3 TO BEFORE DROP;

DROP TABLE yd_3;

SHOW recyclebin; -- �������� �� ��� ���¿��� show�ϸ� '��ü�� �������մϴ�' ���� �޽��� ��

FLASHBACK TABLE yd_3 TO BEFORE DROP;

-- ġȯ ����
SELECT * 
FROM emp
WHERE sal = &sal; -- ġȯ ���� �̰� ���� �׷���

-- ġȯ ������ �̿��Ͽ� �����ȣ�� �Է��� ��� ��� �̸��� �μ���ȣ�� ����Ͻÿ�
SELECT ename, deptno
FROM emp
WHERE empno = &no; -- ġȯ ������ ���� ���ǿ����� ����ȴ�

-- &&