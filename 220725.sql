-- 1
select * 
from employees
where commission_pct is not null; 

-- 2
select employee_id, last_name, salary, hire_date, department_id
from employees
order by salary;

-- 3
select employee_id, last_name, to_char(hire_date, 'yyyy-mm-dd') as hire_date, salary
from employees;

-- �߰�
-- ���߽� insert ���� © �� to_date �Լ� �� ����
select * from employees
where hire_date=to_date('1997�� 9�� 17��', 'yyyy"��" mm"��" dd"��"'); 

-- 4
select e.employee_id, e.last_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

-- �߰�
select e.employee_id, e.last_name, d.department_id, d.department_name
from   employees e, departments d
where  e.department_id = d.department_id
and    e.salary >= 4000;

-- �߰�
select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id=d.department_id
and d.location_id=l.location_id;

-- ANSI
select e.last_name, d.department_name, l.city
from employees e JOIN departments d
                    ON (e.department_id=d.department_id)
                 JOIN locations l
                    ON (d.location_id = l.location_id);

-- 5
select department_id "�μ�", round(avg(nvl(salary,0))) as "��ձ޿�"
from employees
group by department_id;

-- �߰�
select min(avg(nvl(salary,0))) as "�ּ���ձ޿�" -- �׷��Լ��� ��ø�� ���� �ٸ� �÷��� ������ �ȵ�
from employees
group by department_id;

-- 6
select employee_id, last_name, salary, job_id, department_id
from employees
where department_id = (select department_id from employees where employee_id=142); -- =��� in�� �ᵵ �ȴ�

-- 7
select employee_id, last_name, hire_date, add_months(hire_date,6) as "�Ի� 6���� ��"
from employees;

-- 8
create table sawon
(s_no number(4),
 name varchar2(15) not null,
 id varchar2(15) not null,
 hiredate date,
 pay number(4));
 
-- �߰�
alter table sawon
modify s_no number(4) primary key;
-- add primary key(s_no); �� ��(���̺� ����)
-- add sawon_s_no_pk primary key(s_no); �� �������� �̸��� ������ ���� ����

alter table sawon
modify pay number(4) not null; -- �������� �߰��� �� ������Ÿ���� ���� ����

desc sawon;

-- ���������� �� 5��
-- not null ���� ������ ������ �÷� �������� ������� �Ѵ�

-- 9
 insert into sawon 
 values (101, 'Jason', 'ja101', to_date('17/09/01', 'yy/mm/dd'), 800);
 
 insert into sawon 
 values (104, 'Min', 'm104', '14/07/02', 0);
 
 select * from sawon;
 
 commit;
 
 update sawon set pay=700 where s_no=104;
 
 commit;

-- 10 
 drop table sawon purge; -- purge�� �ִ��� �� ���� �� ����    
 
 
declare
v_fname varchar2(20);
begin 
select first_name into v_fname from employees
where employee_id=100;
DBMS_OUTPUT.PUT_LINE('The First Name of the Employee is ' || v_fname); -- sysout ���� ����
end;
/

set serveroutput on;

