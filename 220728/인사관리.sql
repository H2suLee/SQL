-- 220728

set serveroutput on;

declare
  type emp_table_type is table of
    employees%rowtype index by pls_integer;
  my_emp_table emp_table_type;
  max_count number(3) := 104;
begin
  for i in 100..max_count
  loop
    select *
    into my_emp_table(i)
    from employees
    where employee_id = i;
  end loop;
  for i in my_emp_table.first..my_emp_table.last
  loop
    dbms_output.put_line(my_emp_table(i).last_name);
  end loop;
end;
/

-- ����� Ŀ�� Explicit Cursors
-- �� �� �̻��� ���� ��ȯ�ϴ� ���ǿ� ���� ����, �ݺ��� �ݵ�� ���
-- (�Ͻ��� Ŀ���� �ϳ��� �ุ ��ȯ�ϴ� ���Ǹ� ����)
declare
  v_ename employees.last_name%TYPE;
  v_dname departments.department_name%TYPE;
begin
  select e.last_name, d.department_name
  into v_ename, v_dname
  from employees e, departments d
  where e.department_id = d.department_id
  -- and e.department_id=&did; 
  -- returns more than requested number of rows
  -- ������ ���� �ϳ��� ��ƾ� �ϴµ� �������� ��ܼ� ������
  and e.employee_id=&eid;
  
  dbms_output.put_line(v_ename || ' ' || v_dname);
end;
/

declare
  cursor c_emp_cursor is
    select employee_id, last_name 
    from employees
    where department_id=50;
  v_empno employees.employee_id%TYPE;
  v_lname employees.last_name%TYPE;
begin
  open c_emp_cursor;
  loop
    fetch c_emp_cursor into v_empno, v_lname;
  exit when c_emp_cursor%notfound;
    dbms_output.put_line(v_empno || ',  ' || v_lname);
  end loop;
  close c_emp_cursor; -- Ŭ���� ���� ����, �׷����� �ݴ� �� ����  
end;
/

declare
  cursor c_emp_cursor is
    select e.last_name, d.department_name
    from employees e, departments d
    where e.department_id = d.department_id
    and e.department_id=&did; 
  v_ename employees.last_name%TYPE;
  v_dname departments.department_name%TYPE;
begin
  open c_emp_cursor;
  loop
    fetch c_emp_cursor into v_ename, v_dname;
  exit when c_emp_cursor%notfound;
    dbms_output.put_line(v_ename || ', ' || v_dname);
  end loop;
  close c_emp_cursor;
end;
/

create table temp_list (empid, empname)
 as select employee_id, last_name
    from employees
    where employee_id = 0;

declare
  cursor emp_cursor is
  select employee_id, last_name 
  from employees
  where department_id = 20;
  emp_record emp_cursor%rowtype;
begin
  open emp_cursor;
  loop 
    fetch emp_cursor 
    into emp_record;
  exit when emp_cursor%notfound;
    insert into temp_list --(empid, empname)
    values emp_record;
    --values(emp_record.employee_id, emp_record.last_name);
  end loop;
  commit;
  close emp_cursor;
end;  
/    
select * from temp_list;    
delete temp_list;

-- Ŀ�� for ����
-- ����, ����, �ݱⰡ �Ͻ������� �߻�
declare
  cursor c_emp_cursor is
    select employee_id, last_name 
    from employees
    where department_id = 50;
begin
  for emp_record in c_emp_cursor
  loop
    dbms_output.put_line(emp_record.employee_id || ',  ' ||
                         emp_record.last_name);
  end loop;
end;
/
    
-- where current of
select * from employees where department_id=50; -- 3500, rajs
declare 
  cursor sal_cursor is
   select salary
   from employees
   where department_id = 50
   for update of salary nowait; -- ����� ���, ���� �Ǵ� ���� ���� ���� ���, nowait�� �ٸ� ����ڰ� ���Ѵ����¿� ������ �ʵ��� �ϴ� �ɼ�
begin
  for emp_record in sal_cursor loop
    update employees
    set salary = emp_record.salary*1.10
    where current of sal_cursor; -- ���� Ŀ���� �ִ� �� ������Ʈ ��
  end loop;  
end;
/
    
commit;    

select * from test01;
select * from test02;

-- 1 for loop
declare 
  cursor emp_cursor is
   select employee_id, last_name, hire_date
   from employees;
begin
  for emp_record in emp_cursor loop
    if emp_record.hire_date < '2000/01/01' then
       insert into test01 --(empid, ename, hiredate)
       --values (emp_record.employee_id, emp_record.last_name, emp_record.hire_date);
       values emp_record;
    elsif emp_record.hire_date > '2000/01/01' then
       insert into test02 --(empid, ename, hiredate)
       --values (emp_record.employee_id, emp_record.last_name, emp_record.hire_date);
       values emp_record;
    end if;   
  end loop;  
end;
/

-- 1 �⺻ loop�� declare, open, fetch, close
declare
  cursor emp_cursor is
  select employee_id, last_name, hire_date 
  from employees;
  emp_record emp_cursor%rowtype;
begin
  open emp_cursor;
  loop 
    fetch emp_cursor 
    into emp_record;
  exit when emp_cursor%notfound;
    if emp_record.hire_date < '2000/01/01' then
        insert into test01
        values emp_record;
    elsif emp_record.hire_date > '2000/01/01' then
        insert into test02
        values emp_record;
    end if;
  end loop;
  commit;
  close emp_cursor;
end;  
/       
    
rollback;

select * from test01;
select * from test02;

delete test01;
delete test02;

-- 3 
declare 
  cursor emp_cursor is
    select job_id, avg(nvl(salary,0)) as avg_sal
    from employees
    where department_id = &did
    group by job_id; 
begin
  for emp_record in emp_cursor loop
    dbms_output.put_line(emp_record.job_id || ',  ' ||
                         emp_record.avg_sal);
  end loop;  
end;
/

-- 4
declare 
  cursor emp_cursor is
    select employee_id, last_name, department_id
    from employees
    where department_id = &did;
begin
  for emp_record in emp_cursor loop
    dbms_output.put_line(emp_record.employee_id || ',  ' ||
                         emp_record.last_name || ',  ' || 
                         emp_record.department_id);
  end loop;  
end;
/

-- 5
declare 
  cursor emp_cursor is
    select last_name, salary, salary*12+(salary*nvl(commission_pct,0)*12) as annual
    from employees
    where department_id = &did;
begin
  for emp_record in emp_cursor loop
    dbms_output.put_line(emp_record.last_name || ',  ' ||
                         emp_record.salary || ',  ' || 
                         emp_record.annual);
  end loop;  
end;
/

-- 7
declare 
  cursor emp_cursor is
   select employee_id, last_name, hire_date, salary
   from employees;
begin
  for emp_record in emp_cursor loop
    if emp_record.salary > 5000 then
       insert into test01 (empid, ename, hiredate)
       values (emp_record.employee_id, emp_record.last_name, emp_record.hire_date);

    elsif emp_record.salary < 5000 then
       insert into test02 (empid, ename, hiredate)
       values (emp_record.employee_id, emp_record.last_name, emp_record.hire_date);
    end if;   
  end loop;  
end;
/

select * from test01;
select * from test02;

delete test01;
delete test02;    

-- 7�� �Ϲ� loop��    
declare
  cursor emp_cursor is
    select employee_id, last_name, hire_date, salary
    from employees;
  emp_row_rec emp_cursor%rowtype; 
begin
  open emp_cursor;
  loop
    fetch emp_cursor
    into emp_row_rec;
  exit when emp_cursor%notfound;
    if emp_row_rec.salary > 5000 then
       insert into test01 (empid, ename, hiredate)
       values (emp_row_rec.employee_id, emp_row_rec.last_name, emp_row_rec.hire_date);
    elsif emp_row_rec.salary < 5000 then
       insert into test02 (empid, ename, hiredate)
       values (emp_row_rec.employee_id, emp_row_rec.last_name, emp_row_rec.hire_date);
    end if;  
  end loop;
  close emp_cursor;
end;
/

-- ���� ó�� - ���� ��
declare
  v_name employees.last_name%type;
begin
  select last_name
  into v_name
  from employees
  where employee_id = &id;
  dbms_output.put_line('Last Name: ' || v_name);
exception
  when no_data_found then
    dbms_output.put_line('�ش� ����� �����ϴ�.');
end;
/

declare
  v_name employees.last_name%type;
begin
  select last_name
  into v_name
  from employees
  where department_id = &id;
  dbms_output.put_line('Last Name: ' || v_name);
exception
  when too_many_rows then
    dbms_output.put_line('��ȯ�Ǵ� ���� �ʹ� ������');
end;
/

-- cannot insert NULL
declare
  e_insert_excep exception;
  pragma exception_init (e_insert_excep, -01400);
begin
  insert into departments (department_id, department_name)
  values (280, NULL);
exception
  when e_insert_excep then
    dbms_output.put_line('!!! INSERT OPERATION FAILED !!!');
    dbms_output.put_line('ERRCODE : ' || SQLCODE || ',  ERRMSG ' || SQLERRM);
end;
/

-- ����ڰ� ������ ���� Ʈ��
declare
  v_deptno number := 500;
  v_name varchar2(20) := 'Testing';
  e_invalid_department exception;
begin
  update departments
  set department_name = v_name
  where department_id = v_deptno;
  if sql%notfound then
   raise e_invalid_department;
  end if;
  commit;
exception
when e_invalid_department then
    dbms_output.put_line('no such department id.');
end;
/

declare
  e_name exception;
begin
  delete from employees
  where last_name = '&id';
  if sql%notfound then
    raise e_name;
  end if;
exception
  when e_name then
    --raise_application_error (-20999, '�ش� ����� �����ϴ�.');
    dbms_output.put_line('�ش� ����� �����ϴ�.');
end;
/

/*
ù��° ������ ���� ���ް� ���� ����� �޽��� ��±���, ������x
>>
���� ���� -
ORA-20999: �ش� ����� �����ϴ�.
ORA-06512: at line 11
*/

/*
�ι�° ������ �޽��� �ܼ� ���, �������� ���������� �Ϸ��, ����
>>
�ش� ����� �����ϴ�.


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- ù��° ������ �ַ� �Ʒ� �������� ��
begin
  delete from employees
  where last_name = '&id';
  if sql%notfound then
    raise_application_error (-20999, '�ش� ����� �����ϴ�.');
  end if;
end;
/  