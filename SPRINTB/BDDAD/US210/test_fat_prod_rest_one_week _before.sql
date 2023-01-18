--Testar as restrições uma semana antes--
create or replace procedure test_rest_uma_semana_antes(id_prcl in number, data_atual in date)
is
    numPrcl number;
    adata date;

    check_constrained_failed exception;
    pragma exception_init (check_constrained_failed, -2290);
    null_constrained_failed exception;
    pragma exception_init (null_constrained_failed, -1400);

    cursor pointer is
    select * from Registo_Fertilizacao rf
    where rf.ID_Prcl_ck = numPrcl and adata >= to_date(rf.data_hora_previsto_RgtFert_ck - 7);

    re_rest pointer%rowtype;
    see_if_results_exist number;

begin
    numPrcl := id_prcl;
    adata := data_atual;

    select count(*) into see_if_results_exist from Restricoes_Fator_Producao rft
    where rft.ID_Prcl_ck = numPrcl;

    if(see_if_results_exist > 0) then
        open pointer;
            dbms_output.put_line('As seguintes operações fertilização não comprem as restrições de fator de produção na parcela inserida:');
            dbms_output.put_line('Parcela        Cultura        Data Prevista        Fator de Produção');
            loop
                fetch pointer into re_rest;
                    exit when pointer%notfound;
                    if(fnc_testar_restricoes(to_char(re_rest.ID_Prcl_ck), to_char(re_rest.ID_FatPrd_fk), to_char(re_rest.data_hora_previsto_RgtFert_ck)) = 0) then
                        dbms_output.put_line(re_rest.ID_Prcl_ck ||'              '|| re_rest.ID_Cult_ck ||'              '|| re_rest.data_hora_previsto_RgtFert_ck ||'            '|| re_rest.ID_FatPrd_fk);
                    end if;
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