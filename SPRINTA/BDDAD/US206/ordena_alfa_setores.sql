CREATE OR REPLACE PROCEDURE prc_ordena_alfa_setores
IS

   CURSOR c_designacao_prcls IS SELECT * FROM Parcela ORDER BY UPPER(designacao_prcl) ASC;
   li_id_prcl_atual Parcela.id_prcl_pk%type;
   li_designacao_prcl_atual Parcela.designacao_prcl%type;
   li_area_prcl_atual Parcela.area_prcl%type;
   li_count number;

BEGIN

    SELECT COUNT(*)  INTO li_count FROM Parcela;
    IF(li_count<>0) THEN
        OPEN c_designacao_prcls;
         DBMS_OUTPUT.PUT_LINE('Parcelas por ordem alfabética de designação: ');
        LOOP
            FETCH c_designacao_prcls INTO li_id_prcl_atual,li_designacao_prcl_atual,li_area_prcl_atual;
            EXIT WHEN c_designacao_prcls%notfound;
            DBMS_OUTPUT.PUT_LINE('id de parcela: '||li_id_prcl_atual||' | designação da parcela:'|| li_designacao_prcl_atual||' | área da parcela:'||li_area_prcl_atual);
        END LOOP;
        CLOSE c_designacao_prcls;

    ELSE
     DBMS_OUTPUT.PUT_LINE('Não foram encontrados dados!');
    END IF;
    
EXCEPTION

    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Algo correu mal e as parcelas não foram ordenadas!');
END;