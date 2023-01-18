create or replace function fnc_ver_se_operacao_existe(
    string1 in varchar2,
    string2 in varchar2,
    string3 in varchar2,
    string4 in varchar2)
    return int
is
     ID_Prcl number;
     ID_Cult number;
     data_Plant date;
     data_hora_previsto_Op date;
     data_inicio date;
     data_fim date;
     x number;

begin
   ID_Prcl := to_number(string1);
   ID_Cult := to_number(string2);
   data_Plant := to_date(string3, 'dd/mm/yyyy');
   data_hora_previsto_Op := to_timestamp(string4, 'dd/mm/yyyy hh24:mi');

   SELECT count(*) into x
   FROM Operacao
   WHERE ID_Prcl_ck = ID_Prcl AND ID_Cult_ck = ID_Cult
   AND data_Plant_ck = data_Plant AND data_hora_previsto_Op_ck = data_hora_previsto_Op;

   if (x=1)then return 1; else return 0; end if;


exception
    WHEN NO_DATA_FOUND THEN
    return 0;
end;