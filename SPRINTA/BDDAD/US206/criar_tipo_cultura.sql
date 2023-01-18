CREATE OR REPLACE PROCEDURE prc_criar_tipo_cultura(
li_id_tpcult in VARCHAR2,
li_nome_tpcult in VARCHAR2)
IS

  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  PRAGMA EXCEPTION_INIT(CHECK_CONSTRAINT_VIOLATED, -2290);
  NULL_CONSTRAINT_VIOLATED  EXCEPTION;
  PRAGMA EXCEPTION_INIT (NULL_CONSTRAINT_VIOLATED, -1400);

BEGIN

    IF(fnc_testar_tipo_numero(li_id_tpcult)=1)THEN

        INSERT INTO Tipo_Cultura (   ID_TpCult_pk,
                                     nome_TpCult) VALUES (  li_id_tpcult,
                                                        li_nome_tpcult);

    ELSE
        DBMS_OUTPUT.PUT_LINE('O id do tipo cultura não é válido! Não foi criada uma cultura');
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