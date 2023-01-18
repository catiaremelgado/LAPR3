CREATE OR REPLACE PROCEDURE prc_criar_plantacao(
li_id_prcl in VARCHAR2,
li_id_cult in VARCHAR2,
li_data_plant in VARCHAR2,
li_data_dest_plant in VARCHAR2,
li_area_plant in VARCHAR2)
IS

  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  PRAGMA EXCEPTION_INIT(CHECK_CONSTRAINT_VIOLATED, -2290);
  NULL_CONSTRAINT_VIOLATED  EXCEPTION;
  PRAGMA EXCEPTION_INIT (NULL_CONSTRAINT_VIOLATED, -1400);

BEGIN

    IF(fnc_testar_tipo_numero(li_id_cult)=1)THEN
        IF(fnc_testar_tipo_numero(li_id_prcl)=1)THEN
            IF(fnc_testar_tipo_numero(li_area_plant)=1)THEN
                IF(fnc_testar_tipo_date(li_data_plant)=1)THEN

                INSERT INTO Plantacao ( ID_Prcl_ck,
                                        ID_Cult_ck,
                                        data_Plant_ck,
                                        data_dest_Plant,
                                        area_Plant) VALUES (  li_id_prcl,
                                                              li_id_cult,
                                                              li_data_plant,
                                                              li_data_dest_plant,
                                                              li_area_plant);
                ELSE
                DBMS_OUTPUT.PUT_LINE('A data da plantação não é válida! Não foi criada uma plantação');
                END IF;
            ELSE
            DBMS_OUTPUT.PUT_LINE('A área da plantação não é válida! Não foi criada uma plantação');
            END IF;
        ELSE
        DBMS_OUTPUT.PUT_LINE('O id da parcela não é válido! Não foi criada uma plantação');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('O id da cultura não é válido! Não foi criada uma plantação');
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