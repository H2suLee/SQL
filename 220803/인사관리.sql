-- 220803

-- ��Ű�� �����ε�
-- �� add_department ���ν���, �̸��� ������ �Ű� ������ ������ ������ �ٸ���
create or replace package dept_pkg 
is
    procedure add_department
        (p_deptno in departments.department_id%type,
         p_name   in departments.department_name%type := 'unknown',
         p_loc    in departments.location_id%type := 1700);
    procedure add_department
        (p_name departments.department_name%type := 'unknown',
         p_loc  departments.location_id%type := 1700);
end dept_pkg;
/

create or replace package body dept_pkg 
is
        procedure add_department
            (p_deptno in departments.department_id%type,
             p_name   in departments.department_name%type := 'unknown',
             p_loc    in departments.location_id%type := 1700)
         is
         begin
            insert into departments (department_id, department_name, location_id)
            values (p_deptno, p_name, p_loc);
         end add_department;   
        procedure add_department
           (p_name departments.department_name%type := 'unknown',
            p_loc  departments.location_id%type := 1700)
         is
         begin
            insert into departments (department_id, department_name, location_id)
            values (departments_seq.nextval, p_name, p_loc);
         end add_department;
end dept_pkg;
/

execute dept_pkg.add_department(980, 'Education', 2500);
select * from departments where department_id=980;

execute dept_pkg.add_department('Training', 2500);
select * from departments;

-- ����� ���� ��Ű��
create or replace package taxes_pack
is
    function tax
        (p_value in number)
    return number;
end taxes_pack;
/

create or replace package body taxes_pack
is 
    function tax
        (p_value in number)
        return number
    is
        v_rate number:=0.08;
    begin
        return (p_value*v_rate);
    end tax;
end taxes_pack;
/

select taxes_pack.tax(salary) tax, salary, last_name
from employees;

set serveroutput on;

create or replace package emp_pkg 
is
    type emp_table_type is table of employees%rowtype
        index by binary_integer;
    procedure get_employees(p_emps out emp_table_type);
end emp_pkg;
/

create or replace package body emp_pkg 
is
    procedure get_employees(p_emps out emp_table_type)
    is
        v_i binary_integer := 0;
    begin
        for emp_record in (select * from employees)
        loop
            p_emps(v_i) := emp_record;
            v_i := v_i+1;
        end loop;
    end get_employees;
end emp_pkg;    
/

declare 
    v_employees emp_pkg.emp_table_type;
begin
    emp_pkg.get_employees(v_employees);
    dbms_output.put_line('Emp 5 : ' || v_employees(4).last_name);
end;
/

-- �ǽ�
-- 1
create or replace package yd_pkg
is
    function y_age
        (p_idno in number)
        return number;
    function y_sex
        (p_idno in number)
        return varchar2;
end yd_pkg;
/

create or replace package body yd_pkg 
is
        function y_age
            (p_idno in number)
            return number
        is
            v_year number(4) := to_number(to_char(sysdate, 'yyyy'));
            v_birth number(4):= to_number(substr(p_idno, 1,2));
        begin
            if substr(p_idno, 7,1) = 1 or substr(p_idno, 7,1) = 2 then
                v_birth := 1900 + v_birth;
            elsif substr(p_idno, 7,1) = 3 or substr(p_idno, 7,1) = 4 then
                v_birth := 2000 + v_birth;
            end if;    
            return v_year - v_birth;
        end y_age;   
        function y_sex
            (p_idno in number)
            return varchar2
        is
            v_sex varchar2(5);             
        begin
            --if substr(p_idno, 7,1) = 1 or substr(p_idno, 7,1) = 3 then
            if substr(p_idno, 7,1) in (1,3) then         
                v_sex := '��'; -- '����'�� �ϸ� varchar 5 �ʰ�
            else
                v_sex := '��';
            end if;    
            return v_sex;
        end y_sex;
end yd_pkg;
/
execute dbms_output.put_line(2022-2000-to_number(substr('0007124692222',1,2)));
execute dbms_output.put_line('���� : ' || yd_pkg.y_age('2007124692222'));
execute dbms_output.put_line('���� : ' || yd_pkg.y_sex('9407124692222')); 
-- ���ڷ� �ִ� ������.. 0���� �����ϴ� �ֹι�ȣ �ְԵǸ� �տ� 0�� �߸�..
-- ������ ������ ���ڸ� �ִ��� 00�� ���߸����� ��ġ�� ������� ��..like to_char(0000000000000, 'FM9999999999999')

-- trigger
create or replace trigger secure_dept
before insert on departments
    begin
        if (to_char(sysdate, 'DY') in ('��', '��')) or
           (to_char(sysdate, 'HH24:MI') not between '08:00' and '18:00') then
             raise_application_error(-20500, 'You may insert into the table only during normal business hours.');
        end if;
    end;
    /
    
insert into departments(department_id, department_name)
values      (444, 'YD');
-- ���� �������δ� Ʈ���Ÿ� ������� �ʴ� ���� ����

-- Ʈ���� �̺�Ʈ ����,
-- Ʈ���� ���� �ȿ��� Ư���� ���ǹ� ���� inserting, updating, deleting�� �̿��Ͽ� ���� Ʈ���� �̺�Ʈ�� �ϳ��� ����
create or replace trigger secure_dept 
before insert or update or delete on departments
    begin
        if (to_char(sysdate, 'DY') in ('��', '��')) or
           (to_char(sysdate, 'HH24:MI') not between '08:00' and '18:00') then
           if deleting then 
            raise_application_error(-20500, 'You may delete the table only during normal business hours.');
           elsif inserting then 
            raise_application_error(-20500, 'You may insert into the table only during normal business hours.');
           elsif updating('department_name') then 
            raise_application_error(-20500, 'You may update department name only during normal business hours.');
           else
            raise_application_error(-20500, 'You may work on the table only during normal business hours.');
           end if;
        end if;
    end;
    /
update departments
set department_name = 'Yedam'
where department_id = 444;

update departments
set location_id = '1700'
where department_id = 444;

delete departments
where department_id = 444;

drop trigger secure_dept;
drop trigger secure_emp;
drop trigger restrict_salary;
-- �� Ʈ����
select * from employees where job_id = 'AD_VP'; --102, 17000
create or replace trigger restrict_salary
before insert or update of salary on employees
for each row
    begin 
        if :NEW.job_id in ('AD_PRES', 'AD_VP')
           and :NEW.salary > 15000 then
           raise_application_error(-20202, 'Employee cannot earn more than $15,000.');
        end if;
end;
/    

-- for each row�� �ּ� ó���ϸ� �Ʒ��� ���� ���� �޽����� ���
-- NEW or OLD references not allowed in table level triggers
-- 

update employees
set salary = 15500
where employee_id=102;

create table audit_emp(
    user_name varchar2(30),
    time_stamp date,
    id number(6),
    old_last_name varchar2(25),
    new_last_name varchar2(25),
    old_title varchar2(10),
    new_title varchar2(10),
    old_salary number(8,2),
    new_salary number(8,2)
)
/

create or replace trigger audit_emp_values
after delete or insert or update on employees
for each row
begin
    insert into audit_emp
    values (USER, sysdate, :OLD.employee_id, :OLD.last_name, :NEW.last_name, :OLD.job_id, :NEW.job_id, :OLD.salary, :NEW.salary);
end;
/
-- ���⼭ user�� hr, ��Ű����� ��
-- ��������� Ʈ����

insert into  employees(employee_id, last_name, job_id, salary, email, hire_date)
values                (999, 'Temp emp', 'SA_REP', 6000, 'TENPEMP', TRUNC(SYSDATE));

update employees
set salary=7000, last_name='Smith'
where employee_id=999;

select * from audit_emp;
desc employees;

-- Ʈ���� Ȱ��ȭ ��Ȱ��ȭ
-- alter trigger trigger_name disable|enable;
-- alter table table_name disable | enable all triggers;
-- Ʈ���� ������
-- alter trigger trigger_name compile
-- Ʈ���� �ڵ� ǥ��
select trigger_name, trigger_type, triggering_event, table_name, referencing_names, when_clause, status, trigger_body
from user_triggers;
-- Ʈ���� ����
drop trigger audit_emp_values;