set serveroutput on;

-- 2
declare
    v_eid employees.employee_id%type := &id;
    v_dname departments.department_name%type;
    v_job_id employees.job_id%type;
    v_salary employees.salary%type;
    v_comm employees.commission_pct%type;
    v_annual employees.salary%type;
begin
    select d.department_name, e.job_id, e.salary, e.commission_pct
    into v_dname, v_job_id, v_salary, v_comm
    from employees e, departments d
    where e.department_id = d.department_id
    and employee_id = v_eid;  
    v_annual := (v_salary + v_salary*nvl(v_comm,0))*12;
    dbms_output.put_line(v_dname || ' ' || v_job_id || ' ' || v_salary || ' ' || v_annual);
end;
/

-- 3
create or replace function hd_fnc
    (p_eid employees.employee_id%type)
    return varchar2
is
    v_hd employees.hire_date%type;
    v_result varchar2(100);
begin
    select hire_date
    into v_hd
    from employees
    where employee_id=p_eid;
    
    if to_char(v_hd, 'yyyy') > 1998 then
      v_result := 'New employee';
    else 
      v_result := 'Career employee';
    end if;  
    return v_result;
end;
/

select last_name, hire_date, hd_fnc(employee_id)
from employees;

-- 4
declare
    
begin
    for i in 1..9 loop
        if mod(i,2)=1 then
        dbms_output.put_line('');
            for j in 1..9 loop
                dbms_output.put_line(i || ' * ' || j || ' = ' || i*j);
            end loop;
        end if;
    end loop;
end;
/

-- 5
declare
    v_did number := &did;
    cursor dept_cursor is
        select employee_id, last_name, salary
        from employees
        where department_id=v_did;
begin
    for dept_row in dept_cursor loop
        dbms_output.put_line('사원id : ' || dept_row.employee_id || ', 이름: ' || dept_row.last_name || ', 급여: ' || dept_row.salary);
    end loop;
end;
/

-- 6
create or replace procedure emp_proc 
    (p_id number, p_inc number)
is
    no_emp exception;
begin
    update employees 
    set salary = salary * (1+(p_inc/100))
    where employee_id = p_id;
    
    if sql%rowcount = 0 then
        raise no_emp;
    end if;
exception
    when no_emp then
        dbms_output.put_line('No search employee!!');
end;
/

execute emp_proc(0, 10);

select * from employees where employee_id=100;
select * from employees;

-- 7
create or replace function idno_fnc 
    (p_idno in varchar2)
    return varchar2
is
    v_year number(4) := to_number(to_char(sysdate, 'yyyy'));
    v_birth number(4):= to_number(substr(p_idno, 1,2));
    v_substr number(1) := to_number(substr(p_idno, 7, 1));
    v_sex varchar2(10);
begin
    if v_substr in (1,2) then
       v_birth := 1900 + v_birth;
       if v_substr=1 then v_sex := '남자'; else v_sex := '여자'; end if;
    elsif v_substr in (3, 4) then
       v_birth := 2000 + v_birth;
       if v_substr=3 then v_sex := '남자'; else v_sex := '여자'; end if;
    end if;
    return '성별 : ' || v_sex || ', 나이 : ' || to_char(v_year-v_birth+1) || '세';
end;
/

execute dbms_output.put_line(idno_fnc('0707124696666'));

-- 8
create or replace function yearcnt_fnc
    (p_eid number)
    return number
is
    v_yearcnt number;
begin
    select trunc(MONTHS_BETWEEN(sysdate, hire_date)/12)
    into v_yearcnt
    from employees
    where employee_id=p_eid;
    return v_yearcnt;           
end;
/

select employee_id, last_name, hire_date, yearcnt_fnc(employee_id) "근속년수"
from employees;

-- 9
create or replace function manager_fnc
    (p_dname departments.department_name%type)
    return varchar2
is
    v_mname employees.last_name%type;
begin
    select last_name
    into v_mname
    from employees
    where employee_id = (select manager_id from departments where department_name = p_dname);
    return v_mname;
end;
/

select department_id, department_name, manager_id, manager_fnc(department_name)
from departments;

-- 10
select * from user_source order by type, name, line;

-- 11
declare 
  i number := 10;
begin
  loop
     i := i-1;     
  exit when i = 0;
    for j in 1..10 loop
        if i>=j then dbms_output.put('-'); else dbms_output.put('*'); end if;
    end loop;
    dbms_output.put_line('');    
  end loop;
end;
/
