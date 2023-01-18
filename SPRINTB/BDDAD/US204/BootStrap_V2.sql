insert into input_hub values('CT1,40.6389,-8.6553,C1');
insert into input_hub values('CT2,38.0333,-7.8833,C2');
insert into input_hub values('CT3,41.5333,-8.4167,E1');
insert into input_hub values('CT4,41.8000,-6.7500,E2');
insert into input_hub values('CT5,39.823,-7.4931,P3');

insert into input_Sensor values('00001HS020015200520121310');
insert into input_Sensor values('00002Pl020015200520121310');
insert into input_Sensor values('00003TS020015200520121310');
insert into input_Sensor values('00004VV020015200520121310');
insert into input_Sensor values('00005TA020015200520121310');
insert into input_Sensor values('00006HA020015200520121310');
insert into input_Sensor values('00007PA020015200520121310');

insert into Tipo_Cliente values (1, 'Particular');
insert into Tipo_Cliente values (2, 'Empresa');

insert into Tipo_Cultura values (1,'Permanente');
insert into Tipo_Cultura values (2,'Temporária');

insert into Tipo_Edificio values (1,'Estábulos');
insert into Tipo_Edificio values (2,'Garagens');
insert into Tipo_Edificio values (3,'Alfaias');
insert into Tipo_Edificio values (4,'Armazéns de Factores de produção');
insert into Tipo_Edificio values (5,'Armazéns de colheitas');
insert into Tipo_Edificio values (6,'Armazéns de Rações para animais');
insert into Tipo_Edificio values (7,'Sistemas de Rega');

insert into Tipo_Fator_Producao values (1,'Fertilizante');
insert into Tipo_Fator_Producao values (2,'Adubo');
insert into Tipo_Fator_Producao values (3,'Corretivo');
insert into Tipo_Fator_Producao values (4,'Produto fitofármaco');

insert into Tipo_Fertilizacao values (1,'Foliar');
insert into Tipo_Fertilizacao values (2,'Fertirrega');
insert into Tipo_Fertilizacao values (3,'Aplicação direta');

insert into Tipo_Rega values(1,'Gravidade');
insert into Tipo_Rega values(2,'Bombeada');
insert into Tipo_Rega values(3,'Aspersão');
insert into Tipo_Rega values(4,'Gotejamento');
insert into Tipo_Rega values(5,'Pulverização');

insert into Tipo_Sensor values(1,'Sensor de pluviosidade','mm', 0.50);
insert into Tipo_Sensor values(2,'Sensor de temperatura do solo', 'ºC', 0.50);
insert into Tipo_Sensor values(3,'Sensor de humidade do solo', '%', 0.50);
insert into Tipo_Sensor values(4,'Sensor de velocidade do vento', 'km/h', 0.50);
insert into Tipo_Sensor values(5,'Sensor de pressão atmosférica', 'hPa', 0.50);

insert into Estado_Encomenda values (1, 'Em pagamento');
insert into Estado_Encomenda values (2, 'A preparar');
insert into Estado_Encomenda values (3, 'A enviar');
insert into Estado_Encomenda values (4, 'A ser entregue');
insert into Estado_Encomenda values (5, 'Entregue');

insert into Hub values('CT1', 40.6389, -8.6553);
insert into Hub values('CT2', 38.0333, -7.8833);
insert into Hub values('CT3', 41.5333, -8.4167);
insert into Hub values('CT4', 41.8, -6.75);
insert into Hub values('CT5', 39.823, -7.4931);

insert into Nivel values (1, 'Nivel A');
insert into Nivel values (2, 'Nivel B');
insert into Nivel values (3, 'Nivel C');
insert into Nivel values (4, 'Sem nivel');

insert into Parcela values (1,'Parcela de cima do andre',20);
insert into Parcela values (2,'Parcela de baixo do andre',25);
insert into Parcela values (3,'Parcela do meio do andre',30);
insert into Parcela values (4,'Parcela do Joao',18);
insert into Parcela values (5,'Parcela do Tozé', 50);
insert into Parcela values (6,'Parcela do António', 40);
insert into Parcela values (7,'Parcela da Joana', 40);
insert into Parcela values (8,'Parcela do Márcio', 30);
insert into Parcela values (9,'Parcela do Manuel', 40);
insert into Parcela values (10,'Parcela do Duarte', 80);
insert into Parcela values (11,'Parcela do Miguel', 10);
insert into Parcela values (12,'Parcela do Pedro', 20);

insert into Cultura values (1,1,'Pereiras');
insert into Cultura values (2,1,'Macieiras');
insert into Cultura values (3,2,'Cebolinha');
insert into Cultura values (4,2,'Espinafre');
insert into Cultura values (5,2,'Alface');
insert into Cultura values (6,2,'Couve');
insert into Cultura values (7,2,'Tomate');
insert into Cultura values (8,2,'Pepino');
insert into Cultura values (9,2,'Cenoura');
insert into Cultura values (10,2,'Batata');
insert into Cultura values (11,2,'Pimento');
insert into Cultura values (12,2,'Cebola');

insert into Plantacao values (1,1,TO_DATE('20/04/2012', 'dd/mm/yyyy'),TO_DATE('20/04/2013','dd/mm/yyyy'),20);
insert into Plantacao values (2,2,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_DATE('21/04/2014','dd/mm/yyyy'),25);
insert into Plantacao values (3,3,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('22/4/2015','dd/mm/yyyy'),30);
insert into Plantacao values (4,4,TO_DATE('23/07/2015','dd/mm/yyyy'),TO_DATE('23/4/2016','dd/mm/yyyy'),18);
insert into Plantacao values (5,5,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('05/04/2016','dd/mm/yyyy'), 18);
insert into Plantacao values (6,6,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('05/04/2016','dd/mm/yyyy'), 50);
insert into Plantacao values (7,7,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('05/04/2016','dd/mm/yyyy'), 50);
insert into Plantacao values (8,8,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('05/04/2016','dd/mm/yyyy'), 50);
insert into Plantacao values (9,9,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('05/04/2016','dd/mm/yyyy'), 50);
insert into Plantacao values (10,10,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('05/04/2016','dd/mm/yyyy'), 50);
insert into Plantacao values (11,11,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('05/04/2016','dd/mm/yyyy'), 50);
insert into Plantacao values (12,12,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('05/04/2016','dd/mm/yyyy'), 50);

insert into Operacao values(1,1,TO_DATE('20/04/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('20-05-2012 13:10', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('20-05-2012 13:40', 'dd-mm-yyyy hh24:mi'), 'Colheita');
insert into Operacao values(2,2,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('22-06-2013 09:20', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('23-06-2013 09:20', 'dd-mm-yyyy hh24:mi'), 'Colheita');
insert into Operacao values(3,3,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('23-07-2014 14:30', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('24-07-2014 12:30', 'dd-mm-yyyy hh24:mi'), 'Colheita');
insert into Operacao values(4,4,TO_DATE('23/07/2015','dd/mm/yyyy'),TO_TIMESTAMP('15-08-2015 10:40', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('16-08-2015 10:40', 'dd-mm-yyyy hh24:mi'), 'Colheita');
insert into Operacao values(5,5,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('20-08-2014 12:10', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('21-08-2014 13:10', 'dd-mm-yyyy hh24:mi'), 'Fertilização');
insert into Operacao values(6,6,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('20-05-2016 13:10', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('20-05-2016 13:40', 'dd-mm-yyyy hh24:mi'), 'Fertilização');
insert into Operacao values(7,7,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('22-06-2016 09:20', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('23-06-2016 09:20', 'dd-mm-yyyy hh24:mi'), 'Fertilização');
insert into Operacao values(8,8,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('23-07-2016 14:30', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('24-07-2016 12:30', 'dd-mm-yyyy hh24:mi'), 'Fertilização');
insert into Operacao values(9,9,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('15-08-2016 10:40', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('16-08-2016 10:40', 'dd-mm-yyyy hh24:mi'), 'Rega');
insert into Operacao values(10,10,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('20-08-2016 12:10', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('21-08-2016 13:10', 'dd-mm-yyyy hh24:mi'), 'Rega');
insert into Operacao values(11,11,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('20-05-2016 13:10', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('20-05-2016 13:40', 'dd-mm-yyyy hh24:mi'), 'Rega');
insert into Operacao values(12,12,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('22-06-2016 09:20', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('23-06-2016 09:20', 'dd-mm-yyyy hh24:mi'), 'Rega');

insert into Sensor values (1, 1);
insert into Sensor values (2, 1);
insert into Sensor values (3, 1);
insert into Sensor values (4, 2);
insert into Sensor values (5, 2);
insert into Sensor values (6, 2);
insert into Sensor values (7, 3);
insert into Sensor values (8, 3);
insert into Sensor values (9, 3);
insert into Sensor values (10,4);
insert into Sensor values (11,4);
insert into Sensor values (12,4);
insert into Sensor values (13,5);
insert into Sensor values (14,5);
insert into Sensor values (15,5);

insert into Edificio values (1,1);
insert into Edificio values (2,2);
insert into Edificio values (3,3);
insert into Edificio values (4,4);
insert into Edificio values (5,5);
insert into Edificio values (6,6);
insert into Edificio values (7,7);

--Particular
insert into Cliente values (1, 1, 1, 'CT1', 'Manuel Guerra', 123456789, 'manuelguerra@gmail.com', 1000, 2, 10230);
insert into Cliente values (2, 1, 1, 'CT2', 'Joaquim Almeida',101112131, 'joaquimalmeida@gmail.com', 1300, 3, 14500);
insert into Cliente values (3, 1, 2, 'CT3', 'Catarina Pereira',987654321, 'catarinaPereira@gmail.com', 1200, 1, 4000);
insert into Cliente values (4, 1, 4, 'CT4', 'Beatriz Rodrigues', 154277382, 'beatrizrodrigues@gmail.com', 890, 4, 3560);
--Empresa
insert into Cliente values (5, 2, 1, 'CT5', 'Manuel Andrade', 123459789, 'manuelandrade@gmail.com', 10000, 10, 123456);
insert into Cliente values (6, 2, 1, 'CT1', 'Ana Ribeiro', 123459589, 'anaribeiro@gmail.com', 12000, 11, 133456);
insert into Cliente values (7, 2, 1, 'CT3', 'Maria Castro', 156725382, 'mariacastro@gmail.com', 12345, 50, 1234567);
insert into Cliente values (8, 2, 1, 'CT2', 'Eduarda Castro', 964567892, 'eduardacastro@gmail.com', 120345, 50, 1234567);

/*insert into Operacao_log values (1,1,1,TO_DATE('20/04/2012', 'dd/mm/yyyy'),TO_DATE('20/05/2012', 'dd/mm/yyyy'),10,1,TO_TIMESTAMP('20-06-2012 13:10', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('20-06-2012 13:40', 'dd-mm-yyyy hh24:mi'),100,120,1);
insert into Operacao_log values (2,2,2,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_DATE('22/05/2013', 'dd/mm/yyyy'),20,2,TO_TIMESTAMP('22-06-2013 09:20', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('23-06-2013 09:20', 'dd-mm-yyyy hh24:mi'),210,160,2);
insert into Operacao_log values (3,3,3,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('23/06/2014', 'dd/mm/yyyy'),30,3,TO_TIMESTAMP('23-07-2014 14:30', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('24-07-2014 12:30', 'dd-mm-yyyy hh24:mi'),300,305,3);
insert into Operacao_log values (4,4,4,TO_DATE('23/07/2015','dd/mm/yyyy'),TO_DATE('24/07/2015', 'dd/mm/yyyy'),40,4,TO_TIMESTAMP('15-08-2015 10:40', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('16-08-2015 10:40', 'dd-mm-yyyy hh24:mi'),210,300,4);

insert into Colheita_log values (1);
insert into Colheita_log values (2);
insert into Colheita_log values (3);
insert into Colheita_log values (4);


insert into Fertilizacao_Log values(1,1,2);
insert into Fertilizacao_Log values(2,2,1);
insert into Fertilizacao_Log values(3,3,2);
insert into Fertilizacao_Log values(4,1,3);


insert into rega_log values (1,1,2);
insert into rega_log values (2,2,1);
insert into rega_log values (3,3,4);
insert into rega_log values (4,4,5);*/


insert into Encomenda values (1, 1, 1, 'CT1', TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_DATE('25/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('21/04/2012', 'dd/mm/yyyy'));
insert into Encomenda values (2, 2, 2, 'CT2', TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_DATE('26/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('20/04/2012', 'dd/mm/yyyy'));
insert into Encomenda values (3, 3, 3, 'CT3', TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'));
insert into Encomenda values (4, 4, 4, 'CT4', TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'));
insert into Encomenda values (6, 5, 3, 'CT1', TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'));
insert into Encomenda values (7, 6, 4, 'CT3', TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'));
insert into Encomenda values (8, 7, 1, 'CT5', TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'));
insert into Encomenda values (10, 8, 1, 'CT2', TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('23/08/2012', 'dd/mm/yyyy'));

insert into Fator_Producao values(1, 2, 3.99,'Atlus','Guanito');
insert into Fator_Producao values(2, 1, 2.99, 'Atlus', 'Siru');
insert into Fator_Producao values(3, 3, 1.99, 'Natura','Compo');
insert into Fator_Producao values(4, 4, 4.99, 'Greenie', 'Geolia');

insert into Ficha_Tecnica_Producao values (1,1,'Azoto',40.00,'%');
insert into Ficha_Tecnica_Producao values (2,1,'Carbono de Origem Biologica',60.00,'%');
insert into Ficha_Tecnica_Producao values (3,1,'Peso',40.00,'kg');
insert into Ficha_Tecnica_Producao values (4,1,'Valor ph',2.60,'ph');
insert into Ficha_Tecnica_Producao values (5,2,'Carbono de Origem Biologica',35.60,'%');
insert into Ficha_Tecnica_Producao values (6,2,'Materia organica',64.40,'%');
insert into Ficha_Tecnica_Producao values (7,2,'Peso',50.00,'kg');
insert into Ficha_Tecnica_Producao values (8,1,'Acidos humicos',40.00,'%');
insert into Ficha_Tecnica_Producao values (9,3,'Materia organica',60.00,'%');
insert into Ficha_Tecnica_Producao values (10,3,'Peso',60.00,'kg');
insert into Ficha_Tecnica_Producao values (11,3,'Valor ph',4.00,'ph');
insert into Ficha_Tecnica_Producao values (12,4,'Materia organica',100,'%');
insert into Ficha_Tecnica_Producao values (13,4,'Peso',30,'kg');

insert into Incidente values (1, 1, TO_DATE('30/04/2012','dd/mm/yyyy'), TO_DATE('10/05/2012','dd/mm/yyyy'));
insert into Incidente values (2, 2, TO_DATE('10/05/2012','dd/mm/yyyy'), TO_DATE('20/05/2012','dd/mm/yyyy'));
insert into Incidente values (3, 3, TO_DATE('05/05/2012','dd/mm/yyyy'), TO_DATE('15/05/2012','dd/mm/yyyy'));
insert into Incidente values (4, 4, TO_DATE('01/05/2012','dd/mm/yyyy'), TO_DATE('10/05/2012','dd/mm/yyyy'));

insert into Registo_Colheita values (1,1,TO_DATE('20/04/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('20-05-2012 13:10', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('20-05-2012 13:40', 'dd-mm-yyyy hh24:mi'),20);
insert into Registo_Colheita values (2,2,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('22-06-2013 09:20', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('23-10-2013 12:10', 'dd-mm-yyyy hh24:mi'),25);
insert into Registo_Colheita values (3,3,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('23-07-2014 14:30', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('23-08-2014 08:20', 'dd-mm-yyyy hh24:mi'),30);
insert into Registo_Colheita values (4,4,TO_DATE('23/07/2015','dd/mm/yyyy'),TO_TIMESTAMP('15-08-2015 10:40', 'dd-mm-yyyy hh24:mi'),TO_TIMESTAMP('23-08-2015 09:30', 'dd-mm-yyyy hh24:mi'),18);

insert into Produto values(1,1,TO_DATE('20/04/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('20-05-2012 13:10', 'dd-mm-yyyy hh24:mi'),3);
insert into Produto values(2,2,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('22-06-2013 09:20', 'dd-mm-yyyy hh24:mi'),5);
insert into Produto values(3,3,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('23-07-2014 14:30', 'dd-mm-yyyy hh24:mi'),2);
insert into Produto values(4,4,TO_DATE('23/07/2015','dd/mm/yyyy'),TO_TIMESTAMP('15-08-2015 10:40', 'dd-mm-yyyy hh24:mi'),6);

insert into Item_Encomenda values (1,1,1,TO_DATE('20/04/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('20-05-2012 13:10', 'dd-mm-yyyy hh24:mi'),50, 3.99, 'Pereiras');
insert into Item_Encomenda values (2,2,2,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('22-06-2013 09:20', 'dd-mm-yyyy hh24:mi'),80, 2.99, 'Macieiras');
insert into Item_Encomenda values (3,3,3,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('23-07-2014 14:30', 'dd-mm-yyyy hh24:mi'),70, 1.99, 'Cebolinha');
insert into Item_Encomenda values (4,4,4,TO_DATE('23/07/2015','dd/mm/yyyy'),TO_TIMESTAMP('15-08-2015 10:40', 'dd-mm-yyyy hh24:mi'),40, 0.99, 'Espinafre');
insert into Item_Encomenda values (6,2,2,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('22-06-2013 09:20', 'dd-mm-yyyy hh24:mi'),80, 2.99, 'Macieiras');
insert into Item_Encomenda values (7,3,3,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('23-07-2014 14:30', 'dd-mm-yyyy hh24:mi'),70, 1.99, 'Cebolinha');
insert into Item_Encomenda values (8,4,4,TO_DATE('23/07/2015','dd/mm/yyyy'),TO_TIMESTAMP('15-08-2015 10:40', 'dd-mm-yyyy hh24:mi'),40, 0.99, 'Espinafre');

insert into Morada values (1, 1,'Rua Dr. Manuel, 234', 0);
insert into Morada values (2, 2,'Rua José António, 120', 1);
insert into Morada values (3, 3,'Rua 2, 100', 0);
insert into Morada values (4, 4,'Rua 10, 300', 1);
insert into Morada values (5, 5,'Rua Henrique Guimarães, 90', 1);
insert into Morada values (6, 6,'Rua António Manuel, 500', 0);
insert into Morada values (7, 7,'Rua Faria Guimarães, 256', 1);
insert into Morada values (8, 8,'Rua Marquês, 145', 0);

insert into Plano_Fertilizacao values (1,1,1,TO_DATE('20/04/2012','dd/mm/yyyy'),TO_DATE('20/05/2012','dd/mm/yyyy'),TO_DATE('20/01/2013','dd/mm/yyyy'),1,10);
insert into Plano_Fertilizacao values (2,2,2,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_DATE('20/06/2012','dd/mm/yyyy'),TO_DATE('20/02/2014','dd/mm/yyyy'),1,20);
insert into Plano_Fertilizacao values (3,3,3,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('20/07/2012','dd/mm/yyyy'),TO_DATE('20/04/2015','dd/mm/yyyy'),2,30);
insert into Plano_Fertilizacao values (4,4,4,TO_DATE('23/07/2015','dd/mm/yyyy'),TO_DATE('20/08/2012','dd/mm/yyyy'),TO_DATE('20/05/2016','dd/mm/yyyy'),3,40);

insert into Plano_Rega values(1,1, TO_DATE('20/04/2012', 'dd/mm/yyyy'), 1, 20, 30, 6);
insert into Plano_Rega values(2,2, TO_DATE('21/05/2013', 'dd/mm/yyyy'), 2, 30, 50, 7);
insert into Plano_Rega values(3,3, TO_DATE('22/06/2014', 'dd/mm/yyyy'), 3, 40, 10, 10);
insert into Plano_Rega values(4,4, TO_DATE('23/07/2015', 'dd/mm/yyyy'), 4, 10, 80, 500);

insert into Registo_Fertilizacao values (5,5,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('20-08-2014 12:10', 'dd-mm-yyyy hh24:mi'),1,1,TO_TIMESTAMP('20-08-2014 13:10', 'dd-mm-yyyy hh24:mi'),10);
insert into Registo_Fertilizacao values (6,6,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('20-05-2016 13:10', 'dd-mm-yyyy hh24:mi'),1,2,TO_TIMESTAMP('20-05-2016 14:10', 'dd-mm-yyyy hh24:mi'),20);
insert into Registo_Fertilizacao values (7,7,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('22-06-2016 09:20', 'dd-mm-yyyy hh24:mi'),2,3,TO_TIMESTAMP('22-06-2016 12:10', 'dd-mm-yyyy hh24:mi'),30);
insert into Registo_Fertilizacao values (8,8,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('23-07-2016 14:30', 'dd-mm-yyyy hh24:mi'),3,1,TO_TIMESTAMP('24-07-2016 14:10', 'dd-mm-yyyy hh24:mi'),40);

insert into Registo_Rega values(9,9,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('15-08-2016 10:40', 'dd-mm-yyyy hh24:mi'),1,TO_TIMESTAMP('20-09-2016 13:40', 'dd-mm-yyyy hh24:mi'),30);
insert into Registo_Rega values(10,10,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('20-08-2016 12:10', 'dd-mm-yyyy hh24:mi'),2,TO_TIMESTAMP('23-10-2016 12:10', 'dd-mm-yyyy hh24:mi'),50);
insert into Registo_Rega values(11,11,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('20-05-2016 13:10', 'dd-mm-yyyy hh24:mi'),3,TO_TIMESTAMP('23-08-2016 08:20', 'dd-mm-yyyy hh24:mi'),10);
insert into Registo_Rega values(12,12,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_TIMESTAMP('22-06-2016 09:20', 'dd-mm-yyyy hh24:mi'),4,TO_TIMESTAMP('23-08-2016 09:30', 'dd-mm-yyyy hh24:mi'),80);

insert into Registo_Sensor values (1,1, TO_DATE('20/04/2012', 'dd/mm/yyyy'), 1, TO_DATE('21/04/2012', 'dd/mm/yyyy'), 10,10);
insert into Registo_Sensor values (2,2, TO_DATE('21/05/2013', 'dd/mm/yyyy'), 2, TO_DATE('22/05/2013', 'dd/mm/yyyy'), 20,20);
insert into Registo_Sensor values (3,3, TO_DATE('22/06/2014', 'dd/mm/yyyy'), 3, TO_DATE('23/06/2014', 'dd/mm/yyyy'), 30,25);
insert into Registo_Sensor values (4,4, TO_DATE('23/07/2015', 'dd/mm/yyyy'), 4, TO_DATE('24/07/2015', 'dd/mm/yyyy'), 40,35);

insert into Restricoes_Fator_Producao values(1,1,TO_DATE('25/04/2012', 'dd/mm/yyyy'),TO_DATE('10/04/2013','dd/mm/yyyy'));
insert into Restricoes_Fator_Producao values(2,2,TO_DATE('21/07/2013','dd/mm/yyyy'),TO_DATE('21/01/2014','dd/mm/yyyy'));
insert into Restricoes_Fator_Producao values(3,3,TO_DATE('22/10/2014','dd/mm/yyyy'),TO_DATE('10/01/2015','dd/mm/yyyy'));
insert into Restricoes_Fator_Producao values(4,4,TO_DATE('20/09/2015','dd/mm/yyyy'),TO_DATE('13/02/2016','dd/mm/yyyy'));
insert into Restricoes_Fator_Producao values(5,1,TO_DATE('22/08/2014','dd/mm/yyyy'),TO_DATE('05/02/2016','dd/mm/yyyy'));
