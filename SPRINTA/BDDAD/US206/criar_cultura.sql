CREATE OR REPLACE PROCEDURE prc_criar_cultura(
li_id_cult in VARCHAR2,
li_tp_cult in VARCHAR2,
li_especie_vegetal_cult in VARCHAR2,
li_preco_venda_cult in VARCHAR2)
IS

  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  PRAGMA EXCEPTION_INIT(CHECK_CONSTRAINT_VIOLATED, -2290);
  NULL_CONSTRAINT_VIOLATED  EXCEPTION;
  PRAGMA EXCEPTION_INIT (NULL_CONSTRAINT_VIOLATED, -1400);

BEGIN

    IF(fnc_testar_tipo_numero(li_id_cult)=1)THEN
        IF(fnc_testar_tipo_numero(li_tp_cult)=1)THEN
            IF(fnc_testar_tipo_numero(li_preco_venda_cult)=1)THEN

                INSERT INTO Cultura (   ID_Cult_pk,
                                        ID_TpCult_fk,
                                        especie_vegetal_Cult,
                                        preco_venda_Cult) VALUES (  li_id_cult,
                                                                li_tp_cult,
                                                                li_especie_vegetal_cult,
                                                                li_preco_venda_cult);

            ELSE
            DBMS_OUTPUT.PUT_LINE('O preço de venda da cultura não é válido! Não foi criada uma cultura');
            END IF;
        ELSE
        DBMS_OUTPUT.PUT_LINE('O id do tipo da cultura não é válido! Não foi criada uma cultura');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('O id da cultura não é válido! Não foi criada uma cultura');
    END IF;
EXCEPTION

    WHEN CHECK_CONSTRAINT_VIOLATED THEN
    DBMS_OUTPUT.PUT_LINE('A parcela não foi criada pois algum dado não cumpre as restrições de integridade.');
    WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('Já existe uma parcela com essa identificação, tente novamente!');
    WHEN NULL_CONSTRAINT_VIOLATED THEN
    DBMS_OUTPUT.PUT_LINE('Os dados não podem ser nulos!');
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Algo correu mal e a parcela não foi criada!');
END;