--Remover fator de produção--
create or replace procedure prc_remover_fator_producao(
id_ft_prd                          in varchar2)

is

  check_constrained_failed exception;
  pragma exception_init (check_constrained_failed, -2290);
  null_constrained_failed exception;
  pragma exception_init (null_constrained_failed, -1400);

begin

    if (fnc_testar_se_pode_ser_numero(id_ft_prd ) = 1) then

        delete from Fator_Producao
        where ID_FtPrd_pk = id_ft_prd;

    if sql%rowcount = 1 then
            dbms_output.put_line('Os dados foram eliminados com sucesso.');
    else
            dbms_output.put_line('Os dados não foram eliminados pois o id inserido não está registado.');
    end if;

    else
        dbms_output.put_line('O valor introduzido como id do fator de produção não é válido, por favor tente novamente com um valor válido!');
    end if;

exception

    when check_constrained_failed then
    dbms_output.put_line('O VALOR introduzido, não respeita/respeitam as restrições de integridade.');
    when null_constrained_failed then
    dbms_output.put_line('O valor intruzido é nulo, por favor tente novamente com um valor válido.');
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