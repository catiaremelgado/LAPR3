CREATE OR REPLACE PROCEDURE prc_update_default_hub(codigo_cliente number, ID_Hub varchar2)
is
    c number;
BEGIN
    SELECT COUNT(*) into c FROM Cliente WHERE codigo_interno_ck = codigo_cliente;

    if(c>0)then
    UPDATE Cliente
    SET ID_Hub_fk=ID_Hub
    WHERE codigo_interno_ck=codigo_cliente;
    else
      DBMS_OUTPUT.PUT_LINE('Cliente não encontrado');
    end if;
END;


--test--
    SELECT * FROM Cliente;
    exec prc_update_default_hub(1,'CT2');
    SELECT * FROM Cliente;


