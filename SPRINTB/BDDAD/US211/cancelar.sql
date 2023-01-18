CREATE OR REPLACE PROCEDURE cancelar_rega(id_parcela number,id_cultura number, data_plantacao date,
    data_hora_prevista timestamp)
IS
    contador number;
BEGIN
-- Contar quantos registos de rega ainda não realizados.
    SELECT count(*) INTO contador from Registo_Rega Where id_prcl_ck=id_parcela and id_cult_ck=id_cultura and data_plant_ck=data_plantacao and data_hora_previsto_RgtReg_ck=data_hora_prevista and data_hora_efetivo_RgtReg is NULL;

    IF (contador>0) THEN

    DELETE FROM Registo_Rega
    Where
            id_prcl_ck=id_parcela and
            id_cult_ck=id_cultura and
            data_plant_ck=data_plantacao and
            data_hora_previsto_RgtReg_ck=data_hora_prevista;

    DELETE FROM Operacao
    Where
            id_prcl_ck=id_parcela and
            id_cult_ck=id_cultura and
            data_plant_ck=data_plantacao and
            data_hora_previsto_Op_ck=data_hora_prevista;

    ELSE
        DBMS_OUTPUT.PUT_LINE('Operação não encontrada');
    end if;
END;


CREATE OR REPLACE PROCEDURE cancelar_colheita(id_parcela number,id_cultura number, data_plantacao date,
    data_hora_prevista timestamp)
IS
    contador number;
BEGIN
-- Contar quantos registos de colheita ainda não realizados.
    SELECT count(*) INTO contador from Registo_Colheita Where id_prcl_ck=id_parcela and id_cult_ck=id_cultura and data_Plant_ck=data_plantacao and data_hora_previsto_RgtColh_ck=data_hora_prevista and data_hora_efetivo_RgtColh is NULL;

    IF (contador>0) THEN

        DELETE FROM Registo_Colheita
        Where
            id_prcl_ck=id_parcela and
            id_cult_ck=id_cultura and
            data_plant_ck=data_plantacao and
            data_hora_previsto_RgtColh_ck=data_hora_prevista;

    DELETE FROM Operacao
      Where
            id_prcl_ck=id_parcela and
            id_cult_ck=id_cultura and
            data_plant_ck=data_plantacao and
            data_hora_previsto_Op_ck=data_hora_prevista;

    ELSE
        DBMS_OUTPUT.PUT_LINE('Operação não encontrada');
    end if;
END;


CREATE OR REPLACE PROCEDURE cancelar_fertilizacao(id_parcela number,id_cultura number, data_plantacao date,
    data_hora_prevista timestamp,fat_prod number)
IS
    contador number;
BEGIN
-- Contar quantos registos de fertilizacao ainda não realizados.
    SELECT count(*) INTO contador from Registo_Fertilizacao Where id_prcl_ck=id_parcela and id_cult_ck=id_cultura and data_plant_ck=data_plantacao and ID_FatPrd_fk=fat_prod and data_hora_previsto_RgtFert_ck=data_hora_prevista and data_hora_efetivo_RgtFert is NULL;

    IF (contador>0) THEN

        DELETE FROM Registo_Fertilizacao
        Where
            id_prcl_ck=id_parcela and
            id_cult_ck=id_cultura and
            data_plant_ck=data_plantacao and
            ID_FatPrd_fk=fat_prod and
            data_hora_previsto_RgtFert_ck=data_hora_prevista;

        DELETE FROM Operacao
        Where
                id_prcl_ck=id_parcela and
                id_cult_ck=id_cultura and
                data_plant_ck=data_plantacao and
                data_hora_previsto_Op_ck=data_hora_prevista;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Operação não encontrada');
    end if;
END;

--tests--

--test Rega--
    SELECT * FROM Operacao;
    SELECT * FROM Registo_Rega;
    call cancelar_rega(10,10,TO_DATE('25/07/2015','dd/mm/yyyy'),TO_TIMESTAMP('16-08-2015 10:40', 'dd-mm-yyyy hh24:mi'));
    SELECT * FROM Registo_Rega;
    SELECT * FROM Operacao;

--test Colheita--
    SELECT * FROM Operacao;
    SELECT * FROM Registo_Colheita;
    call cancelar_colheita(11,11,TO_DATE('25/10/2015','dd/mm/yyyy'),TO_TIMESTAMP('15-11-2015 10:40', 'dd-mm-yyyy hh24:mi'));
    SELECT * FROM Registo_Colheita;
    SELECT * FROM Operacao;

--test Fertilizacao--
    SELECT * FROM Operacao;
    SELECT * FROM Registo_Fertilizacao;
    call cancelar_fertilizacao(12,12,TO_DATE('25/11/2015','dd/mm/yyyy'),TO_TIMESTAMP('15-12-2015 10:40', 'dd-mm-yyyy hh24:mi'),3);
    SELECT * FROM Registo_Fertilizacao;
    SELECT * FROM Operacao;