--Testar se o input pode ser transformado em data--
create or replace function fnc_testar_se_pode_ser_data(string in varchar2)
   return int
is
    idata date;

begin
   idata := to_date(string, 'dd/mm/yyyy');
return 1;

exception
    when others then
    return 0;
end;