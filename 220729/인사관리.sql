-- 220729
set serveroutput on;
drop table emp_test;

create table emp_test
as
  select employee_id, last_name
  from   employees
  where  employee_id < 200;
  
declare
  e_id exception;
begin
  delete from employees
  where employee_id = &eid;
  if sql%notfound then
    raise e_id;
  end if;
exception
  when e_id then
    --raise_application_error (-20999, '�ش� ����� �����ϴ�.');
    dbms_output.put_line('�ش� ����� �����ϴ�.');
end;
/

-- 2
declare
  v_eno employees.employee_id%type := &eid;
  v_hd employees.hire_date%type;
  e_hd exception;
begin
  select hire_date
  into v_hd
  from employees
  where employee_id = v_eno;
  
  if to_char(v_hd,'yyyy') < '2000'
  --if v_hd < '2000/01/01'
  then
    update employees
    set salary = salary*1.1
    where employee_id = v_eno;
  else
    raise e_hd;
  end if;
exception
    when e_hd then
      --raise_application_error (-20999, '2000�� ���Ŀ� �Ի��� ����Դϴ�.'); 
      dbms_output.put_line('2000�� ���Ŀ� �Ի��� ����Դϴ�.');
end;
/

select * from departments;
select * from employees;
rollback;

select salary
   from employees
   where department_id = 110;

-- 3
declare 
  e_invalid_dept exception; 
  cursor sal_cursor is
   select *
   from employees
   where department_id=&did
   for update of salary nowait;
  v_emp_record sal_cursor%rowtype; 
begin
  open sal_cursor;
  loop
    fetch sal_cursor into v_emp_record;
    if sal_cursor%rowcount =0 then
        raise e_invalid_dept;
    end if;
    exit when sal_cursor%notfound;
      update employees
      set salary = v_emp_record.salary*1.1
      where current of sal_cursor;
    --commit;
   end loop;  
exception
    when e_invalid_dept then
        dbms_output.put_line('�ش� �μ��� ���ų� �ش� �μ��� ����� �����ϴ�');
end;
/

commit;
select * from employees;
-- ���ν���
-- create or replace ~ is: header -- ���������� replace�� �� ���� �� ����
-- pl/sql��: body
-- in parameter
create or replace procedure raise_salary
  (p_id      in employees.employee_id%type,
   p_percent in number)
 is
 begin
   update employees
   set salary = salary * (1 + p_percent/100)
   where employee_id = p_id;
 end raise_salary;
 /

rollback;
select salary from employees where employee_id=174;

-- ���ν��� ���� ���1
execute raise_salary(174, 10);
-- ���ν��� ���� ���2
begin
  raise_salary(174, 10);
end;
/

-- out parameter 
-- ���ϰ��� �ִ� function�� �޸� ���ν����� ���ϰ��� ����.. ��� out�̶�� �Ű������� �ִ�..
create or replace procedure query_emp
 (p_id         employees.employee_id%type, -- �Ű� ���� ������ ��� ����Ʈ�� in
  p_name   out employees.last_name%type,
  p_salary out employees.salary%type)
is
begin
  select last_name, salary 
  into p_name, p_salary
  from employees
  where employee_id = p_id;
end query_emp;
/

declare
  v_emp_name employees.last_name%type;
  v_emp_sal employees.salary%type;
begin
  query_emp(174, v_emp_name, v_emp_sal);
  dbms_output.put_line(v_emp_name || ' earns ' || to_char(v_emp_sal, '$999,999.00'));
end;
/

-- in out parameter
create or replace procedure format_phone
  (p_phone_no in out varchar2) 
is
begin
  p_phone_no := '(' || substr(p_phone_no, 1, 3) || 
                ') ' || substr(p_phone_no, 4,3 ) || 
                '-' || substr(p_phone_no, 7);
end format_phone;
/

commit;
-- ���� ���ν������� ���ν��� ȣ��
-- creating add_dept procedure
create sequence department_seq;

create or replace procedure add_dept(
    p_name in departments.department_name%type,
    p_loc  in departments.location_id%type)
is 
begin
    insert into departments(department_id, department_name, location_id)
    values (department_seq.nextval, p_name, p_loc);
end add_dept;
/

execute add_dept('TRAINING', 2500); -- loc_id�� 1������ �������Ἲ ����
execute add_dept(p_loc=>2500, p_name=>'EDUCATION'); -- �Ķ���� ���� �� ���� �̷� �����ε�
select * from departments;

create or replace procedure add_dept(
    p_name in departments.department_name%type := 'Unknown',
    p_loc  in departments.location_id%type default 1700) 
is 
begin
    insert into departments(department_id, department_name, location_id)
    values (department_seq.nextval, p_name, p_loc);
end add_dept;
/

execute add_dept;
execute add_dept('ADVERTISING', p_loc=>1700);
execute add_dept(p_loc=>2500);

-- ���ν��� ����
drop procedure procedure_name;

-- ���ν���&����ó��
create or replace procedure add_department(
    p_name varchar2, p_mgr number, p_loc number)
is
begin
    insert into departments --(department_id, department_name, manager_id, location_id)
    values (department_seq.nextval, p_name, p_mgr, p_loc);
    dbms_output.put_line('Added Dept: ' || p_name);        
exception
    when others then
        dbms_output.put_line('Err: adding dept: ' || p_name);
end add_department;
/

create or replace procedure create_departments
is
begin
    add_department('Media', 100, 1700);
    add_department('Editing', 200, 1800);
    add_department('Advertising', 100, 1200); -- �������Ἲ ����
end;
/
-- ���� �ϸ� �� �ǰ� ������ �ϸ� ��..
execute add_department('Media', 100, 1700); -- ��
execute add_department('Editing', 200, 1800); -- ��
execute add_department('Advertising', 100, 1200); -- �ȵ�

select * from departments;

select text
from user_source
where name='ADD_DEPT' and type='PROCEDURE'
order by line; -- ���� ������� ���

-- ���ν��� ��������
-- 1
create or replace procedure yedam_ju(
    p_idnum number)
is
begin
  dbms_output.put_line(substr(p_idnum, 1, 6) || '-' || substr(p_idnum, 7,1) || '******');
end yedam_ju;
/

execute yedam_ju(9911002000000);

-- 2
create or replace procedure test_pro(
    p_eno employees.employee_id%type
)
is
   no_delete exception;
begin
    delete employees
    where employee_id=p_eno;

    if sql%notfound then
        raise no_delete;
    end if;
    
    dbms_output.put_line(p_eno || '�� ����� ���������� �����Ǿ����ϴ�.');       
exception
    when no_delete then
    dbms_output.put_line('�ش� ����� �����ϴ�.');
end test_pro;
/

execute test_pro(0); 

rollback;
select * from employees order by 1;

-- 3
create or replace procedure yedam_emp(
    p_eno employees.employee_id%type
)
is
    p_ename employees.last_name%type;
begin
    select last_name
    into p_ename
    from employees
    where employee_id = p_eno;    
    dbms_output.put_line(rpad(substr(p_ename, 1, 1), length(p_ename), '*'));
end yedam_emp;
/

execute yedam_emp(201);

-- 1
create or replace procedure get_emp(
    p_dno employees.department_id%type
)
is
 v_id   number;
 v_name varchar2(100);
 no_emp exception;
 cursor emp_cursor is
   select employee_id, last_name
   from employees
   where department_id=p_dno;
begin
  for emp_record in emp_cursor loop
   select employee_id, last_name
   into v_id, v_name
   from employees
   where department_id=p_dno;
   
   dbms_output.put_line(emp_record.employee_id || ',   ' || emp_record.last_name);
     
    /*
    if emp_cursor%notfound then
        raise no_emp;
    else
        dbms_output.put_line(emp_record.employee_id || ',   ' || emp_record.last_name);
    end if;    
    */
  end loop;  
exception
    when no_data_found then
        dbms_output.put_line('Err: ' || '�ش� �μ����� ����� �����ϴ�.');  
    /*    
    when no_emp then
        dbms_output.put_line('Err: ' || '�ش� �μ����� ����� �����ϴ�.');  
    */    
end get_emp;
/

execute get_emp(190); 
-- 190�� �μ��� ����� ���µ� ���������� �Ϸ�Ǿ��ٰ� ��..

-- 1 �����Բ�

CREATE OR REPLACE PROCEDURE get_emp
(p_id  IN employees.department_id%TYPE)
IS
  CURSOR emp_cursor
  IS
    SELECT *
    FROM   employees
    WHERE  department_id = p_id;
  v_emp_record  emp_cursor%ROWTYPE;
  e_excp exception;
BEGIN
  OPEN emp_cursor;
  LOOP
    FETCH emp_cursor INTO v_emp_record;
    IF emp_cursor%ROWCOUNT = 0 THEN
      RAISE e_excp;
    END IF;
    EXIT WHEN emp_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE (v_emp_record.employee_id || ' ' ||
                          v_emp_record.last_name);
  END LOOP;
  CLOSE emp_cursor;
EXCEPTION
  WHEN e_excp THEN
    DBMS_OUTPUT.PUT_LINE('no data dept');
END get_emp;
/

-- 2
create or replace procedure y_update(
    p_eno employees.employee_id%type,
    p_inc number
)
is
  no_update exception;
begin
  update employees
  set salary = salary * (1+p_inc/100)
  where employee_id = p_eno;
    if sql%notfound then
    raise no_update;
    end if;
exception
   when no_update then
        dbms_output.put_line('Err: ' || 'No such employee');  
end y_update;
/

select * from employees;
execute y_update(0, 20);

-- 3
create table yedam01
(y_id number(10),
 y_name varchar2(20));
create table yedam02
(y_id number(10),
 y_name varchar2(20));

create or replace procedure y_proc(
    p_dno employees.department_id%type
)
is
  cursor emp_cursor is
    select employee_id, last_name, hire_date
    from employees
    where department_id=p_dno;
  e_excp exception; 
  no_emp exception; 
  v_id    number;
  v_name  varchar2(100);
begin
    for emp_record in emp_cursor loop
        IF emp_cursor%ROWCOUNT = 0 THEN
        RAISE e_excp;
        else
        if to_char(emp_record.hire_date,'yyyy') < '2000'
        then
            insert into yedam01 (y_id,y_name)
            values (emp_record.employee_id, emp_record.last_name);
            if sql%notfound then
                raise no_emp;
            end if;
        else
            insert into yedam02 (y_id,y_name)
            values (emp_record.employee_id, emp_record.last_name);
            if sql%notfound then
                raise no_emp;
            end if;
        end if;
        END IF;
    end loop;
exception
    when e_excp then
       dbms_output.put_line('�ش� �μ��� �����ϴ�.');
    when no_emp then
       dbms_output.put_line('�ش� �μ��� ����� �����ϴ�.');
end y_proc;
/

execute y_proc(90);
execute y_proc(0); 
-- �μ� ���µ� ���������� �Ϸ�Ǿ��ٰ� ��..
execute y_proc(190); 
-- ��� ���µ� ���������� �Ϸ�Ǿ��ٰ� ��..

rollback;
select * from yedam01;
select * from yedam02;
delete yedam01;
delete yedam02;
select * from employees;

-- 3�� �Ϲ� ���������� �ٽ�
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
begin
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
            if sql%notfound then
                raise no_emp;
            end if;
        else
            insert into yedam02 (y_id,y_name)
            values (v_emp_record.employee_id, v_emp_record.last_name);
            if sql%notfound then
                raise no_emp;
            end if;
        end if;

    end loop;
    close emp_cursor;
exception
    when e_excp then
       dbms_output.put_line('�ش� �μ��� �����ϴ�.');
    when no_emp then
       dbms_output.put_line('�ش� �μ��� ����� �����ϴ�.');
end y_proc2;
/

execute y_proc2(90);
execute y_proc2(0); 
execute y_proc2(190); 
-- ��� ���µ� �μ� ���ٰ� ��..

rollback;
select * from yedam01;
select * from yedam02;
delete yedam01;
delete yedam02;
select * from employees;