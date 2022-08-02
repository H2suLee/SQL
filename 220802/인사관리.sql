-- 220802
set serveroutput on;
CREATE TABLE MEMBER
( 
    id number primary Key,
    pw varchar2(20),
    name varchar2(20)
);

declare
begin
    for i in 1..1000 loop
        if mod(i, 2) = 0 then
            if mod(i, 5) = 0 then
                insert into member
                values (i, '5555', '��');
            else 
                insert into member
                values (i,'2222', '��');
            end if;
        elsif mod(i, 2) = 1 then
            if mod(i, 7) = 0 then
                insert into member
                values (i,'7777', '��');
            else 
                insert into member
                values (i,'1111', '��');
            end if;
        else
            insert into member
            values (i,'0000', '��');
        end if;
    end loop;
end;
/

select * from member;
delete member;

-- 2
declare
    v_num number := 0; -- number �ڸ� ���� 3���� �����ϴ� ����� �ִ�
    e_exception exception;
begin
    while(v_num<1000)
    loop
        v_num := v_num+100;        
        if v_num/1000 = 1 then
            raise e_exception;
        end if;    
        dbms_output.put_line(v_num);            
    end loop;
exception
    when e_exception then
        dbms_output.put_line('that is as high as you can go.');
end;
/

-- 3
-- ��ٱ��� ��ɿ� Ȱ���ϱ� ����
create or replace procedure member_procedure 
    (p_id   in member.id%type, 
     p_pw   in member.pw%type, 
     p_name in member.name%type)
is
    v_id number;
begin
    select id
    into v_id
    from member
    where id=p_id;
    
    /* ������ ���
    -- select count(*) into v_check from member where id=p_id;
    -- if v_check=0 then insert..; else update..
    */
    
    -- sql%notfound�� if �Ŵ� �� ���⼱ �� �Ǵ� �� ��.....
    
    update member
    set name=p_name, pw=p_pw
    where id = p_id;

exception
    when no_data_found then
        insert into member
        values (p_id, p_pw, p_name);  
end;
/

select * from member order by 1 desc;

execute member_procedure(1, '1234', '��');
execute member_procedure(1000, '123456789', '���ڱ�������');
execute iud('insert', 1004, '1234', '��');
execute iud('delete', 1004, '1234', '��');

commit;
-- 4
create or replace procedure iud 
    (p_command in varchar2,
     p_id      in member.id%type, 
     p_pw      in member.pw%type, 
     p_name    in member.name%type)
is
begin
    if p_command = 'insert' then
        insert into member
        values (p_id, p_pw, p_name);
    elsif p_command = 'update' then
        update member
        set pw=p_pw, name=p_name
        where id=p_id;
    elsif p_command = 'delete' then
        delete member
        where id=p_id;
    end if;
end;
/

CREATE OR REPLACE PROCEDURE out_proc
(
    p_name OUT VARCHAR2,
    p_age OUT number
)
IS
BEGIN
    p_name := '�ӽ�';
    p_age := 27;
    
    DBMS_OUTPUT.PUT_LINE('OUT �Ű� ���� �Ϸ�');
END;
/

-- 7
create or replace procedure select_pw_name
    (p_id member.id%type)
is
    v_pw member.pw%type;
    v_name member.name%type;
begin
    select pw, name
    into v_pw, v_name
    from member
    where id=p_id;
    
    DBMS_OUTPUT.PUT_LINE(rpad(substr(v_name, 1, 1), length(v_name)+1, '*')
                        || ', '                        
                        || rpad(substr(v_pw, 1,1), length(v_pw)-1, '*')
                        || substr(v_pw, length(v_pw),1));
end;
/

execute select_pw_name(1000);