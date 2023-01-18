CREATE OR REPLACE PROCEDURE atualizar_encomendas(
id_cliente number,
num_encomendas_ult12meses_Clt number,
valor_total_encomendas_ult12meses_Clt number)
IS
encomendas NUMBER;
valor NUMBER;
BEGIN
SELECT num_encomendas_ult12meses_Clt,valor_total_encomendas_ult12meses_Clt INTO encomendas,valor FROM Cliente
WHERE CODIGO_INTERNO_CLT_PK=id_cliente;

if(num_encomendas_ult12meses_Clt is not null and valor_total_encomendas_ult12meses_Clt is not null) then
encomendas := num_encomendas_ult12meses_Clt;
valor:= valor_total_encomendas_ult12meses_Clt;
end if;

UPDATE Cliente SET num_encomendas_ult12meses_Clt=encomendas,valor_total_encomendas_ult12meses_Clt=valor WHERE id_cliente=Cliente.CODIGO_INTERNO_CLT_PK;
end;


