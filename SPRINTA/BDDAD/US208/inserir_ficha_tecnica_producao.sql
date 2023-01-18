--Criar/inserir ficha técnica do fator de producao--
create or replace procedure prc_criar_ficha_tecnica_fator_producao(
id_ftf_prd                          in varchar2,
id_tp_ftf_prd                       in varchar2,
id_ft_prd                           in varchar2,
tp_ftf_prd                          in varchar2,
valor_ftf_prd                       in varchar2,
unidade_ftf_prd                     in varchar2)
is

  check_constrained_failed exception;
  pragma exception_init (check_constrained_failed, -2290);
  null_constrained_failed exception;
  pragma exception_init (null_constrained_failed, -1400);

begin

    if (fnc_testar_se_pode_ser_numero(id_ftf_prd) = 1) then
        if (fnc_testar_se_pode_ser_numero(id_tp_ftf_prd) = 1) then
            if (fnc_testar_se_pode_ser_numero(id_ft_prd) = 1) then
                if (fnc_testar_se_pode_ser_numero(valor_ftf_prd) = 1) then

                    insert into Ficha_Tecnica_Producao (ID_FTFtPrd_pk, ID_TpFtPrd_fk, ID_FtPrd_fk, tipo_FTFtPrd, valor_FTFtPrd, unidade_FTFtPrd)
                        values (id_ftf_prd, id_tp_ftf_prd, id_ft_prd, tp_ftf_prd, valor_ftf_prd, unidade_ftf_prd);

                else
                    dbms_output.put_line('O valor introduzido como valor para a ficha do fator de produção não é válido, por favor tente novamente com um valor válido!');
                end if;
            else
                dbms_output.put_line('O valor introduzido como id de fator de produção não é válido, por favor tente novamente com um valor válido!');
            end if;
        else
            dbms_output.put_line('O valor introduzido como id do tipo de fator de produção não é válido, por favor tente novamente com um valor válido!');
        end if;
    else
        dbms_output.put_line('O id introduzido como id da ficha de fator de produção não é válido, por favor tente novamente com um valor válido!');
    end if;

exception

    when check_constrained_failed then
    dbms_output.put_line('Um ou mais dos dados introduzidos, não respeita/respeitam as restrições de integridade.');
    when null_constrained_failed then
    dbms_output.put_line('Os valores intruzidos são nulos, por favor tente novamente com valores válidos.');
    when dup_val_on_index then
    dbms_output.put_line('Já existe uma ficha de fator de produção com o id introduzido, por favor tente novamente com um novo id.');
    when others then
    dbms_output.put_line('Ocorreu um problema, por favor tente novamente.');

end;


-- Testar se o input pode ser transformado em numero--
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