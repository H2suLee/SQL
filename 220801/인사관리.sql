-- 220801
-- ����� ���� �Լ�(function)

set serveroutput on;

create or replace function get_sal
    (p_id employees.employee_id%type)
return number
is
    v_sal employees.salary%type := 0;
begin
    select salary
    into v_sal
    from employees
    where employee_id=p_id;
    return v_sal;
end get_sal;
/

execute dbms_output.put_line(get_sal(100));

declare
    sal employees.salary%type;
begin
    sal := get_sal(100);
    dbms_output.put_line('The salary is : ' || sal);
end;
/

select job_id, get_sal(employee_id)
from employees;

create or replace function tax
    (p_value in number)
return number
is
begin
    return (p_value * 0.08);
end tax;
/

select employee_id, last_name, salary, tax(salary)
from employees
where department_id = 90;

-- �ǽ�
-- 1
create or replace function ydsum
    (p_num number)
return number
is
    v_sum number := 0;
begin
    for i in 1..p_num loop
    v_sum := v_sum + i;
    end loop;
    return v_sum;
end;
/

EXECUTE DBMS_OUTPUT.PUT_LINE(ydsum(10));

-- 2
create or replace function ydinc
    (p_eid employees.employee_id%type)
return number
is
    v_sal employees.salary%type;
begin
    select salary
    into v_sal
    from employees
    where employee_id = p_eid;
    
    if v_sal <= 5000 then
        v_sal := v_sal * 1.2;
    elsif v_sal <= 10000 then
        v_sal := v_sal * 1.15;
    elsif v_sal <= 20000 then
        v_sal := v_sal * 1.1;
    elsif v_sal >= 20000 then
        v_sal := v_sal;
    end if;
    
    return v_sal;
end;
/

select last_name, salary, ydinc(employee_id)
from employees;

-- 3
create or replace function yd_func
    (p_eid employees.employee_id%type)
return number
is
    v_sal employees.salary%type;
    v_comm employees.commission_pct%type;
begin
    select salary, commission_pct
    into v_sal, v_comm
    from employees
    where employee_id = p_eid;
    return (v_sal + (v_sal*nvl(v_comm,0)))*12;
end;
/

select last_name, salary, yd_func(employee_id)
from employees;

-- 4
create or replace function subname 
    (p_name employees.last_name%type)
return varchar2
is
begin
    return rpad(substr(p_name, 1, 1), length(p_name), '*');
end;
/

select last_name, subname(last_name)
from employees;

-- 5
create or replace function inc_sal
   (p_eid   employees.employee_id%type,
    p_ratio number)
return number
is
    v_sal number;
begin
    select salary*(1+(p_ratio/100))
    into v_sal
    from employees
    where employee_id = p_eid;
    return v_sal;
end;
/

EXECUTE DBMS_OUTPUT.PUT_LINE(inc_sal(100, 10));

SELECT last_name, salary, inc_sal(employee_id, 10)
FROM   employees;

-- 1
create or replace function y_yedam
    (p_eid   employees.employee_id%type)
return varchar2
is
    v_fname varchar2(100);
    v_lname varchar2(100);
begin
    select last_name, first_name
    into v_lname, v_fname
    from employees
    where employee_id = p_eid;
    return v_lname || ' ' || v_fname;
end;
/

SELECT employee_id, y_yeda0(employee_id)
FROM   employees;

-- 2 
create or replace function y_dept
    (p_eid   employees.employee_id%type)
return varchar2
is
    v_dname varchar2(100);
    -- pragma exception_init (no_value, -06503);
begin
    select d.department_name
    into v_dname
    from employees e, departments d
    where e.department_id = d.department_id 
    and employee_id = p_eid;
    
    return v_dname;
      
exception
    when no_data_found then
        return '����� �ƴϰų� �Ҽ� �μ��� �����ϴ�.';
        -- exception when���� return �� �ָ� ���� ó���� ������ �̾ Function returned without value ���� ��
end;
/

EXECUTE DBMS_OUTPUT.PUT_LINE(y_dept(178));

SELECT employee_id, y_dept(employee_id)
FROM   employees;

select * from employees where employee_id=178; 

-- 2�� �����Բ�
2. 
create or replace function y_dept 
   (f_eid in number)
    return varchar2
is
    v_dname departments.department_name%type;
begin
    select d.department_name
    into v_dname
    from employees e, departments d
    where e.department_id=d.department_id
    and e.employee_id=f_eid;
    
    return v_dname;
exception
    when no_data_found then
        RAISE_APPLICATION_ERROR(-20750, '����� �ƴϰų� �Ҽ� �μ��� �����ϴ�');    
end y_dept;
/

-- 3
create or replace function y_test
    (p_did in number)
return varchar2    
is
    cursor dept_cursor is
    select e.last_name, d.department_name
    from employees e, departments d
    where e.department_id = d.department_id
    and d.department_id=p_did;
    
    v_dept_record dept_cursor%rowtype;  
    e_excp exception; 
    str varchar2(400);
begin
open dept_cursor;
    loop
        fetch dept_cursor into v_dept_record;
    
        IF dept_cursor%ROWCOUNT = 0 THEN
        RAISE e_excp;
        end if;
    
    exit when dept_cursor%notfound;
        str := str || v_dept_record.last_name || ' ' || v_dept_record.department_name || chr(13);
        -- return str; -- ���� ���� ����ٰ� �ָ� �̸� �� ���� ����
    end loop;
close dept_cursor;
return str;
exception
    when e_excp then
       return '�Ҽӵ� ����� �����ϴ�.';
end y_test;
/

-- 3 �������
create or replace function y_test
    (deptid in number)
return varchar2 
is   
    cursor emp_cursor is
        select e.last_name, d.department_name
        from employees e, departments d
        where e.department_id = d.department_id
        and e.department_id = deptid;
    
    v_name varchar2(4000);
    v_count number(10) := 0;
    e_nodept exception;
begin
    for emp_record in emp_cursor loop
        v_name := v_name || emp_record.last_name ||' ' || emp_record.department_name||chr(13); -- �ٹٲ�
        v_count := v_count + 1;
    end loop;
    
    if v_count = 0 then
        raise e_nodept;
    end if;
return v_name;
exception
    when e_nodept then
        return '�μ��� �������� �ʽ��ϴ�.';
end y_test;
/

execute dbms_output.put_line(y_test(50));

select y_test(department_id)
from departments order by department_id;

select * from departments order by 1;
delete departments where department_id between 2 and 9;

commit;

-- package
-- package ��(spec) ������ ����
create or replace package comm_pkg 
is
    v_std_comm number := 0.10;                -- ���� ���� ����
    procedure reset_comm(p_new_comm number);  -- ���� ���ν��� ����
end comm_pkg;
/

-- package body ������ ����
create or replace package body comm_pkg -- �ٵ� �̸��� ������ �� �̸��̶� ������ ��ġ ���Ѿ� ��
is 
    -- private function(validate)�� public procedure(reset_comm) ����
    -- private function�� �� ��Ű�� �ȿ����� ���� �� ����
    function validate
        (p_comm number) 
    return boolean
    is
    v_max_comm employees.commission_pct%type;
    begin
        select max(commission_pct)
        into v_max_comm
        from employees;
        return (p_comm between 0.0 and v_max_comm); -- p_comm�� between ������ ������ true, ������ false ����
    end validate;
    
    procedure reset_comm
       (p_new_comm number)
    is
    begin
        if validate(p_new_comm) then
            v_std_comm := p_new_comm; -- reset public var
        else raise_application_error(
            -20210, 'Bad Commission');
        end if;    
    end reset_comm;
end;
/

create or replace package global_consts 
is 
    c_mile_2_kilo   constant number := 1.6093;
    c_kilo_2_mile   constant number := 0.6214;
    c_yard_2_meter  constant number := 0.9144;
    c_meter_2_yard  constant number := 1.0936;
end global_consts;    
/

-- ��Ű�� Ȱ��
begin 
    dbms_output.put_line('20 miles = ' || 20*global_consts.c_mile_2_kilo || ' km');
end;
/

create or replace function mtr2yrd (p_m number)
return number
is
begin
    return (p_m * global_consts.c_meter_2_yard);
end mtr2yrd;
/

execute dbms_output.put_line(mtr2yrd(1));

-- data dictionary ����
-- pkg �� ����
select text
from user_source
where name = 'COMM_PKG' and type = 'PACKAGE'
order by line;

-- pkg �ٵ� ����
select text
from user_source
where name ='COMM_PKG' and type = 'PACKAGE BODY'
order by line;

-- ��Ű�� �� �� ��ü ����
drop package package_name; -- ���� �ٵ� �Ѵ� ����
-- ��Ű�� ��ü ����
drop package body package_name; -- �ٵ� ����

-- ���� �� �ݿ��� 3�� �ٽ�
create or replace procedure y_proc2(
    p_dno employees.department_id%type
)
is
  cursor emp_cursor is
    select *
    from employees
    where department_id=p_dno;
  v_emp_record emp_cursor%rowtype;  
  e_excp exception; 
  no_emp exception; 
  dname varchar2(100);
begin
    select department_id
    into dname
    from departments
    where department_id = p_dno;

    open emp_cursor;
    loop
        fetch emp_cursor into v_emp_record;
    
        IF emp_cursor%ROWCOUNT = 0 THEN
        RAISE e_excp;
        end if;

    exit when emp_cursor%notfound;
        
        if to_char(v_emp_record.hire_date,'yyyy') < '2000'
        then
            insert into yedam01 (y_id,y_name)
            values (v_emp_record.employee_id, v_emp_record.last_name);
        else
            insert into yedam02 (y_id,y_name)
            values (v_emp_record.employee_id, v_emp_record.last_name);
        end if;

    end loop;
    close emp_cursor;
exception
    when e_excp then
       dbms_output.put_line('�ش� �μ��� ����� �����ϴ�.');
    when no_data_found then
       dbms_output.put_line('�ش� �μ��� �����ϴ�.');
end y_proc2;
/

execute y_proc2(90);
execute y_proc2(0); 
execute y_proc2(190);

rollback;
select * from yedam01;
select * from yedam02;
delete yedam01;
delete yedam02;