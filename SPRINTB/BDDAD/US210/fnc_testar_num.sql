--Testar se o input pode ser transformado em numero--
create or replace function fnc_testar_se_pode_ser_numero (nTest in varchar2)
    return int
is
    numero number;

begin
    numero := to_number(nTest);
return 1;

exception
    when value_error then
    return 0;
end;