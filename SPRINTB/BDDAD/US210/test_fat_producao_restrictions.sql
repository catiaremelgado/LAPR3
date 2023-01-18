--Testar se as restrições do fator de produção são cumpridas--
create or replace function fnc_testar_restricoes(string1 in varchar2, string2 in varchar2, string3 in varchar2)
   return int
is
     numPrcl number;
     numFatProd number;
     idata date;
     data_inicio date;
     data_fim date;

begin

   numPrcl := to_number(string1);
   numFatProd := to_number(string2);
   idata := to_timestamp(string3, 'dd/mm/yyyy hh24:mi');

   select data_hora_inicio_RFT into data_inicio from Restricoes_Fator_Producao where ID_Prcl_ck = numPrcl and ID_FtPrd_ck = numFatProd;
   select data_hora_fim_RFT into data_fim from Restricoes_Fator_Producao where ID_Prcl_ck = numPrcl and ID_FtPrd_ck = numFatProd;
        dbms_output.put_line(idata);
       if ((idata < data_inicio) or (idata > data_fim)) then
            return 1;
       else
            return 0;
       end if;

exception
    when others then
    return 0;
end;