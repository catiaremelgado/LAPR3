--Alterar data efetiva--
create or replace procedure prc_alterar_registo_colt_dataEfet(
id_prcl                     in number,
id_cult                     in number,
data_plant                  in date,
data_prevista               in date,
data_efetiva                in date)

is

  check_constrained_failed exception;
  pragma exception_init (check_constrained_failed, -2290);
  null_constrained_failed exception;
  pragma exception_init (null_constrained_failed, -1400);

begin

    update Registo_Colheita
        set  data_hora_efetivo_RgtColh = data_efetiva
    where ID_Prcl_ck = id_prcl and ID_Cult_ck = id_cult and data_Plant_ck = data_plant and data_hora_previsto_RgtColh_ck = data_prevista;

    if sql%rowcount = 1 then
            dbms_output.put_line('A data efetiva foi alterada com sucesso.');
    else
            dbms_output.put_line('A data efetiva não foi alterada pois os dados inseridos não estão associados a nenhum registo de fertilização.');
    end if;

    exception

    when check_constrained_failed then
    dbms_output.put_line('Um ou mais dos dados introduzidos, não respeita/respeitam as restrições de integridade.');
    when null_constrained_failed then
    dbms_output.put_line('Os valores intruzidos são nulos, por favor tente novamente com valores válidos.');
    when others then
    dbms_output.put_line('Ocorreu um problema, por favor tente novamente.');

end;

--Alterar quantidade--
create or replace procedure prc_alterar_registo_colt_quant(
id_prcl                     in number,
id_cult                     in number,
data_plant                  in date,
data_prevista               in date,
quant                       in number)

is

  check_constrained_failed exception;
  pragma exception_init (check_constrained_failed, -2290);
  null_constrained_failed exception;
  pragma exception_init (null_constrained_failed, -1400);

begin

    update Registo_Colheita
        set quantidade_RgtColh = quant
    where ID_Prcl_ck = id_prcl and ID_Cult_ck = id_cult and data_Plant_ck = data_plant and data_hora_previsto_RgtColh_ck = data_prevista;

    if sql%rowcount = 1 then
        dbms_output.put_line('A quantidade foi alterada com sucesso.');
    else
        dbms_output.put_line('A quantidade não foi alterada pois os dados inseridos não estão associados a nenhum registo de fertilização.');
    end if;

exception
    when check_constrained_failed then
    dbms_output.put_line('Um ou mais dos dados introduzidos, não respeita/respeitam as restrições de integridade.');
    when null_constrained_failed then
    dbms_output.put_line('Os valores intruzidos são nulos, por favor tente novamente com valores válidos.');
    when others then
    dbms_output.put_line('Ocorreu um problema, por favor tente novamente.');

end;