--Testar se o id da encomenda é válido --
CREATE OR REPLACE FUNCTION fnc_testar_tipo_id_enc(id_Enc number) RETURN NUMBER
IS
    li_id_Enc NUMBER;
BEGIN
    li_id_Enc := id_Enc;
    if(li_id_Enc > 0) then
        return 1;
    else
        return 0;
    end if;
EXCEPTION
    WHEN OTHERS THEN
    return 0;
END;

--testar estado da encomenda--
CREATE OR REPLACE FUNCTION fnc_testar_Est_Enc(id_EstEnc number) RETURN NUMBER
IS
    li_id_EstEnc NUMBER;
BEGIN
    li_id_EstEnc := id_EstEnc;
    if(li_id_EstEnc > 0 and li_id_EstEnc < 5) then
        return 1;
    else
        return 0;
    end if;
EXCEPTION
    WHEN OTHERS THEN
    return 0;
END;

--TESTAR SE O CÓDIGO INTERNO DO CLIENTE É VÁLIDO--
CREATE OR REPLACE FUNCTION fnc_testar_codigo_interno(codigo_interno_Clt number) RETURN NUMBER
IS
    li_codigo_interno_Clt NUMBER;
BEGIN
    li_codigo_interno_Clt := TO_NUMBER(codigo_interno_Clt);
    if(li_codigo_interno_Clt > 0) then
        return 1;
    else
        return 0;
    end if;
EXCEPTION
    WHEN OTHERS THEN
    return 0;
END;

--TESTAR SE O ID DA MORADA É VÁLIDO--
CREATE OR REPLACE FUNCTION fnc_testar_id_morada(id_Morada number) RETURN NUMBER
IS
    li_id_Morada NUMBER;
BEGIN
    li_id_Morada := TO_NUMBER(id_Morada);
    if(li_id_Morada > 0) then
        return 1;
    else
        return 0;
    end if;
EXCEPTION
    WHEN OTHERS THEN
    return 0;
END;

--TESTAR SE A DATA DO PEDIDO É VÁLIDA--
CREATE OR REPLACE FUNCTION fnc_testar_data_pedido(data_pedido_Enc DATE) RETURN NUMBER
IS
    li_data_pedido_Enc DATE;
BEGIN
    li_data_pedido_Enc := TO_DATE(data_pedido_Enc);
    if(li_data_pedido_Enc > TO_DATE('01/01/2010','DD/MM/YYYY') and li_data_pedido_Enc < TO_DATE('01/01/2020','DD/MM/YYYY')) then
        return 1;
    else
        return 0;
    end if;
EXCEPTION
    WHEN OTHERS THEN
    return 0;
END;

--TESTAR SE A DATA DE ENTREGA É VÁLIDA--
CREATE OR REPLACE FUNCTION fnc_testar_data_entrega(data_entrega_Enc DATE) RETURN NUMBER
IS
    li_data_entrega_Enc DATE;
BEGIN
    li_data_entrega_Enc := TO_DATE(data_entrega_Enc);
    if(li_data_entrega_Enc > TO_DATE('01/01/2010','DD/MM/YYYY') and li_data_entrega_Enc < TO_DATE('01/01/2020','DD/MM/YYYY')) then
        return 1;
    else
        return 0;
    end if;
EXCEPTION
    WHEN OTHERS THEN
    return 0;
END;

--TESTAR SE A DATA LIMITE DE PAGAMENTO É VÁLIDA--
CREATE OR REPLACE FUNCTION fnc_testar_data_limite(data_limite_Enc DATE) RETURN NUMBER
IS
    li_data_limite_Enc DATE;
BEGIN
    li_data_limite_Enc := TO_DATE(data_limite_Enc);
    if(li_data_limite_Enc > TO_DATE('01/01/2010','DD/MM/YYYY') and li_data_limite_Enc < TO_DATE('01/01/2020','DD/MM/YYYY')) then
        return 1;
    else
        return 0;
    end if;
EXCEPTION
    WHEN OTHERS THEN
    return 0;
END;

--Testar data_pagamento
CREATE OR REPLACE FUNCTION fnc_testar_data_pagamento(data_pagamento_Enc DATE) RETURN NUMBER
IS
    li_data_pagamento_Enc DATE;
BEGIN
    li_data_pagamento_Enc := TO_DATE(data_pagamento_Enc);
    if(li_data_pagamento_Enc > TO_DATE('01/01/2010','DD/MM/YYYY') and li_data_pagamento_Enc < TO_DATE('01/01/2020','DD/MM/YYYY')) then
        return 1;
    else
        return 0;
    end if;
EXCEPTION
    WHEN OTHERS THEN
    return 0;
END;

--TESTAR SE a data_pagamento_Enc é valida--
create or replace function fnc_testar_data_pagamento_Cliente(data_pagamento_Enc DATE) RETURN NUMBER
IS
    li_data_pagamento_Enc DATE;
begin
    li_data_pagamento_Enc := TO_DATE(data_pagamento_Enc);
    if(li_data_pagamento_Enc > TO_DATE('01/01/2010','DD/MM/YYYY') and li_data_pagamento_Enc < TO_DATE('01/01/2020','DD/MM/YYYY')) then
        return 1;
    else
        return 0;
    end if;
exception
    when OTHERS then
    return 0;
end;

