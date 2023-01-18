drop table Dim_Tipo_Hub cascade constraints;
drop table Dim_Hub cascade constraints;
drop table Dim_Ano cascade constraints;
drop table Dim_Cliente cascade constraints;
drop table Dim_Cultura cascade constraints;
drop table Dim_Mes cascade constraints;
drop table Dim_Setor cascade constraints;
drop table Dim_Produto cascade constraints;
drop table Dim_Tempo cascade constraints;
drop table Dim_Tipo_Cultura cascade constraints;
drop table Fact_Producao cascade constraints;
drop table Fact_Venda cascade constraints;

-- Cria a tabela de tipo de hub
create table  Dim_Tipo_Hub (
    ID_TpHub_pk number(10) not null,
    nome_TpHub varchar2(100) not null,
    PRIMARY KEY (ID_TpHub_pk));

create table  Dim_Hub (
    ID_Hub_pk number(10) not null,
    ID_TpHub_fk number(10) not null,
    nome_Hub varchar2(100) not null,
    PRIMARY KEY (ID_Hub_pk),
    constraint  FK_Hub_Tipo_Hub foreign key (ID_TpHub_fk) references Dim_Tipo_Hub (ID_TpHub_pk));

create table  Dim_Tipo_Cultura (
    ID_TpCult_pk number(10) not null,
    nome_TpCult varchar2(100) not null,
    PRIMARY KEY (ID_TpCult_pk),
    constraint  CHK_Nome_TpClt check (LENGTH(TRIM(nome_TpCult)) IS not null));

create table  Dim_Ano (
    ID_Ano_pk number(10) not null,
    Nome_Ano number(10) not null,
    PRIMARY KEY (ID_Ano_pk),
    constraint  CHK_Nome_Ano_Ano check (Nome_Ano >= 2007));

create table  Dim_Cliente (
    codigo_interno_pk number(10) not null,
    nome_Clt varchar2(100) not null,
    numero_fiscal_Clt_u number(10) not null,
    email_Clt_u varchar2(100) not null,
    PRIMARY KEY (codigo_interno_pk),
    constraint  CHK_Nome_Clt  check (nome_Clt like '%__%'),
    constraint  CHK_Numero_Fiscal_Clt check (numero_fiscal_Clt_u >= 100000000),
    constraint  CHK_Email_Clt  check (email_Clt_u like '%___@___%.__%'));

create table  Dim_Cultura (
    ID_Cult_pk number(10) not null,
    ID_TpCult_fk number(10) not null,
    especie_vegetal_Cult varchar2(100) not null,
    PRIMARY KEY (ID_Cult_pk),
    constraint  FK_Cultura_Tipo_Cultura foreign key (ID_TpCult_fk) references Dim_Tipo_Cultura (ID_TpCult_pk),
    constraint  CHK_Especie_Vegetal_Clt check (LENGTH(TRIM(especie_vegetal_Cult)) IS not null));

create table  Dim_Mes (
    ID_Mes_ck number(10) not null,
    ID_Ano_ck number(10) not null,
    Nome_Mes varchar2(10) not null,
    PRIMARY KEY (ID_Mes_ck, ID_Ano_ck),
    constraint  FK_Mes_Ano foreign key (ID_Ano_ck) references Dim_Ano (ID_Ano_pk),
    constraint  Nome_Mes check (Nome_Mes like 'janeiro' OR Nome_Mes like 'fevereiro' OR Nome_Mes like 'março' OR Nome_Mes like 'abril' OR
                               Nome_Mes like 'maio' OR Nome_Mes like 'junho' OR Nome_Mes like 'julho' OR Nome_Mes like 'agosto' OR
                               Nome_Mes like 'setembro' OR Nome_Mes like 'outubro' OR Nome_Mes like 'novembro' OR Nome_Mes like 'dezembro'));

create table  Dim_Produto (
    ID_Produto_pk number(10) not null,
    ID_Cult_fk number(10) not null,
    preco_Prod number(10,2) not null,
    PRIMARY KEY (ID_Produto_pk),
    constraint  FK_Produto_Cultura foreign key (ID_Cult_fk) references Dim_Cultura (ID_Cult_pk),
    constraint  CHK_Preco_Prod check (preco_Prod >= 0.00));

create table  Dim_Tempo (
    ID_Tempo_pk number(10) not null,
    ID_Mes_fk number(10) not null,
    ID_Ano_fk number(10) not null,
    PRIMARY KEY (ID_Tempo_pk),
    constraint  FK_Tempo_MES_ANO foreign key (ID_Mes_fk, ID_Ano_fk) references Dim_Mes (ID_Mes_ck, ID_Ano_ck));

create table  Dim_Setor (
    ID_Setor_pk number(10) not null,
    designacao_Set varchar2(250) not null,
    area_Set number(10,2) not null,
    PRIMARY KEY (ID_Setor_pk),
    constraint  CHK_Designacao_Set check (LENGTH(TRIM(designacao_Set)) IS not null),
    constraint  CHK_Area_Set check (area_Set >= 0.00));

create table  Fact_Producao (
    ID_Produto_ck number(10) not null,
    ID_Tempo_ck number(10) not null,
    ID_Setor_ck number(10) not null,
    ID_Hub_fk number(10) not null,
    quantidade_Prodc number(10,2) not null,
    PRIMARY KEY (ID_Produto_ck, ID_Tempo_ck, ID_Setor_ck),
    constraint FK_Producao_Tempo foreign key (ID_Tempo_ck) references Dim_Tempo (ID_Tempo_pk),
    constraint FK_Producao_Setor foreign key (ID_Setor_ck) references Dim_Setor (ID_Setor_pk),
    constraint  FK_Producao_Produto foreign key (ID_Produto_ck) references Dim_Produto (ID_Produto_pk),
    constraint  FK_Fact_Producao_Hub foreign key (ID_Hub_fk) references Dim_Hub (ID_Hub_pk),
    constraint  CHK_Quantidade_Prodc check (quantidade_Prodc >= 0.00));

create table  Fact_Venda (
    ID_Produto_ck number(10) not null,
    ID_Tempo_ck number(10) not null,
    codigo_interno_ck number(10) not null,
    ID_Hub_fk number(10) not null,
    quantidade_Vend number(10,2) not null,
    preco_vendido_Vend number(10,2) not null,
    PRIMARY KEY (ID_Produto_ck, ID_Tempo_ck, codigo_interno_ck),
    constraint  FK_Venda_Produto foreign key (ID_Produto_ck) references Dim_Produto (ID_Produto_pk),
    constraint  FK_Venda_Cliente foreign key (codigo_interno_ck) references Dim_Cliente (codigo_interno_pk),
    constraint  FK_Venda_Tempo foreign key (ID_Tempo_ck) references Dim_Tempo (ID_Tempo_pk),
    constraint  FK_Fact_Venda_Hub foreign key (ID_Hub_fk) references Dim_Hub (ID_Hub_pk),
    constraint  CHK_quantidade_Vend check (quantidade_Vend >= 0.00),
    constraint  CHK_preco_vendido_Vend check (preco_vendido_Vend >= 0.00));