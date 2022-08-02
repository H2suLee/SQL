select * from player;
set serveroutput on;
-- 5
create or replace procedure nickname 
is
    cursor c_n_name is
        select nickname
        from player
        where height >= 180
        and nickname is not null; 
    str varchar2(4000) := '';
    cnt number := 0;
begin
    for c_rec in c_n_name loop
        str := str || c_rec.nickname || ' ';
        cnt := cnt+1;
    end loop;
    dbms_output.put_line(str);
    dbms_output.put_line('총 ' || cnt || '건 조회 완료');
end;
/

execute nickname;

select nickname
from player
where height >= 180
and nickname is not null; 

-- 6
create or replace procedure select_player 
    (p_team in varchar2)
is
    cursor c_player is
        select p.player_name
        from player p, team t
        where p.team_id = t.team_id 
        and t.team_name = p_team; 
        
        /* 서브쿼리로
        select player_name
        from player
        where team_id = (select team_id
                         from team
                         where team_name = p_team)
        */
    cnt number := 0;    
begin
    for player_rec in c_player loop
        dbms_output.put_line(player_rec.player_name);
        cnt := cnt+1;
    end loop;
    dbms_output.put_line('총 ' || cnt || '건 조회 완료');
    /* 일반 루프로
    open c_player;
    loop
        fetch c_player into player_name;
        exit when c_player%notfound;
            dbms_output.put_line(player_name);
        end loop;
    close c_player;
    */
end;
/

execute select_player('현대모터스');

select * from team;
select * from player;