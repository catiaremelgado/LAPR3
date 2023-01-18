--criar tabela sensor_readings e sensor
CREATE TABLE sensors (
   id_sensor VARCHAR2(5) PRIMARY KEY,
   type_sensor VARCHAR(2),
   reference_value number(3));

CREATE TABLE sensor_readings (
   id_sensor VARCHAR2(5) PRIMARY KEY,
   read_value number(3),
   time_reading DATE,
   constraint FK_sensor_readings_sensor foreign key (id_sensor) references sensors (id_sensor));

create table input_sensor (
    input_string varchar2(25) not null);

insert into input_Sensor values('00001HS020015200520121310');
insert into input_Sensor values('00002Pl020015200520121310');
insert into input_Sensor values('00003TS020015200520121310');
insert into input_Sensor values('00004VV020015200520121310');
insert into input_Sensor values('00005TA020015200520121310');
insert into input_Sensor values('00006HA020015200520121310');
insert into input_Sensor values('00007PA020015200520121310');
