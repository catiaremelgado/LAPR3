--Listar as operações num intrevalo de tempo para uma parcela--
create or replace procedure listar_op_por_intrevalo_para_parcela(prcl in number, datei in date, datef in date)
is
    numPrcl number;
    idata date;
    fdata date;

    check_constrained_failed exception;
    pragma exception_init (check_constrained_failed, -2290);
    null_constrained_failed exception;
    pragma exception_init (null_constrained_failed, -1400);

    cursor pointer is
    select * from Operacao op
    where op.ID_Prcl_ck = numPrcl and (idata < op.data_hora_previsto_Op_ck) and (fdata > op.data_hora_previsto_Op_ck)
    order by (op.data_hora_previsto_Op_ck) ASC;

    re_rest pointer%rowtype;
    see_if_results_exist number;

begin

    numPrcl := prcl;
    idata := datei;
    fdata := datef;

    select count(*) into see_if_results_exist from Operacao op
    where op.ID_Prcl_ck = numPrcl and (idata < op.data_hora_previsto_Op_ck) and (fdata > op.data_hora_previsto_Op_ck);

    if(see_if_results_exist > 0) then
        open pointer;
        dbms_output.put_line('Data Prevista        Tipo de Operação');
            loop
                fetch pointer into re_rest;
                exit when pointer%notfound;
                dbms_output.put_line(re_rest.data_hora_previsto_Op_ck|| '            ' || re_rest.tipo_operacao_Op);
            end loop;
    else
           dbms_output.put_line('Não existem parcelas com operações planeadas para o intrevalo de tempo introduzido!');
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