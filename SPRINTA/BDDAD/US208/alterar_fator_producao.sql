--Alterar preço fator de produção--
create or replace procedure prc_alterar_preco_fator_producao(
id_ft_prd                          in varchar2,
preco_ft_prd                       in varchar2)

is

  check_constrained_failed exception;
  pragma exception_init (check_constrained_failed, -2290);
  null_constrained_failed exception;
  pragma exception_init (null_constrained_failed, -1400);

begin

    if (fnc_testar_se_pode_ser_numero(preco_ft_prd ) = 1) then

        update Fator_Producao
            set preco_FtPrd = preco_ft_prd
        where ID_FtPrd_pk = id_ft_prd;

        if sql%rowcount = 1 then
            dbms_output.put_line('O preço do fator de produção foi alterado com sucesso.');
        else
            dbms_output.put_line('O preço não foi alterado pois o id inserido não está registado.');
        end if;

    else
        dbms_output.put_line('O valor introduzido como preço do fator de produção não é válido, por favor tente novamente com um valor válido!');
    end if;

exception

    when check_constrained_failed then
    dbms_output.put_line('Um ou mais dos dados introduzidos, não respeita/respeitam as restrições de integridade.');
    when null_constrained_failed then
    dbms_output.put_line('Os valores intruzidos são nulos, por favor tente novamente com valores válidos.');
    when others then
    dbms_output.put_line('Ocorreu um problema, por favor tente novamente.');

end;


--Alterar fornecedor fator de produção--
create or replace procedure prc_alterar_fornecedor_fator_producao(
id_ft_prd                          in varchar2,
fornecedor_ft_prd                  in varchar2)

is

  check_constrained_failed exception;
  pragma exception_init (check_constrained_failed, -2290);
  null_constrained_failed exception;
  pragma exception_init (null_constrained_failed, -1400);

begin

    update Fator_Producao
        set fornecedor_FtPrd = fornecedor_ft_prd
    where ID_FtPrd_pk = id_ft_prd;

    if (sql%rowcount = 1) then
            dbms_output.put_line('O fornecedor do fator de produção foi alterado com sucesso.');
    else
            dbms_output.put_line('O fornecedor não foi alterado pois o id inserido não está registado.');
    end if;

exception

    when check_constrained_failed then
        dbms_output.put_line('Um ou mais dos dados introduzidos, não respeita/respeitam as restrições de integridade.');
    when null_constrained_failed then
        dbms_output.put_line('Os valores intruzidos são nulos, por favor tente novamente com valores válidos.');
    when others then
        dbms_output.put_line('Ocorreu um problema, por favor tente novamente.');

end;


--Alterar nome comercial--
create or replace procedure prc_alterar_nome_comercial_fator_producao(
id_ft_prd                          in varchar2,
nome_ft_prd                  in varchar2)

is

  check_constrained_failed exception;
  pragma exception_init (check_constrained_failed, -2290);
  null_constrained_failed exception;
  pragma exception_init (null_constrained_failed, -1400);

begin

    update Fator_Producao
        set nome_comercial_FtPrd = nome_ft_prd
    where ID_FtPrd_pk = id_ft_prd;

    if (sql%rowcount = 1) then
            dbms_output.put_line('O nome comercial do fator de produção foi alterado com sucesso.');
    else
            dbms_output.put_line('O nome comercial não foi alterado pois o id inserido não está registado.');
    end if;

exception

    when check_constrained_failed then
        dbms_output.put_line('Um ou mais dos dados introduzidos, não respeita/respeitam as restrições de integridade.');
    when null_constrained_failed then
        dbms_output.put_line('Os valores intruzidos são nulos, por favor tente novamente com valores válidos.');
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