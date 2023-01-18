--Criar/inserir fator de produção--
create or replace procedure prc_criar_fator_producao(
id_ft_prd                          in varchar2,
preco_ft_prd                       in varchar2,
fornecedor_ft_prd                  in varchar2,
nome_comercial_fornecedor_ft_prd   in varchar2)
is

  check_constrained_failed exception;
  pragma exception_init (check_constrained_failed, -2290);
  null_constrained_failed exception;
  pragma exception_init (null_constrained_failed, -1400);

begin

    if (fnc_testar_se_pode_ser_numero(id_ft_prd) = 1) then
        if (fnc_testar_se_pode_ser_numero(preco_ft_prd ) = 1) then

            insert into Fator_Producao (ID_FtPrd_pk, preco_FtPrd, fornecedor_FtPrd, nome_comercial_FtPrd)
                values (id_ft_prd, preco_ft_prd, fornecedor_ft_prd, nome_comercial_fornecedor_ft_prd);

        else
            dbms_output.put_line('O valor introduzido como preço do fator de produção não é válido, por favor tente novamente com um valor válido!');
        end if;
    else
        dbms_output.put_line('O id introduzido como id do fator de produção não é válido, por favor tente novamente com um valor válido!');
    end if;

exception

    when check_constrained_failed then
    dbms_output.put_line('Um ou mais dos dados introduzidos, não respeita/respeitam as restrições de integridade.');
    when null_constrained_failed then
    dbms_output.put_line('Os valores intruzidos são nulos, por favor tente novamente com valores válidos.');
    when dup_val_on_index then
    dbms_output.put_line('Já existe um fator de produção com o id introduzido, por favor tente novamente com um novo id.');
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