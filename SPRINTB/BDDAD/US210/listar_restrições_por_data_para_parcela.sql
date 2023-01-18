--Listar as restrições por data para uma parcela--
create or replace procedure listar_rest_por_data_para_parcela(prcl number, datai date)
is
    numPrcl number;
    idata date;

    check_constrained_failed exception;
    pragma exception_init (check_constrained_failed, -2290);
    null_constrained_failed exception;
    pragma exception_init (null_constrained_failed, -1400);

    cursor pointer is
    select nome_comercial_FTFtPrd from Fator_Producao fp join Restricoes_Fator_Producao rft on fp.ID_FtPrd_pk = rft.ID_FtPrd_ck
    where rft.ID_Prcl_ck = numPrcl and (idata > rft.data_hora_inicio_RFT) and (idata < rft.data_hora_fim_RFT);

    re_rest Fator_Producao.nome_comercial_FTFtPrd%type;
    see_if_results_exist number;

begin

    numPrcl := prcl;
    idata := datai;

    select count(*) into see_if_results_exist from Restricoes_Fator_Producao rft
    where rft.ID_Prcl_ck = numPrcl and (idata > rft.data_hora_inicio_RFT) and (idata < rft.data_hora_fim_RFT);

    if(see_if_results_exist > 0) then
        open pointer;
            loop
                fetch pointer into re_rest;
                exit when pointer%notfound;
                dbms_output.put_line(re_rest);
            end loop;
    else
        dbms_output.put_line('Não existe nenhuma restrição para a plantação introduzido!');
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
