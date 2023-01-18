--Alterar fator produção--
create or replace procedure prc_alterar_registo_fertilizacao_fatprod(
id_prcl                     in number,
id_cult                     in number,
data_plant                  in date,
data_prevista               in date,
fat_prod                    in number)

is

  check_constrained_failed exception;
  pragma exception_init (check_constrained_failed, -2290);
  null_constrained_failed exception;
  pragma exception_init (null_constrained_failed, -1400);

begin
    update Registo_Fertilizacao
        set ID_FatPrd_fk = fat_prod
    where ID_Prcl_ck = id_prcl and ID_Cult_ck = id_cult and data_Plant_ck = data_plant and data_hora_previsto_RgtFert_ck = data_prevista;

    if sql%rowcount = 1 then
        dbms_output.put_line('O fator de produção foi alterada com sucesso.');
    else
        dbms_output.put_line('O fator de produção não foi alterada pois os dados inseridos não estão associados a nenhum registo de fertilização.');
    end if;

exception
    when check_constrained_failed then
    dbms_output.put_line('Um ou mais dos dados introduzidos, não respeita/respeitam as restrições de integridade.');
    when null_constrained_failed then
    dbms_output.put_line('Os valores intruzidos são nulos, por favor tente novamente com valores válidos.');
    when others then
    dbms_output.put_line('Ocorreu um problema, por favor tente novamente.');

end;

--Alterar tipo fator produção--
create or replace procedure prc_alterar_registo_fertilizacao_tpfatprod(
id_prcl                     number,
id_cult                     number,
data_plant                  date,
data_prevista               date,
tp_fat_prod                 number)

is

  check_constrained_failed exception;
  pragma exception_init (check_constrained_failed, -2290);
  null_constrained_failed exception;
  pragma exception_init (null_constrained_failed, -1400);

begin
    update Registo_Fertilizacao
        set ID_TpFert_fk = tp_fat_prod
    where ID_Prcl_ck = id_prcl and ID_Cult_ck = id_cult and data_Plant_ck = data_plant and data_hora_previsto_RgtFert_ck = data_prevista;

    if sql%rowcount = 1 then
        dbms_output.put_line('O tipo fator de produção foi alterada com sucesso.');
    else
        dbms_output.put_line('O tipo fator de produção não foi alterada pois os dados inseridos não estão associados a nenhum registo de fertilização.');
    end if;

exception
    when check_constrained_failed then
    dbms_output.put_line('Um ou mais dos dados introduzidos, não respeita/respeitam as restrições de integridade.');
    when null_constrained_failed then
    dbms_output.put_line('Os valores intruzidos são nulos, por favor tente novamente com valores válidos.');
    when others then
    dbms_output.put_line('Ocorreu um problema, por favor tente novamente.');

end;

--Alterar data efetiva--
create or replace procedure prc_alterar_registo_fertilizacao_dataEfet(
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
    update Registo_Fertilizacao
        set  data_hora_efetivo_RgtFert = data_efetiva
    where ID_Prcl_ck = id_prcl and ID_Cult_ck = id_cult and data_Plant_ck = data_plant and data_hora_previsto_RgtFert_ck = data_prevista;

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
create or replace procedure prc_alterar_registo_fertilizacao_quant(
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
    update Registo_Fertilizacao
        set quantidade_RgtFert = quant
    where ID_Prcl_ck = id_prcl and ID_Cult_ck = id_cult and data_Plant_ck = data_plant and data_hora_previsto_RgtFert_ck = data_prevista;

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