CREATE OR REPLACE FUNCTION fncGetNesimoElement(element NUMBER)
RETURN VARCHAR2
is
  resultado varchar2(25);
BEGIN
      SELECT input_string into resultado
      FROM (
        SELECT input_string, rownum as row_num
        FROM input_sensor
      )
      WHERE row_num = element;

      RETURN resultado;

END;

--test--
begin
    dbms_output.put_line(fncGetNesimoElement(3));
end;


 create table input_sensor (
     input_string varchar2(25) not null);

 insert into input_Sensor values('00001HS020015200520121310');
 insert into input_Sensor values('00002Pl020015200520121310');
 insert into input_Sensor values('00003TS020015200520121310');
 insert into input_Sensor values('00004VV020015200520121310');
 insert into input_Sensor values('00005TA020015200520121310');
 insert into input_Sensor values('00006HA020015200520121310');
 insert into input_Sensor values('00007PA020015200520121310');