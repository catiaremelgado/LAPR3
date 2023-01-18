CREATE OR REPLACE TRIGGER operacao_colheita_log_audit
AFTER INSERT OR UPDATE OR DELETE ON Registo_Colheita
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
                'Colheita',
                NULL,
                :NEW.data_hora_efetivo_RgtColh,
                NULL,
                :NEW.data_hora_previsto_RgtColh_ck,
                NULL,
                :NEW.quantidade_RgtColh,
                USER);

                INSERT INTO Colheita_Log (ID_OLog_pk) VALUES ((SELECT NVL(MAX(ID_OLog_pk), 0) FROM Operacao_Log));


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
                'Colheita',
                :OLD.data_hora_efetivo_RgtColh,
                NULL,
                :OLD.data_hora_previsto_RgtColh_ck,
                NULL,
                :OLD.quantidade_RgtColh,
                NULL,
                USER
                );
            INSERT INTO Colheita_Log (ID_OLog_pk) VALUES ((SELECT NVL(MAX(ID_OLog_pk), 0) FROM Operacao_Log));


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
                    'Colheita',
                    :OLD.data_hora_efetivo_RgtColh,
                    :NEW.data_hora_efetivo_RgtColh,
                    :OLD.data_hora_previsto_RgtColh_ck,
                    :NEW.data_hora_previsto_RgtColh_ck,
                    :OLD.quantidade_RgtColh,
                    :NEW.quantidade_RgtColh,
                    USER);

                    INSERT INTO Colheita_Log (ID_OLog_pk) VALUES ((SELECT NVL(MAX(ID_OLog_pk), 0) FROM Operacao_Log));

        END IF;
END;



insert into Operacao values(9,9,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('15-08-2016 10:50', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('16-08-2016 10:40', 'dd-mm-yyyy hh24:mi'), 'Colheita');
insert into Registo_Colheita values (9,9,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('15-08-2016 10:50', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('16-08-2016 10:40', 'dd-mm-yyyy hh24:mi'),18);
DELETE FROM REGISTO_COLHEITA WHERE ID_PRCL_CK=9
SELECT * FROM OPERACAO_LOG;
SELECT * FROM COLHEITA_LOG;



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


CREATE TABLE  "COLHEITA_LOG"
   (	"ID_OLOG_PK" NUMBER(10,0) NOT NULL ENABLE,
	 PRIMARY KEY ("ID_OLOG_PK")
  USING INDEX  ENABLE
   )  DEFAULT COLLATION "USING_NLS_COMP"
/


CREATE TABLE  "REGISTO_COLHEITA"
   (	"ID_PRCL_CK" NUMBER(10,0) NOT NULL ENABLE,
	"ID_CULT_CK" NUMBER(10,0) NOT NULL ENABLE,
	"DATA_PLANT_CK" DATE NOT NULL ENABLE,
	"DATA_HORA_PREVISTO_RGTCOLH_CK" DATE NOT NULL ENABLE,
	"DATA_COLH_RGTCOLH" DATE NOT NULL ENABLE,
	"QUANTIDADE_RGTCOLH" NUMBER(10,0),
	 CONSTRAINT "CHK_QUANTIDADE_RGTCOLH" CHECK (quantidade_RgtColh between 1 and 50000) ENABLE,
	 PRIMARY KEY ("ID_PRCL_CK", "ID_CULT_CK", "DATA_PLANT_CK", "DATA_HORA_PREVISTO_RGTCOLH_CK")
  USING INDEX  ENABLE
   )  DEFAULT COLLATION "USING_NLS_COMP"
/
ALTER TABLE  "REGISTO_COLHEITA" ADD CONSTRAINT "FK_REGISTO_COLHEITA_PLANTACAO" FOREIGN KEY ("ID_PRCL_CK", "ID_CULT_CK", "DATA_PLANT_CK")
	  REFERENCES  "PLANTACAO" ("ID_PRCL_CK", "ID_CULT_CK", "DATA_PLANT_CK") ENABLE
/