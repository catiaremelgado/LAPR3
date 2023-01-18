CREATE OR REPLACE PROCEDURE prc_criar_setor(
li_id_prcl in VARCHAR2,
li_designacao_prcl in VARCHAR2,
li_area_prcl in VARCHAR2)
IS

  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  PRAGMA EXCEPTION_INIT(CHECK_CONSTRAINT_VIOLATED, -2290);
  NULL_CONSTRAINT_VIOLATED  EXCEPTION;
  PRAGMA EXCEPTION_INIT (NULL_CONSTRAINT_VIOLATED, -1400);

BEGIN

    IF(fnc_testar_tipo_numero(li_id_prcl)=1)THEN
        IF(fnc_testar_tipo_numero(li_area_prcl)=1)THEN

        INSERT INTO Parcela (ID_Prcl_pk,designacao_Prcl,area_Prcl) VALUES (li_id_prcl,li_designacao_prcl,li_area_prcl);


        ELSE
        DBMS_OUTPUT.PUT_LINE('A área da parcela não é válida! Não foi criada uma parcela');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('O id da parcela não é válido! Não foi criada uma parcela');
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