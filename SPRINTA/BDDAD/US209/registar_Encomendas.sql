--Registo de encomendas--
create or replace function fnc_Create_Encomenda(
ID_Enc_pk                       number ,
ID_EstEnc_fk                    number ,
codigo_interno_Clt_fk           number,
ID_Morada_fk                    number,
data_pedido_Enc                 date ,
data_entrega_Enc                date ,
data_limite_pagamento_Enc       date,
data_pagamento_pelo_cliente_Enc date,
ID_Cult_ck                      number,
quantidade_encomendada_ItmEnc   number,
preco_unitario_ItmEnc           number,
nome_produto_ItmEnc             varchar2)

return number
is
begin
if(fnc_testar_tipo_id_enc(ID_Enc_pk)=1 and fnc_testar_Est_Enc(ID_EstEnc_fk)=1 and fnc_testar_codigo_interno(codigo_interno_Clt_fk)=1 and fnc_testar_ID_Morada(ID_Morada_fk)=1 and fnc_testar_data_pedido(data_pedido_Enc)=1 and fnc_testar_data_entrega(data_entrega_Enc)=1 and fnc_testar_data_limite(data_limite_pagamento_Enc)=1 and fnc_testar_data_pagamento(data_pagamento_pelo_cliente_Enc)=1) then
    insert into Encomenda values (ID_Enc_pk,ID_EstEnc_fk,codigo_interno_Clt_fk,ID_Morada_fk,data_pedido_Enc,data_entrega_Enc,data_limite_pagamento_Enc,data_pagamento_pelo_cliente_Enc);
    insert into Item_encomenda values (ID_Enc_pk,ID_Cult_ck,quantidade_encomendada_ItmEnc,0,nome_produto_ItmEnc);
    return 1;
else return 0;
end if;
end;

--testing--
declare
var2 number;
begin
var2 := fnc_Create_Encomenda(21, 1,1, 1,TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_DATE('25/04/2012', 'dd/mm/yyyy'), TO_DATE('24/04/2012', 'dd/mm/yyyy'), TO_DATE('21/04/2012', 'dd/mm/yyyy'),1, 30, 2.90, 'Alface');
end;
--Verififcar se a encomenda foi criada em encomenda e Item_Encomenda--
select * from Encomenda where ID_Enc_pk = 21;
select * from Item_encomenda;
