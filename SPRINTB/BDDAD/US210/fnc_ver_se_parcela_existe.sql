create or replace function fnc_ver_se_parcela_existe(
    string1 in varchar2)
    return int
is
     ID_Prcl number;
     x number;

begin
   ID_Prcl := to_number(string1);

   SELECT count(*) into x
   FROM Parcela
   WHERE ID_Prcl_pk = ID_Prcl;

   if (x=1)then return 1; else return 0; end if;


exception
    WHEN NO_DATA_FOUND THEN
    return 0;
end;