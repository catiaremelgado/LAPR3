--Criar/inserir registo de rega--
create or replace procedure prc_criar_registo_rega(
    id_prcl                     in varchar2,
    id_cult                     in varchar2,
    data_plant                  in varchar2,
    data_hora_previsto_rega     in varchar2,
    id_tipo_rega                in varchar2,
    data_hora_efetivo_rega      in varchar2,
    quantidade                  in varchar2)
is

  check_constrained_failed exception;
  pragma exception_init (check_constrained_failed, -2290);
  null_constrained_failed exception;
  pragma exception_init (null_constrained_failed, -1400);

begin

    if (fnc_testar_se_pode_ser_numero(id_prcl) = 1) then
         if (fnc_ver_se_parcela_existe(id_prcl) = 1) then
            if (fnc_testar_se_pode_ser_numero(id_cult) = 1) then
                if (fnc_testar_se_pode_ser_data(data_plant) = 1) then
                    if (fnc_testar_se_pode_ser_timestamp(data_hora_previsto_rega) = 1) then
                        if (fnc_testar_se_pode_ser_numero(id_tipo_rega) = 1) then
                            if (fnc_testar_se_pode_ser_timestamp(data_hora_efetivo_rega) = 1) then
                                if (fnc_testar_se_pode_ser_numero(quantidade) = 1) then
                                    if (fnc_ver_se_operacao_existe(id_prcl, id_cult, data_plant, data_hora_previsto_rega) = 0) then
                                            insert into Operacao values (id_prcl, id_cult, to_date(data_plant,'dd/mm/yyyy'),  to_timestamp(data_hora_previsto_rega,'DD/MM/YYYY HH24:MI'), null, 'Rega');
                                    end if;
                                            insert into Registo_Rega (Id_Prcl_ck, ID_Cult_ck, data_Plant_ck, data_hora_previsto_RgtReg_ck, ID_TpReg_fk, data_hora_efetivo_RgtReg, quantidade_RgtReg)
                                            values (id_prcl, id_cult, to_date(data_plant,'dd/mm/yyyy'), to_timestamp(data_hora_previsto_rega,'dd/mm/yyyy hh24:mi'), id_tipo_rega, to_timestamp(data_hora_efetivo_rega,'dd/mm/yyyy hh24:mi'), quantidade);
                                            dbms_output.put_line('Dados inseridos com sucesso.');
                                else
                                    dbms_output.put_line('O valor introduzido como quantidade n??o ?? v??lido, por favor tente novamente com um valor v??lido!');
                                end if;
                            else
                                dbms_output.put_line('O valor introduzido como data efetiva de rega n??o ?? v??lido, por favor tente novamente com um valor v??lido!');
                            end if;
                        else
                            dbms_output.put_line('O valor introduzido como id do tipo de rega n??o ?? v??lido, por favor tente novamente com um valor v??lido!');
                        end if;
                    else
                        dbms_output.put_line('O valor introduzido como data prevista de rega n??o ?? v??lido, por favor tente novamente com um valor v??lido!');
                    end if;
                else
                    dbms_output.put_line('O valor introduzido como data da planta????o n??o ?? v??lido, por favor tente novamente com um valor v??lido!');
                end if;
            else
                dbms_output.put_line('O id introduzido como id da cultura n??o ?? v??lido, por favor tente novamente com um valor v??lido!');
            end if;
        else
            dbms_output.put_line('O id introduzido como id da parcela n??o existe!');
        end if;
    else
        dbms_output.put_line('O id introduzido como id da parcela n??o ?? v??lido, por favor tente novamente com um valor v??lido!');
    end if;

exception

    when check_constrained_failed then
    dbms_output.put_line('Um ou mais dos dados introduzidos, n??o respeita/respeitam as restri????es de integridade.');
    when null_constrained_failed then
    dbms_output.put_line('Os valores intruzidos s??o nulos, por favor tente novamente com valores v??lidos.');
    when dup_val_on_index then
    dbms_output.put_line('J?? existe uma opera????o com o este id, por favor tente novamente com um novo id.');
    when others then
    dbms_output.put_line('Ocorreu um problema, por favor tente novamente.');

end;