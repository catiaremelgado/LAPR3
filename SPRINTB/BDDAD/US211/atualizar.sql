CREATE OR REPLACE PROCEDURE atualizar_rega(id_parcela number,id_cultura number, data_plantacao date,
    data_hora_prevista timestamp,id_tipoRega number,quantidade number)
IS
    contador number;
BEGIN
-- Contar quantos registos de rega ainda não realizados.
    SELECT count(*) INTO contador from Registo_Rega Where id_prcl_ck=id_parcela and id_cult_ck=id_cultura and data_plant_ck=data_plantacao and data_hora_previsto_RgtReg_ck=data_hora_prevista and data_hora_efetivo_RgtReg is NULL;

    IF (contador>0) THEN

        UPDATE Registo_Rega
        SET
            ID_TpReg_fk = id_tipoRega,
            quantidade_rgtreg=quantidade
        Where
            id_prcl_ck=id_parcela and
            id_cult_ck=id_cultura and
            data_plant_ck=data_plantacao and
            data_hora_previsto_RgtReg_ck=data_hora_prevista;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Operação não encontrada');
    end if;
END;

CREATE OR REPLACE PROCEDURE atualizar_colheita(id_parcela number,id_cultura number, data_plantacao date,
    data_hora_prevista timestamp,quantidade_colheita number)
IS
    contador number;
BEGIN
-- Contar quantos registos de colheita ainda não realizados.
    SELECT count(*) INTO contador from Registo_Colheita Where id_prcl_ck=id_parcela and ID_Cult_ck=id_cultura and data_Plant_ck=data_plantacao and data_hora_previsto_RgtColh_ck=data_hora_prevista and data_hora_efetivo_RgtColh is NULL;

    IF (contador>0) THEN

        UPDATE Registo_Colheita
        SET
            quantidade_rgtcolh=quantidade_colheita
        Where
            id_prcl_ck=id_parcela and
            ID_Cult_ck=id_cultura and
            data_Plant_ck=data_plantacao and
            data_hora_previsto_RgtColh_ck=data_hora_prevista;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Operação não encontrada');
    end if;
END;

CREATE OR REPLACE PROCEDURE atualizar_fertilizacao(id_parcela number,id_cultura number, data_plantacao date, data_hora_prevista timestamp,
    fat_prod number,quantidade_fert number,tpfert number)
IS
    contador number;
BEGIN
-- Contar quantos registos de fertilizacao ainda não realizados.
    SELECT count(*) INTO contador from Registo_Fertilizacao Where id_prcl_ck=id_parcela and id_cult_ck=id_cultura and data_plant_ck=data_plantacao and ID_FatPrd_fk=fat_prod and data_hora_previsto_RgtFert_ck=data_hora_prevista and data_hora_efetivo_RgtFert is NULL;

    IF (contador>0) THEN

        UPDATE Registo_Fertilizacao
        SET
            ID_TpFert_fk = tpfert,
            quantidade_rgtfert=quantidade_fert
        Where
            id_prcl_ck=id_parcela and
            id_cult_ck=id_cultura and
            data_plant_ck=data_plantacao and
            ID_FatPrd_fk=fat_prod and
            data_hora_previsto_RgtFert_ck=data_hora_prevista;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Operação não encontrada');
    end if;
END;

--tests--

--test Rega--
    SELECT * FROM Registo_Rega;
    call atualizar_rega(10,10,TO_DATE('25/07/2015','dd/mm/yyyy'),TO_TIMESTAMP('16-08-2015 10:40', 'dd-mm-yyyy hh24:mi'),3,100);
    SELECT * FROM Registo_Rega;

--test Colheita--
    SELECT * FROM Registo_Colheita;
    call atualizar_colheita(11,11,TO_DATE('25/10/2015','dd/mm/yyyy'),TO_TIMESTAMP('15-11-2015 10:40', 'dd-mm-yyyy hh24:mi'),200);
    SELECT * FROM Registo_Colheita;

--test Fertilizacao--
    SELECT * FROM Registo_Fertilizacao;
    call atualizar_fertilizacao(12,12,TO_DATE('25/11/2015','dd/mm/yyyy'),TO_TIMESTAMP('15-12-2015 10:40', 'dd-mm-yyyy hh24:mi'),3,300,1);
    SELECT * FROM Registo_Fertilizacao;