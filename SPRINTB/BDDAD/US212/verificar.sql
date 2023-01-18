CREATE OR REPLACE FUNCTION fnc_testar_identificador_sensor(id_sensor VARCHAR2) RETURN NUMBER
IS
    identificador_sensor VARCHAR2(5);
    tamanho NUMBER;
BEGIN
    identificador_sensor := id_sensor;
    tamanho := LENGTH(identificador_sensor);
    if(tamanho=5) then
            return 1;
        else
            return 0;
        end if;
    EXCEPTION
    WHEN OTHERS THEN
    return 0;
END;

CREATE OR REPLACE FUNCTION fnc_testar_valor_lido(read_value NUMBER) RETURN NUMBER
IS
    valor_lido NUMBER;
BEGIN
      valor_lido := TO_number(read_value);
        if(valor_lido>0 and valor_lido<100) then
                return 1;
            else
                return 0;
            end if;
    EXCEPTION
    WHEN OTHERS THEN
    return 0;
END;

CREATE OR REPLACE FUNCTION fnc_testar_valor_referencia(reference_value NUMBER) RETURN NUMBER
IS
    valor_referencia NUMBER;
BEGIN
      valor_referencia := TO_number(reference_value);
        if(valor_referencia>0) then
                return 1;
            else
                return 0;
            end if;
    EXCEPTION
    WHEN OTHERS THEN
    return 0;
END;


CREATE OR REPLACE FUNCTION fnc_testar_instante_leitura(time_reading VARCHAR2) RETURN NUMBER
IS
    instante_leitura TIMESTAMP;
BEGIN
    instante_leitura := TO_TIMESTAMP_TZ(time_reading, 'dd-mm-yyyy hh24:mi');
    if instante_leitura IS NOT NULL THEN
        return 1;
    ELSE
        return 0;
    end if;
END;

--tests--
    SELECT fnc_testar_identificador_sensor('00011') FROM dual;
    SELECT fnc_testar_valor_lido(20) FROM dual;
    SELECT fnc_testar_valor_referencia(1) FROM dual;
    SELECT fnc_testar_instante_leitura('05-01-2023 12:34') FROM dual;