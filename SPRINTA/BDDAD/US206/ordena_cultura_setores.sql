CREATE OR REPLACE PROCEDURE prc_ordena_cultura_setores
IS

   CURSOR c_culturas_prcls IS SELECT tipo_cultura.nome_tpcult,cultura.especie_vegetal_cult,parcela.designacao_prcl FROM cultura
                              INNER JOIN plantacao ON cultura.id_cult_pk=plantacao.id_cult_ck
                              INNER JOIN tipo_cultura ON tipo_cultura.id_tpcult_pk=cultura.id_tpcult_fk
                              INNER JOIN parcela on parcela.id_prcl_pk=plantacao.id_prcl_ck;
   li_nome_atual tipo_cultura.nome_tpcult%type;
   li_especie_atual cultura.especie_vegetal_cult%type;
   li_designacao_atual parcela.designacao_prcl%type;
   li_count number;

BEGIN
    SELECT COUNT(*)  INTO li_count
    FROM cultura INNER JOIN plantacao ON cultura.id_cult_pk=plantacao.id_cult_ck
    INNER JOIN tipo_cultura ON tipo_cultura.id_tpcult_pk=cultura.id_tpcult_fk
    INNER JOIN parcela on parcela.id_prcl_pk=plantacao.id_prcl_ck;

    IF(li_count<>0) THEN
        OPEN c_culturas_prcls;
            DBMS_OUTPUT.PUT_LINE('Culturas e tipos de regimes em cada parcela: ');
            LOOP
                FETCH  c_culturas_prcls INTO  li_nome_atual,li_especie_atual,li_designacao_atual;
                EXIT WHEN c_culturas_prcls%notfound;
                DBMS_OUTPUT.PUT_LINE('Regime da cultura: '||li_nome_atual||' | Espécie vegetal da cultura:'|| li_especie_atual||' | designação da parcela:'||li_designacao_atual);
            END LOOP;
        CLOSE c_culturas_prcls;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Não foram encontrados dados!');
    END IF;

EXCEPTION

    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Algo correu mal e não foi possível listar todas as culturas e os seus tipos por parcela!');
END;