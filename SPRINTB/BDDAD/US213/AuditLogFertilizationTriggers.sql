CREATE OR REPLACE TRIGGER operacao_fertilizacao_log_audit
AFTER INSERT OR UPDATE OR DELETE ON Registo_Fertilizacao
FOR EACH ROW
BEGIN

IF INSERTING THEN

	            INSERT INTO Operacao_Log (  ID_OLog_pk,
                                            ID_Prcl_fk,
                                            ID_Cult_fk,
                                            data_Plant_fk,
                                            data_exec_OLog,
                                            comando_OLog,
                                            tipo_operacao_OLog,
                                            data_efetivo_previo_OLog,
                                            data_efetivo_novo_OLog,
                                            data_previsto_previo_OLog,
                                            data_previsto_novo_OLog,
                                            quantidade_previa_OLog,
                                            quantidade_nova_OLog,
                                            user_OLog)
                VALUES( (SELECT NVL(MAX(ID_OLog_pk), 0)+1 FROM Operacao_Log),
                :NEW.ID_Prcl_ck,
                :NEW.ID_Cult_ck,
                :NEW.data_Plant_ck,
                CURRENT_DATE,
                'INSERT',
                'Fertilização',
                NULL,
                :NEW.data_hora_efetivo_RgtFert,
                NULL,
                :NEW.data_hora_previsto_RgtFert_ck,
                NULL,
                :NEW.quantidade_RgtFert,
                USER);

                INSERT INTO Fertilizacao_Log (ID_OLog_pk,tipo_previo_FLog,tipo_novo_FLog) VALUES ((SELECT NVL(MAX(ID_OLog_pk), 0) FROM Operacao_Log),NULL,:NEW.ID_TpFert_fk);


ELSIF DELETING THEN

            INSERT INTO Operacao_Log (
            ID_OLog_pk,
            ID_Prcl_fk,
            ID_Cult_fk,
            data_Plant_fk,
            data_exec_OLog,
            comando_OLog,
            tipo_operacao_OLog,
            data_efetivo_previo_OLog,
            data_efetivo_novo_OLog,
            data_previsto_previo_OLog,
            data_previsto_novo_OLog,
            quantidade_previa_OLog,
            quantidade_nova_OLog,
            user_OLog
            ) VALUES(
                (SELECT NVL(MAX(ID_OLog_pk), 0)+1 FROM Operacao_Log),
                :OLD.ID_Prcl_ck,
                :OLD.ID_Cult_ck,
                :OLD.data_Plant_ck,
                CURRENT_DATE,
                'DELETE',
                'Fertilização',
                :OLD.data_hora_efetivo_RgtFert,
                NULL,
                :OLD.data_hora_previsto_RgtFert_ck,
                NULL,
                :OLD.quantidade_RgtFert,
                NULL,
                USER
                );

            INSERT INTO Fertilizacao_Log (ID_OLog_pk,tipo_previo_FLog,tipo_novo_FLog) VALUES ((SELECT NVL(MAX(ID_OLog_pk), 0) FROM Operacao_Log),:OLD.ID_TpFert_fk,NULL);



ELSIF UPDATING THEN

	                INSERT INTO Operacao_Log (
                                                ID_OLog_pk,
                                                ID_Prcl_fk,
                                                ID_Cult_fk,
                                                data_Plant_fk,
                                                data_exec_OLog,
                                                comando_OLog,
                                                tipo_operacao_OLog,
                                                data_efetivo_previo_OLog,
                                                data_efetivo_novo_OLog,
                                                data_previsto_previo_OLog,
                                                data_previsto_novo_OLog,
                                                quantidade_previa_OLog,
                                                quantidade_nova_OLog,
                                                user_OLog)
                    VALUES(
                    (SELECT NVL(MAX(ID_OLog_pk), 0)+1 FROM Operacao_Log),
                    :NEW.ID_Prcl_ck,
                    :NEW.ID_Cult_ck,
                    :NEW.data_Plant_ck,
                    CURRENT_DATE,
                    'Update',
                    'Fertilização',
                    :OLD.data_hora_efetivo_RgtFert,
                    :NEW.data_hora_efetivo_RgtFert,
                    :OLD.data_hora_previsto_RgtFert_ck,
                    :NEW.data_hora_previsto_RgtFert_ck,
                    :OLD.quantidade_RgtFert,
                    :NEW.quantidade_RgtFert,
                    USER);

                    INSERT INTO Fertilizacao_Log (ID_OLog_pk,tipo_previo_FLog,tipo_novo_FLog) VALUES ((SELECT NVL(MAX(ID_OLog_pk), 0) FROM Operacao_Log),:OLD.ID_TpFert_fk,:NEW.ID_TpFert_fk);

        END IF;
END;


insert into Operacao values(9,9,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('15-08-2016 10:45', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('16-08-2016 10:40', 'dd-mm-yyyy hh24:mi'), 'Fertilização');
insert into Registo_Fertilizacao values (9,9,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('15-08-2016 10:45', 'dd-mm-yyyy hh24:mi'),1,1,TO_TIMESTAMP('16-08-2016 10:40', 'dd-mm-yyyy hh24:mi'),10);
DELETE FROM Registo_Fertilizacao WHERE ID_Prcl_ck=9;
SELECT * FROM Fertilizacao_LOG;
SELECT * FROM OPERACAO_LOG;


CREATE TABLE  "OPERACAO_LOG"
   (	"ID_OLOG_PK" NUMBER(10,0) NOT NULL ENABLE,
	"ID_PRCL_FK" NUMBER(10,0) NOT NULL ENABLE,
	"ID_CULT_FK" NUMBER(10,0) NOT NULL ENABLE,
	"DATA_PLANT_FK" DATE NOT NULL ENABLE,
	"DATA_EXEC_OLOG" DATE NOT NULL ENABLE,
	"COMANDO_OLOG" VARCHAR2(100) COLLATE "USING_NLS_COMP" NOT NULL ENABLE,
	"TIPO_OPERACAO_OLOG" VARCHAR2(100) COLLATE "USING_NLS_COMP" NOT NULL ENABLE,
	"DATA_EFETIVO_PREVIO_OLOG" DATE,
	"DATA_EFETIVO_NOVO_OLOG" DATE,
	"DATA_PREVISTO_PREVIO_OLOG" DATE,
	"DATA_PREVISTO_NOVO_OLOG" DATE,
	"QUANTIDADE_PREVIA_OLOG" NUMBER(10,0),
	"QUANTIDADE_NOVA_CLOG" NUMBER(10,0),
	"USER_OLOG" VARCHAR2(100) COLLATE "USING_NLS_COMP" NOT NULL ENABLE,
	 PRIMARY KEY ("ID_OLOG_PK")
  USING INDEX  ENABLE
   )  DEFAULT COLLATION "USING_NLS_COMP"
/
ALTER TABLE  "OPERACAO_LOG" ADD CONSTRAINT "FK_OPERACAO_LOG_PLANTACAO" FOREIGN KEY ("ID_PRCL_FK", "ID_CULT_FK", "DATA_PLANT_FK")
	  REFERENCES  "PLANTACAO" ("ID_PRCL_CK", "ID_CULT_CK", "DATA_PLANT_CK") ENABLE
/


CREATE TABLE  Fertilizacao_Log
(
ID_OLog_pk NUMBER(10) not null
,tipo_previo_FLog VARCHAR2(100)
,tipo_novo_FLog VARCHAR2(100)
,PRIMARY KEY (ID_OLOG_PK)
)



CREATE TABLE  REGISTO_Fertilizacao
   (ID_Prcl_ck NUMBER (10) NOT NULL,
    ID_Cult_ck NUMBER (10) NOT NULL,
    data_Plant_ck date not null,
    data_hora_previsto_RgtFert_ck date not null,
    data_hora_efetivo_RgtFert date not null,
    ID_TpFert_fk NUMBER (10) NOT NULL,
    quantidade_RgtFert NUMBER (10) NOT NULL,
    primary key (ID_Prcl_ck,ID_Cult_ck,data_Plant_ck,data_hora_previsto_RgtRgtFert_ck),
    constraint FK_Registo_Tipo_Fert foreign key (ID_TpReg_fk) references Tipo_Rega (ID_TpFert_pk),
    constraint FK_Registo_Fert_Plantacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
    constraint CHK_Quantidade_RgtFert CHECK (quantidade_RgtFert >= 1),
    constraint CHK_Data_Hora_RgtFert CHECK (data_hora_previsto_RgtFert_ck >= date '2007-01-01'));