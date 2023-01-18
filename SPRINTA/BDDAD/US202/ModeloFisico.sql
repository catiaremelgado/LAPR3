create table Tipo_Cliente (
      ID_TpClt_pk               number(10) ,
      designacao_TpClt          varchar2(255) not null,
      primary key (ID_TpClt_pk),
      constraint CHK_Desigancao_TpClt CHECK (designacao_TpClt like 'Empresa' OR designacao_TpClt like 'Particular'));


create table Tipo_Edificio (
      ID_TpEd_pk                number(10) ,
      nome_TpEd                 varchar2(255) not null,
      primary key (ID_TpEd_pk));


create table Edificio (
      ID_Ed_pk                  number(10) ,
      ID_TpEd_fk                number(10) not null,
      primary key (ID_Ed_pk),
      constraint FK_Edificio_TipoEdificio foreign key (ID_TpEd_fk) references Tipo_Edificio(ID_TpEd_pk));


create table Tipo_Fator_Producao (
      ID_TpFtPrd_pk             number(10) ,
      designacao_TpFtPrd        varchar2(255) not null,
      primary key (ID_TpFtPrd_pk));


create table Tipo_Fertilizacao (
      ID_TpFert_pk              number(10) ,
      tipo_TpFert               varchar2(255) not null,
      primary key (ID_TpFert_pk));


create table Tipo_Sensor(
      ID_TpSens_pk              number(10) ,
      tipo_TpSens               nvarchar2(255) not null,
      unidade_TpSens            nvarchar2(5) not null,
      grandeza_TpSens           nvarchar2(10) not null,
      primary key (ID_TpSens_pk));


create table Tipo_Rega(
      ID_TpReg_pk               number(10) ,
      tipo_TpReg                varchar2(255) not null,
      primary key (ID_TpReg_pk));


create table Tipo_Cultura (
      ID_TpCult_pk              number(10) ,
      nome_TpCult               varchar2(255) not null,
      primary key (ID_TpCult_pk));


create table Cultura (
      ID_Cult_pk                number(10) ,
      ID_TpCult_fk              number(10) not null,
      especie_vegetal_Cult      varchar2(255) not null,
      preco_venda_Cult          number(10,2) not null,
      primary key (ID_Cult_pk),
      constraint FK_Cultura_Tipo_Cultura foreign key (ID_TpCult_fk)references Tipo_Cultura (ID_TpCult_pk),
      constraint CHK_Preco_Venda_Cult CHECK (preco_venda_Cult >= 0.01));


create table Parcela (
       ID_Prcl_pk               number(10) ,
       designacao_Prcl          varchar2(255) not null,
       area_Prcl                number(10) not null,
       primary key (ID_Prcl_pk),
       constraint CHK_Area_Prcl CHECK (area_Prcl between 1 and 10000));


create table Plantacao (
      ID_Prcl_ck                number(10) not null,
      ID_Cult_ck                number(10) not null,
      data_Plant_ck             date not null,
      data_dest_Plant           date,
      area_Plant                number(10) not null,
      primary key (ID_Prcl_ck,ID_Cult_ck,data_Plant_ck),
      constraint FK_Plantacao_Cultura foreign key (ID_Cult_ck) references Cultura (ID_Cult_pk),
      constraint FK_Plantacao_Parcela foreign key (ID_Prcl_ck) references Parcela (ID_Prcl_pk),
      constraint CHK_Data_Plant CHECK (data_Plant_ck >= date '2007-01-01'),
      constraint CHK_Area_Plant CHECK (area_Plant between 1 and 10000));


create table Plano_Rega(
      ID_Prcl_ck                number(10) not null,
      ID_Cult_ck                number(10) not null,
      data_Plant_ck             date not null,
      ID_TpReg_fk               number(10) not null,
      tempo_rega_PlnReg         number(10) not null,
      quantidade_PlnReg         number(10) not null,
      periocidade_PlnReg        number(10) not null,
      primary key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
      constraint FK_Plano_Rega_Tipo_Rega foreign key (ID_TpReg_fk) references Tipo_Rega (ID_TpReg_pk),
      constraint FK_Plano_Rega_Plantacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
      constraint CHK_Tempo_PlnReg CHECK (tempo_rega_PlnReg >= 1),
      constraint CHK_Quantidade_PlnReg CHECK (quantidade_PlnReg >= 1),
      constraint CHK_Periocidade_PlnReg CHECK (periocidade_PlnReg >= 1));


create table Registo_Rega(
      ID_Prcl_ck                number(10) not null,
      ID_Cult_ck                number(10) not null,
      data_Plant_ck             date not null,
      data_hora_RgtReg_ck       date not null,
      quantidade_RgtReg         number(10) not null,
      ID_TpReg_fk               number(10) not null,
      primary key (ID_Prcl_ck, data_hora_RgtReg_ck),
      constraint FK_Registo_Tipo_Rega foreign key (ID_TpReg_fk) references Tipo_Rega (ID_TpReg_pk),
      constraint FK_Registo_Rega_Plantacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
      constraint CHK_Quantidade_RgtReg CHECK (quantidade_RgtReg >= 1),
      constraint CHK_Data_Hora_RgtReg CHECK (data_hora_RgtReg_ck >= date '2007-01-01'));


create table Registo_Colheita (
      ID_Prcl_ck                number(10) not null,
      ID_Cult_ck                number(10) not null,
      data_Plant_ck             date not null,
      data_colh_RgtColh_ck      date not null,
      quantidade_RgtColh        number(10),
      primary key (ID_Prcl_ck,ID_Cult_ck,data_Plant_ck,data_colh_RgtColh_ck),
      constraint FK_Registo_Colheita_Plantacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
      constraint CHK_Quantidade_RgtColh CHECK (quantidade_RgtColh between 1 and 50000));


create table Sensor(
       ID_Sens_pk               number(10) ,
       ID_TpSens_fk             number(10) not null,
       primary key (ID_Sens_pk),
       constraint FK_Sensor_Tipo_Sensor foreign key (ID_TpSens_fk) references Tipo_Sensor (ID_TpSens_pk));


create table Registo_Sensor(
      ID_Prcl_ck                number(10) not null,
      ID_Cult_ck                number(10) not null,
      data_Plant_ck             date not null,
      ID_Sens_ck                number(10) not null,
      data_capturado_RgtSens_ck date not null,
      valor_capturado_RgtSens   number(10) not null,
      primary key (ID_Sens_ck, ID_Prcl_ck),
      constraint FK_Registo_Sensor_Sensor foreign key (ID_Sens_ck) references Sensor (ID_Sens_pk),
      constraint FK_Registo_Sensor_Plantacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
      constraint CHK_Data_Capturado_RgtSens CHECK (data_capturado_RgtSens_ck >= date '2007-01-01'));


create table Fator_Producao (
      ID_FtPrd_pk             number(10) ,
      preco_FtPrd             number(10,2) not null,
      fornecedor_FtPrd              varchar2(255) not null,
      nome_comercial_FtPrd    varchar2(255) not null,
      primary key (ID_FtPrd_pk),
      constraint CHK_Preco_FtPrd CHECK (preco_FtPrd > 0.00));


create table Ficha_Tecnica_Producao (
    ID_FTFtPrd_pk             number(10),
    ID_TpFtPrd_fk             number(10) not null,
    ID_FtPrd_fk               number(10),
    tipo_FTFtPrd              varchar2(255) not null,
    valor_FTFtPrd             number(10,2) not null,
    unidade_FTFtPrd           varchar2(255) not null,
    primary key (ID_FTFtPrd_pk),
    constraint FK_Ficha_Tecnica_Tipo_Fator_Producao foreign key (ID_TpFtPrd_fk) references Tipo_Fator_Producao (ID_TpFtPrd_pk),
    constraint FK_Fator_Producao foreign key (ID_FtPrd_fk) references Fator_Producao (ID_FtPrd_pk),
    constraint CHK_Valor_FTFPrd CHECK (valor_FTFtPrd >= 0.00));


create table Plano_Fertilizacao (
  ID_Prcl_ck                  number(10) not null,
  ID_Cult_ck                  number(10) not null,
  ID_FtPrd_ck                 number(10) not null,
  data_Plant_ck               date not null,
  data_inicial_PlnFert_ck     date not null,
  data_final_PlnFert_ck       date not null,
  ID_TpFert_fk                number(10) not null,
  quantidade_PlnFert          number(10) not null,
  primary key (ID_Prcl_ck,ID_Cult_ck,ID_FtPrd_ck,data_Plant_ck,data_inicial_PlnFert_ck,data_final_PlnFert_ck),
  constraint FK_Plano_Fertilizacao_Plantacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
  constraint FK_Plano_Fertilizacao_Fator_Producao foreign key (ID_FtPrd_ck) references Fator_Producao (ID_FtPrd_pk),
  constraint FK_Plano_Fertilizacao_Tipo_Fertilizacao foreign key (ID_TpFert_fk) references Tipo_Fertilizacao (ID_TpFert_pk),
  constraint CHK_Inicial_PlnFert CHECK (data_inicial_PlnFert_ck >= date '2007-01-01'),
  constraint CHK_Final_PlnFert CHECK (data_final_PlnFert_ck <= date '2037-01-01'),
  constraint CHK_Data_Inicial_PlnFert CHECK (data_inicial_PlnFert_ck <= data_final_PlnFert_ck),
  constraint CHK_Quantidade_PlnFert CHECK (quantidade_PlnFert >= 1));


create table Registo_Fertilizacao (
  ID_Prcl_ck                  number(10) not null,
  ID_Cult_ck                  number(10) not null,
  data_Plant_ck               date not null,
  ID_FtPrd_ck                 number(10) not null,
  data_hora_RgtFert_ck        date not null,
  ID_TpFert_fk                number(10) not null,
  quantidade_RgtFert          number(10) not null,
  primary key (ID_Prcl_ck,ID_Cult_ck,data_Plant_ck,ID_FtPrd_ck,data_hora_RgtFert_ck),
  constraint FK_Registo_Fertilizacao_Plantacao foreign key (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck) references Plantacao (ID_Prcl_ck, ID_Cult_ck, data_Plant_ck),
  constraint FK_Registo_Fertilizacao_Fator_Producao foreign key (ID_FtPrd_ck) references Fator_Producao (ID_FtPrd_pk),
  constraint FK_Registo_Fertilizacao_Tipo_Fertilizacao foreign key (ID_TpFert_fk) references Tipo_Fertilizacao (ID_TpFert_pk),
  constraint CHK_Data_Hora_RgtFert CHECK (data_hora_RgtFert_ck >= date '2007-01-01'),
  constraint CHK_Quantidade_RgtFert CHECK (quantidade_RgtFert > 0));


create table Nivel (
  ID_Niv_pk                   number(10),
  nivel_Niv                   varchar2(255) not null,
  primary key (ID_Niv_pk));


create table Cliente (
  codigo_interno_Clt_pk                 number(10) ,
  ID_TpClt_fk                           number(10) not null,
  nome_Clt                              varchar2(255) not null,
  numero_fiscal_Clt_u                   number(9) not null unique,
  email_Clt_u                           varchar2(255) not null unique,
  plafond_Clt                           number(20,2) not null,
  num_encomendas_ult12meses_Clt         number(10) not null,
  valor_total_encomendas_ult12meses_Clt number(10) not null,
  ID_Niv_fk                             number(10),
  primary key (codigo_interno_Clt_pk),
  constraint FK_Cliente_Nivel foreign key (ID_Niv_fk) references Nivel (ID_Niv_pk),
  constraint FK_Cliente_Tipo_Cliente foreign key (ID_TpClt_fk) references Tipo_Cliente (ID_TpClt_pk),
  constraint CHK_Nome_Clt  CHECK (nome_Clt like '%__%'),
  constraint CHK_Numero_Fiscal_Clt CHECK (numero_fiscal_Clt_u >= 100000000),
  constraint CHK_Email_Clt  CHECK (email_Clt_u like '%___@___%.__%'),
  constraint CHK_Plafond_Clt CHECK (plafond_Clt >= 1),
  constraint CHK_num_encomendas_ult12meses_Clt CHECK (num_encomendas_ult12meses_Clt >= 0),
  constraint CHK_valor_total_encomendas_ult12meses_Clt CHECK (valor_total_encomendas_ult12meses_Clt >= 0));


create table Morada (
  ID_Morada_pk                          number(7),
  codigo_interno_Clt_fk                 number(10) not null,
  morada_Mor                            varchar2(255) not null,
  fiscal_Mor                            number(1) not null,
  primary key (ID_Morada_pk),
  constraint FK_Morada_Cliente foreign key (codigo_interno_Clt_fk) references Cliente (codigo_interno_Clt_pk),
  constraint CHK_Fiscal CHECK (fiscal_Mor = 1 OR fiscal_Mor = 0));


create table Estado_Encomenda (
  ID_EstEnc_pk       number(10) ,
  nome_estado_EstEnc varchar2(255) not null,
  primary key (ID_EstEnc_pk));


create table Encomenda (
  ID_Enc_pk                             number(10) ,
  ID_EstEnc_fk                          number(10) not null,
  codigo_interno_Clt_fk                 number(10) not null,
  ID_Morada_fk                          number(10) not null,
  data_pedido_Enc                       date not null,
  data_entrega_Enc                      date,
  data_limite_pagamento_Enc             date not null,
  data_pagamento_pelo_cliente_Enc       date,
  primary key (ID_Enc_pk),
  constraint FK_Encomenda_Cliente foreign key (codigo_interno_Clt_fk) references Cliente (codigo_interno_Clt_pk),
  constraint FK_Encomenda_Estado_Encomenda foreign key (ID_EstEnc_fk) references Estado_Encomenda (ID_EstEnc_pk),
  constraint FK_Encomenda_Morada foreign key (ID_Morada_fk) references Morada(ID_Morada_pk),
  constraint CHK_Data_Pedido_Enc CHECK (data_pedido_Enc >= date '2007-01-01'),
  constraint CHK_Data_Entrega_Enc CHECK (data_entrega_Enc >= data_pedido_Enc),
  constraint CHK_Data_Limite_Pagamento_Enc CHECK (data_limite_pagamento_Enc <= data_entrega_Enc),
  constraint CHK_Data_Pagamento_Pelo_Cliente_Enc CHECK (data_pagamento_pelo_cliente_Enc >= data_pedido_Enc));


create table Item_Encomenda (
  ID_Enc_ck                             number(10) not null,
  ID_Cult_ck                            number(10) not null,
  quantidade_encomendada_ItmEnc         number(10) not null,
  preco_unitario_ItmEnc                 number(10,2) not null,
  nome_produto_ItmEnc                   varchar2(255) not null,
  primary key (ID_Enc_ck,
  ID_Cult_ck),
  constraint FK_Item_Encomenda_Encomenda foreign key (ID_Enc_ck) references Encomenda (ID_Enc_pk),
  constraint FK_Item_Encomenda_Cultura foreign key (ID_Cult_ck) references Cultura (ID_Cult_pk),
  constraint CHK_Quantidade_Encomendada_ItmEnc CHECK (quantidade_encomendada_ItmEnc between 1 and 10000));


create table Incidente (
  ID_Enc_pk                             number(10) not null,
  codigo_interno_Clt_fk                 number(10) not null,
  data_sanado_Inci                      date not null,
  primary key (ID_Enc_pk),
  constraint FK_Incidente_Encomenda foreign key (ID_Enc_pk) references Encomenda (ID_Enc_pk),
  constraint FK_Incidente_Cliente foreign key (codigo_interno_Clt_fk) references Cliente (codigo_interno_Clt_pk));


-- Drop Tables --
drop table Ficha_Tecnica_Producao cascade constraints;
drop table Cliente cascade constraints;
drop table Cultura cascade constraints;
drop table Edificio cascade constraints;
drop table Encomenda cascade constraints;
drop table Estado_Encomenda cascade constraints;
drop table Fator_Producao cascade constraints;
drop table Incidente cascade constraints;
drop table Item_Encomenda cascade constraints;
drop table Nivel cascade constraints;
drop table Parcela cascade constraints;
drop table Plano_Fertilizacao cascade constraints;
drop table Plano_Rega cascade constraints;
drop table Plantacao cascade constraints;
drop table Registo_Colheita cascade constraints;
drop table Registo_Fertilizacao cascade constraints;
drop table Registo_Rega cascade constraints;
drop table Registo_Sensor cascade constraints;
drop table Sensor cascade constraints;
drop table Tipo_Cliente cascade constraints;
drop table Tipo_Cultura cascade constraints;
drop table Tipo_Edificio cascade constraints;
drop table Tipo_Fator_Producao cascade constraints;
drop table Tipo_Fertilizacao cascade constraints;
drop table Tipo_Rega cascade constraints;
drop table Tipo_Sensor cascade constraints;
drop table Morada cascade constraints;






