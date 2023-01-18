CREATE OR REPLACE PROCEDURE prc_transfer_sensor_readings (input_string in VARCHAR2)
    IS
    -- Declare variables to store the values from input_string
    nErros NUMBER := 0;
    nRegistosLidos NUMBER := 0;
    nRegistosInseridos NUMBER := 0;
    id_sensor VARCHAR2(5);
    type_sensor VARCHAR2(2);
    reference_value number(3);
    read_value number(3);
    time_reading DATE;
BEGIN
    -- Extract the values from input_string
    id_sensor := SUBSTR(input_string, 1, 5);
    type_sensor := SUBSTR(input_string, 6, 2);
    read_value := TO_NUMBER(SUBSTR(input_string, 8, 3));
    reference_value := TO_NUMBER(SUBSTR(input_string, 11, 3));
    time_reading := TO_TIMESTAMP(SUBSTR(input_string, 14), 'DD-MM-YYYY HH24:MI');
    nRegistosLidos := nRegistosLidos + 1;

    if(id_sensor is null or type_sensor is null or reference_value is null or read_value is null or time_reading is null) then
        nErros := nErros + 1;
        DBMS_OUTPUT.PUT_LINE('Não foram encontrados dados!');

    end if;

    if(NOT(type_sensor = 'HS' or type_sensor = 'Pl' or type_sensor = 'TS' or type_sensor = 'VV' or type_sensor = 'TA' or type_sensor = 'HA' or type_sensor = 'PA')) then
        DBMS_OUTPUT.PUT_LINE('Tipo de sensor inválido!');
        nErros := nErros + 1;
    end if;

    if(fnc_testar_identificador_sensor(id_sensor) = 0) then
        DBMS_OUTPUT.PUT_LINE('Identificador de sensor inválido!');
        nErros := nErros + 1;
    end if;

    if(fnc_testar_valor_referencia(reference_value) = 0) then
        DBMS_OUTPUT.PUT_LINE('Valor de referência inválido!');
        nErros := nErros + 1;
    end if;

    if(fnc_testar_valor_lido(read_value) = 0) then
        DBMS_OUTPUT.PUT_LINE('Valor lido inválido!');
        nErros := nErros + 1;
    end if;

    if(fnc_testar_instante_leitura(time_reading) = 0) then
        DBMS_OUTPUT.PUT_LINE('Data e hora inválidas!');
        nErros := nErros + 1;
    end if;

    if(nErros = 0) then
        INSERT INTO sensors (id_sensor, type_sensor, reference_value)
        VALUES (id_sensor, type_sensor, reference_value);

        -- Insert the values into the sensor_readings table
        INSERT INTO sensor_readings (id_sensor, read_value, time_reading)
        VALUES (id_sensor, read_value, time_reading);

        DELETE FROM input_sensor WHERE input_string =input_string;

        nRegistosInseridos := nRegistosInseridos + 1;
    end if;
    DBMS_OUTPUT.PUT_LINE('Foram lidos ' || nRegistosLidos || ' registos e encontrados ' || nErros || ' erros,' || 'foram inseridos ' || nRegistosInseridos || ' registos.');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

--Test
BEGIN
    prc_transfer_sensor_readings('00061HS020015200520121310');
end;