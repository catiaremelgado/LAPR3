--Criar/inserir tipo fator de produção--
create or replace procedure prc_criar_tipo_fator_producao(
id_tp_ft_prd                   in varchar2,
designacao_tp_ft_prd           in varchar2)
is

  check_constrained_failed exception;
  pragma exception_init (check_constrained_failed, -2290);
  null_constrained_failed exception;
  pragma exception_init (null_constrained_failed, -1400);

begin

    if (fnc_testar_se_pode_ser_numero(id_tp_ft_prd) = 1) then

        insert into Tipo_Fator_Producao (ID_TpFtPrd_pk, designacao_TpFtPrd)
            values (id_tp_ft_prd, designacao_tp_ft_prd);

    else
        dbms_output.put_line('O id introduzido como id do tipo de fator de produção não é válido, por favor tente novamente com um valor válido!');
    end if;

exception

    when check_constrained_failed then
    dbms_output.put_line('Um dos dois ou os dois dados introduzidos, não respeita/respeitam as restrições de integridade.');
    when null_constrained_failed then
    dbms_output.put_line('Os valores intruzidos são nulos, por favor tente novamente com valores válidos.');
    when dup_val_on_index then
    dbms_output.put_line('Já existe um tipo de fator de produção com o id introduzido, por favor tente novamente com um novo id.');
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