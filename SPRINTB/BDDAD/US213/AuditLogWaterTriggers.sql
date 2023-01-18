CREATE OR REPLACE TRIGGER operacao_rega_log_audit
AFTER INSERT OR UPDATE OR DELETE ON Registo_Rega
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
                'Rega',
                NULL,
                :NEW.data_hora_efetivo_RgtReg,
                NULL,
                :NEW.data_hora_previsto_RgtReg_ck,
                NULL,
                :NEW.quantidade_RgtReg,
                USER);

                INSERT INTO Rega_Log (ID_OLog_pk,tipo_previo_RLog,tipo_novo_RLog) VALUES ((SELECT NVL(MAX(ID_OLog_pk), 0) FROM Operacao_Log),NULL,:NEW.ID_TpReg_fk);


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
                'Rega',
                :OLD.data_hora_efetivo_RgtReg,
                NULL,
                :OLD.data_hora_previsto_RgtReg_ck,
                NULL,
                :OLD.quantidade_RgtReg,
                NULL,
                USER
                );

            INSERT INTO Rega_Log (ID_OLog_pk,tipo_previo_RLog,tipo_novo_RLog) VALUES ((SELECT NVL(MAX(ID_OLog_pk), 0) FROM Operacao_Log),:OLD.ID_TpReg_fk,NULL);



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
                    'Rega',
                    :OLD.data_hora_efetivo_RgtReg,
                    :NEW.data_hora_efetivo_RgtReg,
                    :OLD.data_hora_previsto_RgtReg_ck,
                    :NEW.data_hora_previsto_RgtReg_ck,
                    :OLD.quantidade_RgtReg,
                    :NEW.quantidade_RgtReg,
                    USER);

                    INSERT INTO Rega_Log (ID_OLog_pk,tipo_previo_RLog,tipo_novo_RLog) VALUES ((SELECT NVL(MAX(ID_OLog_pk), 0) FROM Operacao_Log),:OLD.ID_TpReg_fk,:NEW.ID_TpReg_fk);

        END IF;
END;


insert into Operacao values(8,8,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('15-08-2016 10:55', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('16-08-2016 10:40', 'dd-mm-yyyy hh24:mi'), 'Rega');
insert into Registo_Rega values (8,8,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('15-08-2016 10:55', 'dd-mm-yyyy hh24:mi'),1,TO_TIMESTAMP('16-08-2016 10:40', 'dd-mm-yyyy hh24:mi'),18);
DELETE FROM Registo_Rega WHERE ID_Prcl_ck=8;
SELECT * FROM REGA_LOG;
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


CREATE TABLE  REGA_LOG
(
ID_OLog_pk NUMBER(10) not null
,tipo_previo_RLog VARCHAR2(100) NOT NULL
,tipo_novo_RLog VARCHAR2(100) NOT NULL
,PRIMARY KEY (ID_OLOG_PK)
)


CREATE TABLE  REGISTO_Rega
   (ID_Prcl_ck NUMBER (10) NOT NULL,
    ID_Cult_ck NUMBER (10) NOT NULL,
    data_Plant_ck date not null,
    data_hora_previsto_RgtReg_ck date not null,
    data_hora_efetivo_RgtReg date not null,
    ID_TpReg_fk NUMBER (10) NOT NULL,
    quantidade_RgtReg NUMBER (10) NOT NULL,
    primary key (ID_Prcl_ck,ID_Cult_ck,data_Plant_ck,data_hora_previsto_RgtReg_ck),
    constraint FK_Registo_Tipo_Rega foreign key (ID_TpReg_fk) references Tipo_Rega (ID_TpReg_pk),
    constraint FK_Registo_Rega_Plantacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
    constraint CHK_Quantidade_RgtReg CHECK (quantidade_RgtReg >= 1),
    constraint CHK_Data_Hora_RgtReg CHECK (data_hora_previsto_RgtReg_ck >= date '2007-01-01'));