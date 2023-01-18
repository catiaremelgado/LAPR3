CREATE OR REPLACE PROCEDURE prc_ordena_area_setores(li_order in VARCHAR2)
IS

   CURSOR c_area_prcls_asc IS SELECT * FROM PARCELA ORDER BY area_prcl ASC;
   CURSOR c_area_prcls_desc IS SELECT * FROM PARCELA ORDER BY area_prcl DESC;
   li_id_prcl_atual Parcela.id_prcl_pk%type;
   li_designacao_prcl_atual Parcela.designacao_prcl%type;
   li_area_prcl_atual Parcela.area_prcl%type;
   li_count number;

BEGIN
    SELECT COUNT(*)  INTO li_count FROM Parcela;
    IF(li_count<>0) THEN

        IF LOWER(li_order) = 'ascendente' THEN
            OPEN c_area_prcls_asc;
                DBMS_OUTPUT.PUT_LINE('Parcelas por ordem de área: ');
                LOOP
                    FETCH c_area_prcls_asc INTO li_id_prcl_atual,li_designacao_prcl_atual,li_area_prcl_atual;
                    EXIT WHEN c_area_prcls_asc%notfound;
                    DBMS_OUTPUT.PUT_LINE('id de parcela: '||li_id_prcl_atual||' | designação da parcela:'|| li_designacao_prcl_atual||' | área da parcela:'||li_area_prcl_atual);
                END LOOP;
            CLOSE c_area_prcls_asc;
        END IF;
        IF LOWER(li_order) ='descendente'THEN
            OPEN c_area_prcls_desc;
                DBMS_OUTPUT.PUT_LINE('Parcelas por ordem de área: ');
                LOOP
                    FETCH c_area_prcls_desc INTO li_id_prcl_atual,li_designacao_prcl_atual,li_area_prcl_atual;
                    EXIT WHEN c_area_prcls_desc%notfound;
                    DBMS_OUTPUT.PUT_LINE('id de parcela: '||li_id_prcl_atual||' | designação da parcela:'|| li_designacao_prcl_atual||' | área da parcela:'||li_area_prcl_atual);
                END LOOP;
            CLOSE c_area_prcls_desc;
        END IF;
    ELSE
     DBMS_OUTPUT.PUT_LINE('Não foram encontrados dados!');
    END IF;
    
EXCEPTION

    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Algo correu mal e as parcelas não foram ordenadas!');
END;