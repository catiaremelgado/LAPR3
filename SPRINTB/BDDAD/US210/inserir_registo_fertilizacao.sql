create or replace procedure prc_criar_registo_fertilizacao(
    id_prcl                     in varchar2,
    id_cult                     in varchar2,
    data_plant                  in varchar2,
    data_hora_previsto_fert     in varchar2,
    id_fat_prod                 in varchar2,
    id_tipo_fert                in varchar2,
    data_hora_efetivo_fert      in varchar2,
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
                    if (fnc_testar_se_pode_ser_timestamp(data_hora_previsto_fert) = 1) then
                        if (fnc_testar_se_pode_ser_numero(id_fat_prod) = 1) then
                           if (fnc_testar_se_pode_ser_numero(id_tipo_fert) = 1) then
                                if (fnc_testar_se_pode_ser_timestamp(data_hora_efetivo_fert) = 1) then
                                    if (fnc_testar_se_pode_ser_numero(quantidade) = 1) then
                                        if (fnc_testar_restricoes(id_prcl, id_fat_prod, data_hora_previsto_fert) = 1) then
                                            if (fnc_ver_se_operacao_existe(id_prcl, id_cult, data_plant, data_hora_previsto_fert) = 0) then
                                                insert into Operacao values (id_prcl, id_cult, to_date(data_plant,'dd/mm/yyyy'),  to_timestamp(data_hora_previsto_fert,'DD/MM/YYYY HH24:MI'), null, 'Fertilização');
                                            end if;
                                                insert into Registo_Fertilizacao (Id_Prcl_ck, ID_Cult_ck, data_Plant_ck, data_hora_previsto_RgtFert_ck, ID_FatPrd_fk, ID_TpFert_fk, data_hora_efetivo_RgtFert, quantidade_RgtFert)
                                                values (id_prcl, id_cult, to_date(data_plant,'dd/mm/yyyy'), to_timestamp(data_hora_previsto_fert,'DD/MM/YYYY HH24:MI'), id_fat_prod, id_tipo_fert,
                                              to_timestamp(data_hora_efetivo_fert,'DD/MM/YYYY HH24:MI'), quantidade);
                                            dbms_output.put_line('Dados inseridos com sucesso.');
                                        else
                                            dbms_output.put_line('Devido as restrições do setor onde quer realizar este registo, não foi possivel registar! Por favor tente novamente tendo em atenção as restrições de cada setor!');
                                        end if;
                                    else
                                        dbms_output.put_line('O valor introduzido como quantidade não é válido, por favor tente novamente com um valor válido!');
                                    end if;
                                else
                                    dbms_output.put_line('O valor introduzido como data efetiva de fertilização não é válido, por favor tente novamente com um valor válido!');
                                end if;
                            else
                                dbms_output.put_line('O valor introduzido como id do tipo de fertilização não é válido, por favor tente novamente com um valor válido!');
                            end if;
                        else
                            dbms_output.put_line('O valor introduzido como id de tipo de fator de produção não é válido, por favor tente novamente com um valor válido!');
                        end if;
                    else
                        dbms_output.put_line('O valor introduzido como data prevista de fertilização não é válido, por favor tente novamente com um valor válido!');
                    end if;
                else
                    dbms_output.put_line('O valor introduzido como data da plantação não é válido, por favor tente novamente com um valor válido!');
                end if;
            else
                dbms_output.put_line('O id introduzido como id da cultura não é válido, por favor tente novamente com um valor válido!');
            end if;
        else
            dbms_output.put_line('O id introduzido como id da parcela não existe!');
        end if;
    else
        dbms_output.put_line('O id introduzido como id da parcela não é válido, por favor tente novamente com um valor válido!');
    end if;

exception

when check_constrained_failed then
    dbms_output.put_line('Um ou mais dos dados introduzidos, não respeita/respeitam as restrições de integridade.');
when null_constrained_failed then
    dbms_output.put_line('Os valores intruzidos são nulos, por favor tente novamente com valores válidos.');
when dup_val_on_index then
    dbms_output.put_line('Já existe uma operação com o este id, por favor tente novamente com um novo id.');
when others then
    dbms_output.put_line('Ocorreu um problema, por favor tente novamente.');

end;


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