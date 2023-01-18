CREATE OR REPLACE PROCEDURE prc_listar_por_kiloeuro_por_hectare(
given_id_safra IN Registo_Colheita.ID_Cult_ck%type)
IS
    rec_parcela Plantacao.ID_Prcl_ck%type;
    rec_preco number(10,2);
    CURSOR cur IS
    SELECT rg.ID_Prcl_ck,
    ROUND(((cult.preco_venda_Cult*(SUM(rg.quantidade_RgtColh)))/pp.area_Plant),2)
    FROM Registo_Colheita rg
    INNER JOIN Plantacao pp
    ON rg.ID_Prcl_ck = pp.ID_Prcl_ck AND rg.ID_Cult_ck = pp.ID_Cult_ck
    INNER JOIN Cultura cult
    ON rg.ID_Cult_ck = cult.ID_Cult_pk
    WHERE rg.ID_Cult_ck = given_id_safra
    GROUP BY rg.ID_Prcl_ck, pp.area_Plant, cult.preco_venda_Cult
    ORDER BY (SUM(rg.quantidade_RgtColh)/pp.area_Plant) DESC;

    to_see_if_safra_exists number;
BEGIN

    SELECT  count(*) INTO to_see_if_safra_exists
    FROM Registo_Colheita
    WHere ID_Cult_ck = given_id_safra
    GROUP BY ID_Cult_ck;

     OPEN cur;
        DBMS_OUTPUT.PUT_LINE('Lucros por k€ por hectare:');
        DBMS_OUTPUT.PUT_LINE('Parcela       Lucro ');
        LOOP
            FETCH cur INTO rec_parcela, rec_preco;
            EXIT WHEN cur%notfound;
            DBMS_OUTPUT.PUT_LINE(rec_parcela  || '             ' || rec_preco);
        END LOOP;
    CLOSE cur;

    EXCEPTION

    WHEN NO_DATA_FOUND THEN

        dbms_output.put_line('Não há registos de colheitas para a safra ' || given_id_safra || '.');
END;

/* para chamar o procedimento:
 call prc_listar_por_kiloeuro_por_hectare(ID_Cult); */