--Criar o Cliente--
create or replace function fnc_Create_Cliente(
codigo_interno_Clt_pk           number ,
ID_TpClt_fk                     number ,
nome_Clt                        varchar2 ,
numero_fiscal_Clt_u             number ,
email_Clt_u                     varchar2 ,
plafond_Clt                     number ,
num_encomendas_ult12meses_Clt         number DEFAULT 0,
valor_total_encomendas_ult12meses_Clt number DEFAULT 0,
ID_Niv_fk                      number DEFAULT 4)
return number
is
begin
if(fnc_testar_id_cliente(codigo_interno_Clt_pk) = 1 and fnc_testar_id_tipo_cliente(ID_TpClt_fk)=1
                                             and fnc_testar_nome_cliente(nome_Clt)=1 and fnc_testar_numero_fiscal_cliente(numero_fiscal_Clt_u)=1
                                             and fnc_testar_email_cliente(email_Clt_u)=1 and fnc_testar_plafond_cliente(plafond_Clt)=1
                                             and fnc_testar_numero_encomendas_ult12meses_cliente(num_encomendas_ult12meses_Clt)=1
                                             and fnc_valor_total_encomendas_ult12meses_cliente(valor_total_encomendas_ult12meses_Clt)=1
                                             and fnc_testar_id_nivel(ID_Niv_fk)=1)
then
insert into Cliente values (codigo_interno_Clt_pk ,ID_TpClt_fk ,nome_Clt ,numero_fiscal_Clt_u ,email_Clt_u ,plafond_Clt ,num_encomendas_ult12meses_Clt ,valor_total_encomendas_ult12meses_Clt ,ID_Niv_fk);
return codigo_interno_Clt_pk;
else
 DBMS_OUTPUT.PUT_LINE('O cliente não foi criado pois algum dado não cumpre as restrições de integridade.');
 RETURN 0;
end if;
end;

--passar os dados--
declare
var1 number;
begin
var1 := fnc_Create_Cliente(20, 1,'Joao', 123127456,'joao@gmail.com', 1200);
end;

--Verificar se o cliente foi criado--
select * from Cliente;



CREATE OR REPLACE FUNCTION fnc_testar_id_cliente(codigo_interno_Clt_pk NUMBER) RETURN NUMBER
    IS
    id_cliente NUMBER;
    BEGIN
    id_cliente := TO_number(codigo_interno_Clt_pk);
    if(id_cliente>0) then
        return 1;
    else
        return 0;
    end if;
    EXCEPTION
    WHEN OTHERS THEN
    return 0;
    END;

CREATE OR REPLACE FUNCTION fnc_testar_id_tipo_cliente(ID_Tipo_Cliente VARCHAR2) RETURN NUMBER
    IS
    ID_Tp_Cliente NUMBER;
    BEGIN
    ID_Tp_Cliente := TO_number(ID_Tipo_Cliente);
    if(ID_Tp_Cliente>0) then
        return 1;
    else
        return 0;
    end if;
    EXCEPTION
    WHEN OTHERS THEN
    return 0;
    END;

CREATE OR REPLACE FUNCTION fnc_testar_nome_cliente(nome_Clt VARCHAR2) RETURN NUMBER
    IS
    nome_Cliente VARCHAR2(25);
    BEGIN
    nome_Cliente := nome_Clt;
    return 1;
    EXCEPTION
    WHEN OTHERS THEN
    return 0;
    END;

CREATE OR REPLACE FUNCTION fnc_testar_numero_fiscal_cliente(numero_fiscal_Clt_u NUMBER) RETURN NUMBER
    IS
    numero_fiscal_Cliente NUMBER;
    BEGIN
    numero_fiscal_Cliente := TO_NUMBER(numero_fiscal_Clt_u);
    if(numero_fiscal_Clt_u>0) then
        return 1;
    else
        return 0;
    end if;
    EXCEPTION
    WHEN OTHERS THEN
    return 0;
    END;

CREATE OR REPLACE FUNCTION fnc_testar_email_cliente(email_Clt_u VARCHAR2) RETURN NUMBER
    IS
    email_Cliente VARCHAR2(25);
    BEGIN
    email_Cliente := email_Clt_u;
    return 1;
    EXCEPTION
    WHEN OTHERS THEN
    return 0;
    END;

CREATE OR REPLACE FUNCTION fnc_testar_plafond_cliente(plafond_Clt NUMBER) RETURN NUMBER
    IS
    plafond_Cliente NUMBER;
    BEGIN
    plafond_Cliente := TO_NUMBER(plafond_Clt);
    if(plafond_Cliente>0) then
        return 1;
    else
        return 0;
    end if;
    EXCEPTION
    WHEN OTHERS THEN
    return 0;
    END;

CREATE OR REPLACE FUNCTION fnc_testar_numero_encomendas_ult12meses_cliente(num_encomendas_ult12meses_Clt NUMBER) RETURN NUMBER
    IS
    num_encomendas_ultimos12meses_cliente NUMBER;
    BEGIN
    num_encomendas_ultimos12meses_cliente := TO_NUMBER(num_encomendas_ult12meses_Clt);
    if(num_encomendas_ultimos12meses_cliente>=0) then
        return 1;
    else
        return 0;
    end if;
    EXCEPTION
    WHEN OTHERS THEN
    return 0;
    END;

    CREATE OR REPLACE FUNCTION fnc_valor_total_encomendas_ult12meses_cliente(valor_total_encomendas_ult12meses_Clt NUMBER) RETURN NUMBER
    IS
    valor_total_encomendas_ultimos12meses_Cliente NUMBER;
    BEGIN
    valor_total_encomendas_ultimos12meses_Cliente := TO_NUMBER(valor_total_encomendas_ult12meses_Clt);
    if(valor_total_encomendas_ultimos12meses_Cliente>=0) then
        return 1;
    else
        return 0;
    end if;
    EXCEPTION
    WHEN OTHERS THEN
    return 0;
    END;

CREATE OR REPLACE FUNCTION fnc_testar_id_nivel(ID_Niv_fk NUMBER) RETURN NUMBER
    IS
    ID_Nivel NUMBER;
    BEGIN
    ID_Nivel := TO_NUMBER(ID_Niv_fk);
    if(ID_Nivel>=0) then
        return 1;
    else
        return 0;
    end if;
    EXCEPTION
    WHEN OTHERS THEN
    return 0;
    END;