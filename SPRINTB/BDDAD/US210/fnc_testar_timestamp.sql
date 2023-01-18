--Testar se o input pode ser transformado em timestamp--
create or replace function fnc_testar_se_pode_ser_timestamp(string in varchar2)
   return int
is
    tdata timestamp;

begin
   tdata := TO_TIMESTAMP(string, 'dd-mm-yyyy hh24:mi');
return 1;

exception
    when others then
    return 0;
end;