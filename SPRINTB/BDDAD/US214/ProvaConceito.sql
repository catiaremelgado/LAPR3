CREATE OR REPLACE PROCEDURE prc_evolucao_cinco_anos(id_cult Dim_Cultura.ID_Cult_pk%type,id_set Dim_Setor.ID_Setor_pk%type,data_atual in DATE)
IS
    l_counter NUMBER:=4;
    li_ano Dim_ano.nome_ano%type;
    li_mes Dim_mes.nome_mes%type;
    li_exists Dim_mes.nome_mes%type;

    li_quant_ano FACT_VENDA.quantidade_Vend%type;
    li_lucro_ano FACT_VENDA.preco_vendido_Vend%type;
    li_quant_ano_pass FACT_VENDA.quantidade_Vend%type;
    li_lucro_ano_pass FACT_VENDA.preco_vendido_Vend%type;
    li_quant_ano_dif FACT_VENDA.quantidade_Vend%type;
    li_lucro_ano_dif FACT_VENDA.preco_vendido_Vend%type;

BEGIN

    li_ano:=EXTRACT(YEAR FROM data_atual)-l_counter;

    SELECT COUNT(*) INTO li_exists FROM FACT_PRODUCAO WHERE ID_TEMPo_CK IN
    (SELECT ID_TEMPo_pk FROM DIM_TEMPO WHERE ID_Ano_fk IN
    (SELECT ID_Ano_pk FROM Dim_ano WHERE Nome_Ano >= li_ano)
    AND ID_PRODUTO_CK IN
    (SELECT ID_Produto_pk FROM Dim_Produto WHERE ID_Cult_fk=id_cult)
    AND ID_SETOR_CK=id_set);

    DBMS_OUTPUT.PUT_LINE('             ');
    DBMS_OUTPUT.PUT_LINE('Evolução da producao ao longo dos últimos cinco anos:');
    DBMS_OUTPUT.PUT_LINE('             ');

    IF(li_exists<>0) THEN
        LOOP

            li_ano:=EXTRACT(YEAR FROM data_atual)-l_counter;

            DBMS_OUTPUT.PUT_LINE(li_ano);

            SELECT COUNT(*) INTO li_exists FROM FACT_PRODUCAO WHERE ID_TEMPo_CK IN
            (SELECT ID_TEMPo_pk FROM DIM_TEMPO WHERE ID_Ano_fk IN
            (SELECT ID_Ano_pk FROM Dim_ano WHERE Nome_Ano = li_ano)
            AND ID_PRODUTO_CK IN
            (SELECT ID_Produto_pk FROM Dim_Produto WHERE ID_Cult_fk=id_cult)
            AND ID_SETOR_CK=id_set);


            IF(li_exists<>0) THEN
                FOR production IN
                    (SELECT * FROM FACT_PRODUCAO WHERE ID_TEMPo_CK IN
                     (SELECT ID_TEMPo_pk FROM DIM_TEMPO WHERE ID_Ano_fk IN
                     (SELECT ID_Ano_pk FROM Dim_ano WHERE Nome_Ano = li_ano))
                     AND ID_PRODUTO_CK IN
                     (SELECT ID_Produto_pk FROM Dim_Produto WHERE ID_Cult_fk=id_cult)
                     AND ID_SETOR_CK=id_set)
                    LOOP

                    SELECT nome_mes INTO li_mes FROM DIM_MES WHERE ID_MES_CK=(SELECT ID_MES_FK FROM DIM_TEMPO WHERE ID_TEMPO_PK=production.ID_TEMPO_CK);

                    DBMS_OUTPUT.PUT_LINE(li_mes||'-----Produção-----'||production.quantidade_Prodc);
                    DBMS_OUTPUT.PUT_LINE('             ');
                    END LOOP;
            ELSE
                DBMS_OUTPUT.PUT_LINE('Não existem dados acerca deste ano!');
                DBMS_OUTPUT.PUT_LINE('             ');
            END IF;

            l_counter := l_counter - 1;

            IF l_counter < 0 THEN
              EXIT;
            END IF;

        END LOOP;

    ELSE
     DBMS_OUTPUT.PUT_LINE('Não foram encontrados dados para analisar!');
     DBMS_OUTPUT.PUT_LINE('             ');
    END IF;









    DBMS_OUTPUT.PUT_LINE('             ');
    DBMS_OUTPUT.PUT_LINE('Vendas de um ano para outro nos últimos cinco anos:');
    DBMS_OUTPUT.PUT_LINE('             ');
    l_counter:=4;

    li_ano:=EXTRACT(YEAR FROM data_atual)-l_counter;

    SELECT COUNT(*) INTO li_exists FROM FACT_VENDA WHERE ID_TEMPo_CK IN
    (SELECT ID_TEMPo_pk FROM DIM_TEMPO WHERE ID_Ano_fk IN
    (SELECT ID_Ano_pk FROM Dim_ano WHERE Nome_Ano >= li_ano));

    IF(li_exists<>0) THEN
        LOOP

            li_ano:=EXTRACT(YEAR FROM data_atual)-l_counter;

            DBMS_OUTPUT.PUT_LINE(li_ano);

            SELECT COUNT(*) INTO li_exists FROM FACT_VENDA WHERE ID_TEMPo_CK IN
            (SELECT ID_TEMPo_pk FROM DIM_TEMPO WHERE ID_Ano_fk IN
            (SELECT ID_Ano_pk FROM Dim_ano WHERE Nome_Ano = li_ano));

            li_quant_ano:=0;
            li_lucro_ano:=0;
            li_quant_ano_dif:=0;
            li_lucro_ano_dif:=0;


            IF(li_exists<>0) THEN

                FOR venda IN
                (SELECT * FROM FACT_VENDA WHERE ID_TEMPo_CK IN
                 (SELECT ID_TEMPo_pk FROM DIM_TEMPO WHERE ID_Ano_fk IN
                 (SELECT ID_Ano_pk FROM Dim_ano WHERE Nome_Ano = li_ano)))
                LOOP

                SELECT nome_mes INTO li_mes FROM DIM_MES WHERE ID_MES_CK=(SELECT ID_MES_FK FROM DIM_TEMPO WHERE ID_TEMPO_PK=venda.ID_TEMPO_CK);

                li_quant_ano:=li_quant_ano+venda.quantidade_Vend;

                li_lucro_ano:=li_lucro_ano+(venda.quantidade_Vend*venda.preco_vendido_Vend);


                END LOOP;

                DBMS_OUTPUT.PUT_LINE('-----Quantidade vendida-----'||li_quant_ano);
                li_quant_ano_dif:=li_quant_ano-li_quant_ano_pass;
                DBMS_OUTPUT.PUT_LINE('-----Balanço da quantidade-----'||li_quant_ano_dif);
                DBMS_OUTPUT.PUT_LINE('             ');
                DBMS_OUTPUT.PUT_LINE('-----Lucro de vendas-----'||li_lucro_ano);
                li_lucro_ano_dif:=li_lucro_ano-li_lucro_ano_pass;
                DBMS_OUTPUT.PUT_LINE('-----Balanço do lucro-----'||li_lucro_ano_dif);
                DBMS_OUTPUT.PUT_LINE('             ');

                li_quant_ano_pass:=li_quant_ano;
                li_lucro_ano_pass:=li_lucro_ano;


            ELSE
                DBMS_OUTPUT.PUT_LINE('Não existem dados acerca deste ano!');
                DBMS_OUTPUT.PUT_LINE('             ');
            END IF;


            l_counter := l_counter - 1;

            IF l_counter < 0 THEN
              EXIT;
            END IF;

        END LOOP;
    ELSE
     DBMS_OUTPUT.PUT_LINE('Não foram encontrados dados para analisar!');
     DBMS_OUTPUT.PUT_LINE('             ');
    END IF;












    DBMS_OUTPUT.PUT_LINE('             ');
        DBMS_OUTPUT.PUT_LINE('Vendas mensais por tipo de cultura:');
        DBMS_OUTPUT.PUT_LINE('             ');
        l_counter:=4;

        li_ano:=EXTRACT(YEAR FROM data_atual)-l_counter;

        SELECT COUNT(*) INTO li_exists FROM FACT_VENDA WHERE ID_TEMPo_CK IN
        (SELECT ID_TEMPo_pk FROM DIM_TEMPO WHERE ID_Ano_fk IN
        (SELECT ID_Ano_pk FROM Dim_ano WHERE Nome_Ano >= li_ano));

        IF(li_exists<>0) THEN
            LOOP

                li_ano:=EXTRACT(YEAR FROM data_atual)-l_counter;

                DBMS_OUTPUT.PUT_LINE(li_ano);



                li_quant_ano:=0;
                li_lucro_ano:=0;
                li_quant_ano_dif:=0;
                li_lucro_ano_dif:=0;




                FOR tipo_cultura IN
                (SELECT * FROM DIM_Tipo_Cultura)
                LOOP

                    SELECT COUNT(*) INTO li_exists FROM FACT_VENDA WHERE ID_TEMPo_CK IN
                                    (SELECT ID_TEMPo_pk FROM DIM_TEMPO WHERE ID_Ano_fk IN
                                    (SELECT ID_Ano_pk FROM Dim_ano WHERE Nome_Ano = li_ano)) AND ID_PRODUTO_CK IN
                                    (SELECT ID_PRODUTO_PK FROM DIM_PRODUTO WHERE ID_CULT_FK IN
                                    (SELECT ID_CULT_PK FROM DIM_CULTURA WHERE ID_TPCULT_FK=tipo_cultura.ID_TPCULT_PK));

                    IF(li_exists<>0) THEN
                        FOR venda IN
                        (SELECT * FROM FACT_VENDA WHERE ID_TEMPo_CK IN
                         (SELECT ID_TEMPo_pk FROM DIM_TEMPO WHERE ID_Ano_fk IN
                         (SELECT ID_Ano_pk FROM Dim_ano WHERE Nome_Ano = li_ano)) AND ID_PRODUTO_CK IN
                         (SELECT ID_PRODUTO_PK FROM DIM_PRODUTO WHERE ID_CULT_FK IN
                         (SELECT ID_CULT_PK FROM DIM_CULTURA WHERE ID_TPCULT_FK=tipo_cultura.ID_TPCULT_PK)))
                        LOOP

                        SELECT nome_mes INTO li_mes FROM DIM_MES WHERE ID_MES_CK=(SELECT ID_MES_FK FROM DIM_TEMPO WHERE ID_TEMPO_PK=venda.ID_TEMPO_CK);

                        DBMS_OUTPUT.PUT_LINE(li_mes);
                        DBMS_OUTPUT.PUT_LINE('-----Quantidade vendida-----'||venda.quantidade_Vend);
                        li_lucro_ano:=venda.preco_vendido_Vend*venda.quantidade_Vend;
                        DBMS_OUTPUT.PUT_LINE('-----Lucro de vendas-----'||li_lucro_ano);


                        END LOOP;

                    ELSE
                        DBMS_OUTPUT.PUT_LINE('Não existem dados acerca deste ano!');
                        DBMS_OUTPUT.PUT_LINE('             ');
                    END IF;
                END LOOP;


                l_counter := l_counter - 1;

                IF l_counter < 0 THEN
                  EXIT;
                END IF;

            END LOOP;
        ELSE
         DBMS_OUTPUT.PUT_LINE('Não foram encontrados dados para analisar!');
         DBMS_OUTPUT.PUT_LINE('             ');
        END IF;


EXCEPTION

    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Algo correu mal!');
END;
