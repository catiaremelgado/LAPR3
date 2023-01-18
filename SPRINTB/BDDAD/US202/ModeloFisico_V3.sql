-- Drop Tables --
drop table input_hub cascade constraints;
drop table input_sensor cascade constraints;
drop table Tipo_Cliente cascade constraints;
drop table Tipo_Cultura cascade constraints;
drop table Tipo_Edificio cascade constraints;
drop table Tipo_Fator_Producao cascade constraints;
drop table Tipo_Fertilizacao cascade constraints;
drop table Tipo_rega cascade constraints;
drop table Tipo_Sensor cascade constraints;
drop table Estado_Encomenda cascade constraints;
drop table Hub cascade constraints;
drop table Nivel cascade constraints;
drop table Parcela cascade constraints;
drop table Cultura cascade constraints;
drop table Plantacao cascade constraints;
drop table Operacao cascade constraints;
drop table Sensor cascade constraints;
drop table Edificio cascade constraints;
drop table Cliente cascade constraints;
drop table Operacao_log cascade constraints;
drop table Colheita_Log cascade constraints;
drop table Fertilizacao_Log cascade constraints;
drop table Rega_Log cascade constraints;
drop table Encomenda cascade constraints;
drop table Fator_Producao cascade constraints;
drop table Ficha_Tecnica_Producao cascade constraints;
drop table Incidente cascade constraints;
drop table Registo_Colheita cascade constraints;
drop table Produto cascade constraints;
drop table Item_Encomenda cascade constraints;
drop table Morada cascade constraints;
drop table Plano_Fertilizacao cascade constraints;
drop table Plano_Rega cascade constraints;
drop table Registo_Fertilizacao cascade constraints;
drop table Registo_Rega cascade constraints;
drop table Registo_Sensor cascade constraints;
drop table Restricoes_Fator_Producao cascade constraints;



--Create tables
create table input_hub (
    hub_info varchar2(25) not null);

create table input_sensor (
    input_string varchar2(25) not null);


create table Tipo_Cliente (
    ID_TpClt_pk      number(10) not null,
    designacao_TpClt varchar2(255) not null,
    primary key (ID_TpClt_pk),
    CONSTRAINT CHK_designacao_TpClt CHECK (LENGTH(TRIM(designacao_TpClt)) IS NOT NULL));

create table Tipo_Cultura (
    ID_Tpcult_pk number(10)  not null,
    nome_TpCult  varchar2(255)  not null,
    primary key (ID_Tpcult_pk),
    CONSTRAINT CHK_nome_TpCult CHECK (LENGTH(TRIM(nome_TpCult)) IS NOT NULL));


create table Tipo_Edificio (
    ID_TpEd_pk number(10)  not null,
    nome_TpEd  varchar2(255) not null,
    primary key (ID_TpEd_pk),
    CONSTRAINT CHK_nome_TpEd CHECK (LENGTH(TRIM(nome_TpEd)) IS NOT NULL));

create table Tipo_Fator_Producao (
    ID_TpFtPrd_pk      number(10)  not null,
    designacao_TpFtPrd varchar2(255) not null,
    primary key (ID_TpFtPrd_pk),
    CONSTRAINT CHK_designacao_TpFtPrd CHECK (LENGTH(TRIM(designacao_TpFtPrd)) IS NOT NULL));

create table Tipo_Fertilizacao (
    ID_TpFert_pk number(10)  not null,
    tipo_TpFert  varchar2(255) not null,
    primary key (ID_TpFert_pk),
    CONSTRAINT CHK_tipo_TpFert CHECK (LENGTH(TRIM(tipo_TpFert)) IS NOT NULL));


create table Tipo_rega (
    ID_TpReg_pk number(10)  not null,
    tipo_TpReg  varchar2(255) not null,
    primary key (ID_TpReg_pk),
    CONSTRAINT CHK_tipo_TpReg CHECK (LENGTH(TRIM(tipo_TpReg)) IS NOT NULL));


create table Tipo_Sensor (
    ID_TpSens_pk    number(10)  not null,
    tipo_TpSens     nvarchar2(255) not null,
    unidade_TpSens  varchar2(255) not null,
    grandeza_TpSens varchar2(255) not null,
    primary key (ID_TpSens_pk),
    CONSTRAINT CHK_tipo_TpSens CHECK (LENGTH(TRIM(tipo_TpSens)) IS NOT NULL),
    CONSTRAINT CHK_unidade_TpSens CHECK (LENGTH(TRIM(unidade_TpSens)) IS NOT NULL),
    CONSTRAINT CHK_grandeza_TpSens CHECK (LENGTH(TRIM(grandeza_TpSens)) IS NOT NULL));

create table Estado_Encomenda (
    ID_EstEnc_pk       number(10)  not null,
    nome_estado_EstEnc varchar2(255) not null,
    primary key (ID_EstEnc_pk),
    CONSTRAINT CHK_nome_estado_EstEnc CHECK (LENGTH(TRIM(nome_estado_EstEnc)) IS NOT NULL));

create table Hub (
    ID_Hub_pk varchar2(25)  not null,
    lat_Hub   number(10,4) not null,
    lang_Hub  number(10,4) not null,
    primary key (ID_Hub_pk),
    CONSTRAINT CHK_ID_Hub_pk CHECK (LENGTH(TRIM(ID_Hub_pk)) IS NOT NULL));

create table Nivel (
     ID_Niv_pk number(10) not null,
     nivel_Niv varchar2(255) not null,
     primary key (ID_Niv_pk),
     CONSTRAINT CHK_nivel_Niv CHECK (LENGTH(TRIM(nivel_Niv)) IS NOT NULL));

create table Parcela (
     ID_Prcl_pk      number(10)  not null,
     designacao_Prcl varchar2(255) not null,
     area_Prcl       number(10,2) not null,
     primary key (ID_Prcl_pk),
     CONSTRAINT CHK_designacao_Prcl CHECK (LENGTH(TRIM(designacao_Prcl)) IS NOT NULL),
     CONSTRAINT CHK_area_Prcl CHECK (area_Prcl between 0.01 and 10000));

create table Cultura (
  ID_Cult_pk           number(10)  not null,
  ID_TpCult_fk         number(10) not null,
  especie_vegetal_Cult varchar2(255) not null,
  primary key (ID_Cult_pk),
  CONSTRAINT FK_Cultura_Tipo_Cultura foreign key (ID_TpCult_fk) references Tipo_Cultura (ID_Tpcult_pk),
  CONSTRAINT CHK_especie_vegetal_Cult CHECK (LENGTH(TRIM(especie_vegetal_Cult)) IS NOT NULL));

create table Plantacao (
    ID_Prcl_ck      number(10) not null,
    ID_Cult_ck      number(10) not null,
    data_Plant_ck   date not null,
    data_dest_Plant date not null,
    area_Plant      number(10,2) not null,
    primary key (ID_Prcl_ck,ID_Cult_ck,data_Plant_ck),
    CONSTRAINT FK_Plantacao_Cultura foreign key (ID_Cult_ck) references Cultura (ID_Cult_pk),
    CONSTRAINT FK_Plantacao_Parcela foreign key (ID_Prcl_ck) references Parcela (ID_Prcl_pk),
    CONSTRAINT CHK_Data_Plant CHECK (data_Plant_ck >= date '2007-01-01'),
    CONSTRAINT CHK_area_Plant CHECK (area_Plant between 0.01 and 10000));

create table Operacao (
     ID_Prcl_ck                 number(10) not null,
     ID_Cult_ck                 number(10) not null,
     data_Plant_ck              date not null,
     data_hora_previsto_Op_ck   date not null,
     data_hora_efetivo_Op       date,
     tipo_operacao_Op           varchar2(255) not null,
     primary key (ID_Prcl_ck,ID_Cult_ck,data_Plant_ck,data_hora_previsto_Op_ck),
     constraint FK_Operacao_Plantacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
     CONSTRAINT CHK_data_hora_efetivo_Op CHECK (data_hora_efetivo_Op >= data_hora_previsto_Op_ck OR data_hora_efetivo_Op IS NULL),
     CONSTRAINT CHK_data_hora_previsto_Op_ck CHECK (data_hora_previsto_Op_ck >= date '2007-01-01'),
     constraint CHK_operacao_tip  CHECK (tipo_operacao_Op like '%__%'));

create table Sensor (
    ID_Sens_pk   number(10)  not null,
    ID_TpSens_fk number(10) not null,
    primary key (ID_Sens_pk),
    constraint FK_Sensor_Tipo_Sensor foreign key (ID_TpSens_fk) references Tipo_Sensor (ID_TpSens_pk));

create table Edificio (
    ID_Ed_pk   number(10)  not null,
    ID_TpEd_fk number(10) not null,
    primary key (ID_Ed_pk),
    constraint FK_Edificio_Tipo_Edificio foreign key (ID_TpEd_fk) references Tipo_Edificio (ID_TpEd_pk));

create table Cliente (
    codigo_interno_ck                     number(10) not null,
    ID_TpClt_fk                           number(10) not null,
    ID_Niv_fk                             number(10) not null,
    ID_Hub_fk                             varchar2(25)  not null,
    nome_Clt                              varchar2(255) not null,
    numero_fiscal_Clt_u                   number(10) not null unique,
    email_Clt_u                           varchar2(255) not null unique,
    plafond_Clt                           number(10,2),
    num_encomendas_ult12meses_Clt         number(10),
    valor_total_encomendas_ult12meses_Clt number(10),
    primary key (codigo_interno_ck),
    constraint FK_Cliente_Hub foreign key (ID_Hub_fk) references Hub (ID_Hub_pk),
    constraint FK_Cliente_Tipo_Cliente foreign key (ID_TpClt_fk) references Tipo_Cliente (ID_TpClt_pk),
    constraint FK_Cliente_Nivel foreign key (ID_Niv_fk) references Nivel (ID_Niv_pk),
    constraint CHK_Nome_Clt  CHECK (nome_Clt like '%__%'),
    constraint CHK_Numero_Fiscal_Clt CHECK (numero_fiscal_Clt_u >= 100000000),
    constraint CHK_Email_Clt  CHECK (email_Clt_u like '%___@___%.__%'),
    constraint CHK_Plafond_Clt CHECK (plafond_Clt >= 1),
    constraint CHK_num_encomendas_ult12meses_Clt CHECK (num_encomendas_ult12meses_Clt >= 0),
    constraint CHK_valor_total_encomendas_ult12meses_Clt CHECK (valor_total_encomendas_ult12meses_Clt >= 0));


create table Operacao_Log (
    ID_OLog_pk               number(10)  not null,
    ID_Prcl_fk               number(10) not null,
    ID_Cult_fk               number(10) not null,
    data_Plant_fk            date not null,
    data_exec_OLog           date not null,
    comando_OLog             varchar(255)  not null,
    tipo_operacao_OLog       varchar(255)  not null,
    data_efetivo_previo_OLog date,
    data_efetivo_novo_OLog   date,
    DATA_PREVISTO_PREVIO_OLOG DATE,
    DATA_PREVISTO_NOVO_OLOG DATE,
    quantidade_previa_OLog   number(10,0),
    quantidade_nova_OLog     number(10,0),
    user_OLog                varchar(255) not null,
    primary key (ID_OLog_pk),
    constraint FK_operacao_log_Plantacao foreign key (ID_Prcl_fk, ID_Cult_fk, data_Plant_fk) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck));


create table Colheita_Log (
    ID_OLog_pk number(10) not null,
    primary key (ID_OLog_pk),
    constraint FK_colheita_log_operacao_log foreign key (ID_OLog_pk) references operacao_log (ID_OLog_pk));

create table Fertilizacao_Log (
    ID_OLog_pk        number(10) not null,
    tipo_previo_FLog number(10),
    tipo_novo_FLog   number(10),
    primary key (ID_OLog_pk),
    constraint FK_fertilizacao_log_operacao_log foreign key (ID_OLog_pk) references operacao_log (ID_OLog_pk));

create table Rega_Log (
    ID_OLog_pk       number(10) not null,
    tipo_previo_RLog number(10),
    tipo_novo_RLog   number(10),
    primary key (ID_OLog_pk),
    constraint FK_rega_log_operacao_log foreign key (ID_OLog_pk) references operacao_log (ID_OLog_pk));


create table Encomenda (
    ID_Enc_pk                       number(10)  not null,
    codigo_interno_fk               number(10) not null,
    ID_EstEnc_fk                    number(10) not null,
    ID_Hub_fk                       varchar2(25)  not null,
    data_pedido_Enc                 date not null,
    data_entrega_Enc                date not null,
    data_limite_pagamento_Enc       date not null,
    data_pagamento_pelo_Cliente_Enc date not null,
    primary key (ID_Enc_pk),
    constraint FK_Encomenda_Cliente foreign key (codigo_interno_fk) references Cliente (codigo_interno_ck),
    constraint FK_Encomenda_Estado_Encomedna foreign key (ID_EstEnc_fk) references Estado_Encomenda (ID_EstEnc_pk),
    constraint FK_Encomenda_Hub foreign key (ID_Hub_fk) references Hub (ID_Hub_pk),
    constraint CHK_Data_Pedido_Enc CHECK (data_pedido_Enc >= date '2007-01-01'),
    constraint CHK_Data_Entrega_Enc CHECK (data_entrega_Enc >= data_pedido_Enc),
    constraint CHK_Data_Pagamento_Pelo_Cliente_Enc CHECK (data_pagamento_pelo_cliente_Enc >= data_pedido_Enc));


create table Fator_Producao (
    ID_FtPrd_pk            number(10)  not null,
    ID_TpFtPrd_fk          number(10) not null,
    preco_FtPrd            number(10,2) not null,
    fornecedor_FTFtPrd     varchar2(255) not null,
    nome_comercial_FTFtPrd varchar2(255) not null,
    primary key (ID_FtPrd_pk),
    constraint FK_Fator_Producao_Tipo_Fator_Producao foreign key (ID_TpFtPrd_fk) references Tipo_Fator_Producao (ID_TpFtPrd_pk),
    CONSTRAINT CHK_nome_comercial_FTFtPrd CHECK (LENGTH(TRIM(nome_comercial_FTFtPrd)) IS NOT NULL),
    CONSTRAINT CHK_fornecedor_FTFtPrd CHECK (LENGTH(TRIM(fornecedor_FTFtPrd)) IS NOT NULL),
    CONSTRAINT CHK_preco_FtPrd CHECK (preco_FtPrd > 0.00));


create table Ficha_Tecnica_Producao (
    ID_FTFPrd_pk    number(10)  not null,
    ID_FtPrd_fk     number(10) not null,
    tipo_FTFtPrd    varchar2(255) not null,
    valor_FTFtPrd   number(10,2) not null,
    unidade_FTFtPrd varchar2(255) not null,
    primary key (ID_FTFPrd_pk),
    constraint FK_Ficha_Tecnica_Producao_Fator_Producao foreign key (ID_FtPrd_fk) references Fator_Producao (ID_FtPrd_pk),
    CONSTRAINT CHK_tipo_FTFtPrd CHECK (LENGTH(TRIM(tipo_FTFtPrd)) IS NOT NULL),
    CONSTRAINT CHK_unidade_FTFtPrd CHECK (LENGTH(TRIM(unidade_FTFtPrd)) IS NOT NULL),
    CONSTRAINT CHK_Valor_FTFPrd CHECK (valor_FTFtPrd >= 0.00));

create table Incidente (
    ID_Enc_pk             number(10) not null,
    codigo_interno_clt_fk number(10) not null,
    data_inicio_Inci      date not null,
    data_sanado_Inci      date not null,
    primary key (ID_Enc_pk),
    constraint FK_Incidente_Cliente foreign key (codigo_interno_clt_fk) references Cliente (codigo_interno_ck),
    constraint FK_Incidente_Encomenda foreign key (ID_Enc_pk) references Encomenda(ID_Enc_pk),
    CONSTRAINT CHK_data_inicio_Inci CHECK (data_inicio_Inci >= date '2007-01-01'),
    CONSTRAINT CHK_data_sanado_Inci CHECK (data_sanado_Inci >= data_inicio_Inci));

create table Registo_Colheita (
    ID_Prcl_ck                          number(10) not null,
    ID_Cult_ck                          number(10) not null,
    data_Plant_ck                       date not null,
    data_hora_previsto_RgtColh_ck       date not null,
    data_hora_efetivo_RgtColh           date,
    quantidade_RgtColh                  number(10,2) not null,
    primary key (ID_Prcl_ck,ID_Cult_ck,data_Plant_ck,data_hora_previsto_RgtColh_ck),
    constraint FK_Registo_Colheita_Operacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck, data_hora_previsto_RgtColh_ck) references Operacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck, data_hora_previsto_Op_ck),
    constraint FK_Registo_Colheita_Plantacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
    CONSTRAINT CHK_data_hora_efetivo_RgtColh_ck CHECK (data_hora_efetivo_RgtColh >= data_hora_previsto_RgtColh_ck OR data_hora_efetivo_RgtColh IS NULL),
    CONSTRAINT CHK_data_hora_previsto_RgtColh_ck CHECK (data_hora_previsto_RgtColh_ck > data_Plant_ck),
    CONSTRAINT CHK_Quantidade_RgtColh CHECK (quantidade_RgtColh between 0.01 and 50000));


create table Produto (
    ID_Prcl_ck                      number(10) not null,
    ID_Cult_pk                      number(10) not null,
    data_Plant_ck                   date not null,
    data_hora_efetivo_RgtColh_ck    date not null,
    preco_venda_Prod                number(10,2) not null,
    primary key (ID_Cult_pk,ID_Prcl_ck,data_Plant_ck,data_hora_efetivo_RgtColh_ck),
    constraint FK_Produto_Registo_Colheita foreign key (ID_Prcl_ck, ID_Cult_pk, data_Plant_ck, data_hora_efetivo_RgtColh_ck) references Registo_Colheita (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck, data_hora_previsto_RgtColh_ck),
    CONSTRAINT CHK_preco_venda_Prod CHECK (preco_venda_Prod > 0.00));

create table Item_Encomenda (
    ID_Enc_ck                               number(10) not null,
    ID_Prcl_ck                              number(10) not null,
    ID_Cult_ck                              number(10) not null,
    data_Plant_ck                           date not null,
    data_hora_efetivo_RgtColh_ck            date not null,
    quantidade_encomenda_ItmEnc             number(10,2) not null,
    preco_unitario_ItmEnc                   number(10,2) not null,
    nome_produto_ItmEnc                     varchar2(255) not null,
    primary key (ID_Enc_ck,ID_Cult_ck,ID_Prcl_ck,data_Plant_ck,data_hora_efetivo_RgtColh_ck),
    constraint FK_Item_Encomenda foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck, data_hora_efetivo_RgtColh_ck)
    references Produto (ID_Prcl_ck, ID_Cult_pk, data_Plant_ck, data_hora_efetivo_RgtColh_ck),
    constraint FK_Item_Encomenda_Encomenda foreign key (ID_Enc_ck) references Encomenda (ID_Enc_pk),
    CONSTRAINT CHK_preco_unitario_ItmEnc CHECK (preco_unitario_ItmEnc > 0.00),
    CONSTRAINT CHK_nome_produto_ItmEnc CHECK (LENGTH(TRIM(nome_produto_ItmEnc)) IS NOT NULL),
    CONSTRAINT CHK_quantidade_encomenda_ItmEnc CHECK (quantidade_encomenda_ItmEnc between 0.01 and 10000));

create table Morada (
    ID_Mor_pk             number(7)  not null,
    codigo_interno_clt_fk number(10) not null,
    morada_Mor            varchar2(255) not null,
    fiscal_Mor            number(1) not null,
    primary key (ID_Mor_pk),
    constraint FK_Morada_Cliente foreign key (codigo_interno_clt_fk) references Cliente (codigo_interno_ck),
    CONSTRAINT CHK_morada_Mor CHECK (LENGTH(TRIM(morada_Mor)) IS NOT NULL),
    CONSTRAINT CHK_Fiscal CHECK (fiscal_Mor = 1 OR fiscal_Mor = 0));


create table Plano_Fertilizacao (
    ID_Prcl_ck              number(10) not null,
    ID_Cult_ck              number(10) not null,
    ID_FtPrd_ck             number(10) not null,
    data_Plant_ck           date not null,
    data_inicial_PlnFert_ck date not null,
    data_final_PlnFert_ck   date not null,
    ID_TpFert_fk            number(10) not null,
    quantidade_PlnFert      number(10,2) not null,
    primary key (ID_Prcl_ck,ID_cult_ck,ID_FtPrd_ck,data_Plant_ck,data_inicial_PlnFert_ck,data_final_PlnFert_ck),
    constraint FK_Plano_Fertilizacao_Tipo_Fertilizacao foreign key (ID_TpFert_fk) references Tipo_Fertilizacao (ID_TpFert_pk),
    constraint FKPlano_Fert355032 foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
    CONSTRAINT CHK_Inicial_PlnFert CHECK (data_inicial_PlnFert_ck >= date '2007-01-01'),
    CONSTRAINT CHK_Final_PlnFert CHECK (data_final_PlnFert_ck <= date '2037-01-01'),
    CONSTRAINT CHK_Data_Inicial_PlnFert CHECK (data_inicial_PlnFert_ck <= data_final_PlnFert_ck),
    CONSTRAINT CHK_Quantidade_PlnFert CHECK (quantidade_PlnFert > 0.00));

create table Plano_Rega (
    ID_Prcl_ck              number(10) not null,
    ID_Cult_ck              number(10) not null,
    data_Plant_ck           date not null,
    ID_TpReg_fk             number(10) not null,
    tempo_rega_PlnReg       number(10,2) not null,
    quantidade_PlnReg       number(10,2) not null,
    periocidade_PlnReg      number(10,2) not null,
    primary key (ID_Prcl_ck,ID_Cult_ck,data_Plant_ck),
    constraint FK_Plano_Rega_Plantacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
    constraint FK_Plano_Rega_Tipo_Rega foreign key (ID_TpReg_fk) references tipo_rega (ID_TpReg_pk),
    CONSTRAINT CHK_Tempo_PlnReg CHECK (tempo_rega_PlnReg > 0.00),
    CONSTRAINT CHK_Quantidade_PlnReg CHECK (quantidade_PlnReg > 0.00),
    CONSTRAINT CHK_Periocidade_PlnReg CHECK (periocidade_PlnReg > 0.00));

create table Registo_Fertilizacao (
    ID_Prcl_ck                   number(10) not null,
    ID_Cult_ck                   number(10) not null,
    data_Plant_ck                date not null,
    data_hora_previsto_RgtFert_ck   date not null,
    ID_FatPrd_fk                 number(10) not null,
    ID_TpFert_fk                 number(10) not null,
    data_hora_efetivo_RgtFert    date,
    quantidade_RgtFert           number(10,2) not null,
    primary key (ID_Prcl_ck,ID_Cult_ck,data_Plant_ck,data_hora_previsto_RgtFert_ck),
    constraint FK_Registo_Fertilizacao_Operacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck, data_hora_previsto_RgtFert_ck) references Operacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck, data_hora_previsto_Op_ck),
    constraint FK_Registo_Fertilizacao_Fator_Producao foreign key (ID_FatPrd_fk) references Fator_Producao (ID_FtPrd_pk),
    constraint FK_Registo_Fertilizacao_Plantacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
    constraint FK_Registo_Fertilizacao_Tipo_Fertilizacao foreign key (ID_TpFert_fk) references Tipo_Fertilizacao (ID_TpFert_pk),
    CONSTRAINT CHK_Quantidade_RgtFert CHECK (quantidade_RgtFert > 0.00),
    CONSTRAINT CHK_data_hora_previsto_RgtFert_ck CHECK (data_hora_previsto_RgtFert_ck <= data_hora_efetivo_RgtFert),
    CONSTRAINT CHK_data_hora_efetivo_RgtFert CHECK (data_hora_efetivo_RgtFert >= data_Plant_ck OR data_hora_efetivo_RgtFert IS NULL));

create table Registo_Rega (
    Id_Prcl_ck                  number(10) not null,
    ID_Cult_ck                  number(10) not null,
    data_Plant_ck               date not null,
    data_hora_previsto_RgtReg_ck   date not null,
    ID_TpReg_fk                 number(10) not null,
    data_hora_efetivo_RgtReg    date,
    quantidade_RgtReg           number(10,2) not null,
    primary key (Id_Prcl_ck, ID_Cult_ck, data_Plant_ck,data_hora_previsto_RgtReg_ck),
    constraint FK_Registo_Rega_Operacao foreign key (Id_Prcl_ck, ID_Cult_ck, data_Plant_ck, data_hora_previsto_RgtReg_ck) references Operacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck, data_hora_previsto_Op_ck),
    constraint FK_Registo_Rega_Tipo_Rega foreign key (ID_TpReg_fk) references tipo_rega (ID_TpReg_pk),
    CONSTRAINT CHK_quantidade_RgtReg CHECK (quantidade_RgtReg > 0.00),
    CONSTRAINT CHK_data_hora_previsto_RgtReg_ck CHECK (data_hora_previsto_RgtReg_ck <= data_hora_efetivo_RgtReg),
    CONSTRAINT CHK_data_hora_efetivo_RgtReg CHECK (data_hora_efetivo_RgtReg >= data_Plant_ck OR data_hora_efetivo_RgtReg IS NULL));


create table Registo_Sensor (
    ID_Prcl_ck                number(10) not null,
    ID_Cult_ck                number(10) not null,
    data_Plant_ck             date not null,
    ID_Sens_ck                number(10) not null,
    data_capturado_RgtSens_ck date not null,
    valor_capturado_RgtSens   number(10) not null,
    valor_ref_InSens          number(10) not null,
    primary key (ID_Prcl_ck,ID_Cult_ck,data_Plant_ck,ID_Sens_ck,data_capturado_RgtSens_ck),
    constraint FK_Registo_Sensor_Plantacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
    constraint FK_Registo_Sensor foreign key (ID_Sens_ck) references Sensor (ID_Sens_pk));

create table Restricoes_Fator_Producao (
    ID_Prcl_ck           number(10) not null,
    ID_FtPrd_ck          number(10) not null,
    data_hora_inicio_RFT date not null,
    data_hora_fim_RFT    date not null,
    primary key (ID_Prcl_ck,ID_FtPrd_ck,data_hora_inicio_RFT,data_hora_fim_RFT),
    constraint FK_Restricoes_Fator_Producao foreign key (ID_FtPrd_ck) references Fator_Producao (ID_FtPrd_pk),
    constraint FK_Restricoes_Parcela foreign key (ID_Prcl_ck) references Parcela (ID_Prcl_pk),
    CONSTRAINT CHK_data_hora_fim_RFT CHECK (data_hora_fim_RFT >= data_hora_inicio_RFT),
    CONSTRAINT CHK_data_hora_inicio_RFT CHECK (data_hora_inicio_RFT <= date '2037-01-01'));


