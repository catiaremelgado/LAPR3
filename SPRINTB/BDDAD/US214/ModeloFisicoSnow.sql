DROP TABLE Dim_Ano CASCADE CONSTRAINTS;
DROP TABLE Dim_Cliente CASCADE CONSTRAINTS;
DROP TABLE Dim_Cultura CASCADE CONSTRAINTS;
DROP TABLE Dim_Mes CASCADE CONSTRAINTS;
DROP TABLE Dim_Setor CASCADE CONSTRAINTS;
DROP TABLE Dim_Produto CASCADE CONSTRAINTS;
DROP TABLE Dim_Tempo CASCADE CONSTRAINTS;
DROP TABLE Dim_Tipo_Cultura CASCADE CONSTRAINTS;
DROP TABLE Fact_Producao CASCADE CONSTRAINTS;
DROP TABLE Fact_Venda CASCADE CONSTRAINTS;

CREATE TABLE Dim_Tipo_Cultura (
    ID_TpCult_pk number(10) NOT NULL,
    nome_TpCult varchar2(100) NOT NULL,
    PRIMARY KEY (ID_TpCult_pk),
    constraint CHK_Nome_TpClt CHECK (LENGTH(TRIM(nome_TpCult)) IS NOT NULL));

CREATE TABLE Dim_Ano (
    ID_Ano_pk number(10) NOT NULL,
    Nome_Ano number(10) NOT NULL,
    PRIMARY KEY (ID_Ano_pk),
    constraint CHK_Nome_Ano_Ano CHECK (Nome_Ano >= 2007));

CREATE TABLE Dim_Cliente (
    codigo_interno_pk number(10) NOT NULL,
    nome_Clt varchar2(100) NOT NULL,
    numero_fiscal_Clt_u number(10) NOT NULL,
    email_Clt_u varchar2(100) NOT NULL,
    PRIMARY KEY (codigo_interno_pk),
    constraint CHK_Nome_Clt  CHECK (nome_Clt like '%__%'),
    constraint CHK_Numero_Fiscal_Clt CHECK (numero_fiscal_Clt_u >= 100000000),
    constraint CHK_Email_Clt  CHECK (email_Clt_u like '%___@___%.__%'));

CREATE TABLE Dim_Cultura (
    ID_Cult_pk number(10) NOT NULL,
    ID_TpCult_fk number(10) NOT NULL,
    especie_vegetal_Cult varchar2(100) NOT NULL,
    PRIMARY KEY (ID_Cult_pk),
    CONSTRAINT FK_Cultura_Tipo_Cultura FOREIGN KEY (ID_TpCult_fk) REFERENCES Dim_Tipo_Cultura (ID_TpCult_pk),
    constraint CHK_Especie_Vegetal_Clt CHECK (LENGTH(TRIM(especie_vegetal_Cult)) IS NOT NULL));

CREATE TABLE Dim_Mes (
    ID_Mes_ck number(10) NOT NULL,
    ID_Ano_ck number(10) NOT NULL,
    Nome_Mes varchar2(10) NOT NULL,
    PRIMARY KEY (ID_Mes_ck, ID_Ano_ck),
    CONSTRAINT FK_Mes_Ano FOREIGN KEY (ID_Ano_ck) REFERENCES Dim_Ano (ID_Ano_pk),
   CONSTRAINT Nome_Mes CHECK (LOWER(Nome_Mes) like 'janeiro' OR LOWER(Nome_Mes) like 'fevereiro' OR LOWER(Nome_Mes) like 'março' OR LOWER(Nome_Mes) like 'abril' OR
                                  LOWER(Nome_Mes) like 'maio' OR LOWER(Nome_Mes) like 'junho' OR LOWER(Nome_Mes) like 'julho' OR LOWER(Nome_Mes) like 'agosto' OR
                                  LOWER(Nome_Mes) like 'setembro' OR LOWER(Nome_Mes) like 'outubro' OR LOWER(Nome_Mes) like 'novembro' OR LOWER(Nome_Mes) like 'dezembro'));

CREATE TABLE Dim_Produto (
    ID_Produto_pk number(10) NOT NULL,
    ID_Cult_fk number(10) NOT NULL,
    preco_Prod number(10,2) NOT NULL,
    PRIMARY KEY (ID_Produto_pk),
    CONSTRAINT FK_Produto_Cultura FOREIGN KEY (ID_Cult_fk) REFERENCES Dim_Cultura (ID_Cult_pk),
    constraint CHK_Preco_Prod CHECK (preco_Prod >= 0.00));

CREATE TABLE Dim_Tempo (
    ID_Tempo_pk number(10) NOT NULL,
    ID_Mes_fk number(10) NOT NULL,
    ID_Ano_fk number(10) NOT NULL,
    PRIMARY KEY (ID_Tempo_pk),
    CONSTRAINT FK_Tempo_MES_ANO FOREIGN KEY (ID_Mes_fk, ID_Ano_fk) REFERENCES Dim_Mes (ID_Mes_ck, ID_Ano_ck));

CREATE TABLE Dim_Setor (
    ID_Setor_pk number(10) NOT NULL,
    designacao_Set varchar2(250) NOT NULL,
    area_Set number(10,2) NOT NULL,
    PRIMARY KEY (ID_Setor_pk),
    constraint CHK_Designacao_Set CHECK (LENGTH(TRIM(designacao_Set)) IS NOT NULL),
    constraint CHK_Area_Set CHECK (area_Set >= 0.00));

CREATE TABLE Fact_Producao (
    ID_Produto_ck number(10) NOT NULL,
    ID_Tempo_ck number(10) NOT NULL,
    ID_Setor_ck number(10) NOT NULL,
    quantidade_Prodc number(10,2) NOT NULL,
    PRIMARY KEY (ID_Produto_ck, ID_Tempo_ck, ID_Setor_ck),
    CONSTRAINT FK_Producao_Tempo FOREIGN KEY (ID_Tempo_ck) REFERENCES Dim_Tempo (ID_Tempo_pk),
    CONSTRAINT FK_Producao_Setor FOREIGN KEY (ID_Setor_ck) REFERENCES Dim_Setor (ID_Setor_pk),
    CONSTRAINT FK_Producao_Produto FOREIGN KEY (ID_Produto_ck) REFERENCES Dim_Produto (ID_Produto_pk),
    constraint CHK_Quantidade_Prodc CHECK (quantidade_Prodc >= 0.00));

CREATE TABLE Fact_Venda (
    ID_Produto_ck number(10) NOT NULL,
    ID_Tempo_ck number(10) NOT NULL,
    codigo_interno_ck number(10) NOT NULL,
    quantidade_Vend number(10,2) NOT NULL,
    preco_vendido_Vend number(30,2) NOT NULL,
    PRIMARY KEY (ID_Produto_ck, ID_Tempo_ck, codigo_interno_ck),
    CONSTRAINT FK_Venda_Produto FOREIGN KEY (ID_Produto_ck) REFERENCES Dim_Produto (ID_Produto_pk),
    CONSTRAINT FK_Venda_Cliente FOREIGN KEY (codigo_interno_ck) REFERENCES Dim_Cliente (codigo_interno_pk),
    CONSTRAINT FK_Venda_Tempo FOREIGN KEY (ID_Tempo_ck) REFERENCES Dim_Tempo (ID_Tempo_pk),
    constraint CHK_quantidade_Vend CHECK (quantidade_Vend >= 0.00),
    constraint CHK_preco_vendido_Vend CHECK (preco_vendido_Vend >= 0.00));

