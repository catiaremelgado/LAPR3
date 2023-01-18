insert into Tipo_Cliente values (1, 'Particular');
insert into Tipo_Cliente values (2, 'Empresa');

insert into Tipo_Edificio values (1,'Estábulos');
insert into Tipo_Edificio values (2,'Garagens');
insert into Tipo_Edificio values (3,'Alfaias');
insert into Tipo_Edificio values (4,'Armazéns de Factores de produção');
insert into Tipo_Edificio values (5,'Armazéns de colheitas');
insert into Tipo_Edificio values (6,'Armazéns de Rações para animais');
insert into Tipo_Edificio values (7,'Sistemas de Rega');

insert into Edificio values (1,1);
insert into Edificio values (2,2);
insert into Edificio values (3,3);
insert into Edificio values (4,4);
insert into Edificio values (5,5);
insert into Edificio values (6,6);
insert into Edificio values (7,7);

insert into Tipo_Fator_Producao values (1,'Fertilizante');
insert into Tipo_Fator_Producao values (2,'Adubo');
insert into Tipo_Fator_Producao values (3,'Corretivo');
insert into Tipo_Fator_Producao values (4,'Produto fitofármaco');

insert into Tipo_Fertilizacao values (1,'Foliar');
insert into Tipo_Fertilizacao values (2,'Fertirrega');
insert into Tipo_Fertilizacao values (3,'Aplicação direta');

insert into Tipo_Sensor values(1,'Sensor de pluviosidade','mm', 0.50);
insert into Tipo_Sensor values(2,'Sensor de temperatura do solo', 'ºC', 0.50);
insert into Tipo_Sensor values(3,'Sensor de humidade do solo', '%', 0.50);
insert into Tipo_Sensor values(4,'Sensor de velocidade do vento', 'km/h', 0.50);
insert into Tipo_Sensor values(5,'Sensor de pressão atmosférica', 'hPa', 0.50);

insert into Tipo_Rega values(1,'Gravidade');
insert into Tipo_Rega values(2,'Bombeada');
insert into Tipo_Rega values(3,'Aspersão');
insert into Tipo_Rega values(4,'Gotejamento');
insert into Tipo_Rega values(5,'Pulverização');

insert into Tipo_Cultura values (1,'Permanente');
insert into Tipo_Cultura values (2,'Temporária');

insert into Cultura values (1,1,'Pereiras', 69.99);
insert into Cultura values (2,1,'Macieiras', 60.99);
insert into Cultura values (3,2,'Cebolinha', 45.99);
insert into Cultura values (4,2,'Espinafre', 51.99);

insert into Parcela values (1,'Parcela de cima do andre',20);
insert into Parcela values (2,'Parcela de baixo do andre',25);
insert into Parcela values (3,'Parcela do meio do andre',30);
insert into Parcela values (4,'Parcela do Joao',18);
insert into Parcela values (5,'Parcela do Tozé', 50);

insert into Plantacao values (1,1,TO_DATE('20/04/2012', 'dd/mm/yyyy'),TO_DATE('20/04/2013','dd/mm/yyyy'),20);
insert into Plantacao values (2,2,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_DATE('21/04/2014','dd/mm/yyyy'),25);
insert into Plantacao values (3,3,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('22/4/2015','dd/mm/yyyy'),30);
insert into Plantacao values (4,4,TO_DATE('23/07/2015','dd/mm/yyyy'),TO_DATE('23/4/2016','dd/mm/yyyy'),18);
insert into Plantacao values (5,4,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('05/04/2016','dd/mm/yyyy'), 18);

insert into Plano_Rega values(1,1, TO_DATE('20/04/2012', 'dd/mm/yyyy'), 1, 20, 30, 10);
insert into Plano_Rega values(2,2, TO_DATE('21/05/2013', 'dd/mm/yyyy'), 2, 30, 50, 20);
insert into Plano_Rega values(3,3, TO_DATE('22/06/2014', 'dd/mm/yyyy'), 3, 40, 10, 30);
insert into Plano_Rega values(4,4, TO_DATE('23/07/2015', 'dd/mm/yyyy'), 4, 10, 80, 40);

insert into Registo_Rega values(1,1, TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_TIMESTAMP('21-04-2012 12:10', 'dd-mm-yyyy hh24:mi'), 30, 1);
insert into Registo_Rega values(2,2, TO_DATE('21/05/2013', 'dd/mm/yyyy'), TO_TIMESTAMP('22-05-2012 10:10', 'dd-mm-yyyy hh24:mi'), 50, 2);
insert into Registo_Rega values(3,3, TO_DATE('22/06/2014', 'dd/mm/yyyy'), TO_TIMESTAMP('22-05-2012 09:20', 'dd-mm-yyyy hh24:mi'), 10, 3);
insert into Registo_Rega values(4,4, TO_DATE('23/07/2015', 'dd/mm/yyyy'), TO_TIMESTAMP('22-05-2012 08:30', 'dd-mm-yyyy hh24:mi'), 80, 4);

insert into Registo_Colheita values (1,1,TO_DATE('20/04/2012','dd/mm/yyyy'),TO_DATE('10/04/2016','dd/mm/yyyy'),20);
insert into Registo_Colheita values (2,2,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_DATE('28/04/2016','dd/mm/yyyy'),25);
insert into Registo_Colheita values (3,3,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('05/04/2016','dd/mm/yyyy'),30);
insert into Registo_Colheita values (4,4,TO_DATE('23/07/2015','dd/mm/yyyy'),TO_DATE('01/05/2016','dd/mm/yyyy'),18);

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

insert into Registo_Sensor values (1,1, TO_DATE('20/04/2012', 'dd/mm/yyyy'), 1, TO_DATE('21/04/2012', 'dd/mm/yyyy'), 10);
insert into Registo_Sensor values (2,2, TO_DATE('21/05/2013', 'dd/mm/yyyy'), 2, TO_DATE('22/05/2013', 'dd/mm/yyyy'), 20);
insert into Registo_Sensor values (3,3, TO_DATE('22/06/2014', 'dd/mm/yyyy'), 3, TO_DATE('23/06/2014', 'dd/mm/yyyy'), 30);
insert into Registo_Sensor values (4,4, TO_DATE('23/07/2015', 'dd/mm/yyyy'), 4, TO_DATE('24/07/2015', 'dd/mm/yyyy'), 40);

insert into Nivel values (1, 'Nivel A');
insert into Nivel values (2, 'Nivel B');
insert into Nivel values (3, 'Nivel C');
insert into Nivel values (4, 'Sem nivel');

insert into Fator_Producao values(1, 3.99,'Atlus','Guanito');
insert into Fator_Producao values(2, 2.99, 'Atlus', 'Siru');
insert into Fator_Producao values(3, 1.99, 'Natura','Compo');
insert into Fator_Producao values(4, 4.99, 'Greenie', 'Geolia');

insert into Ficha_Tecnica_Producao values (1,1,1,'Azoto',40.00,'%');
insert into Ficha_Tecnica_Producao values (2,1,1,'Carbono de Origem Biologica',60.00,'%');
insert into Ficha_Tecnica_Producao values (3,1,1,'Peso',40.00,'kg');
insert into Ficha_Tecnica_Producao values (4,1,1,'Valor ph',2.60,'ph');
insert into Ficha_Tecnica_Producao values (5,2,2,'Carbono de Origem Biologica',35.60,'%');
insert into Ficha_Tecnica_Producao values (6,2,2,'Materia organica',64.40,'%');
insert into Ficha_Tecnica_Producao values (7,2,2,'Peso',50.00,'kg');
insert into Ficha_Tecnica_Producao values (8,1,1,'Acidos humicos',40.00,'%');
insert into Ficha_Tecnica_Producao values (9,3,3,'Materia organica',60.00,'%');
insert into Ficha_Tecnica_Producao values (10,3,3,'Peso',60.00,'kg');
insert into Ficha_Tecnica_Producao values (11,3,3,'Valor ph',4.00,'ph');
insert into Ficha_Tecnica_Producao values (12,2,4,'Materia organica',100,'%');
insert into Ficha_Tecnica_Producao values (13,2,4,'Peso',30,'kg');

insert into Plano_Fertilizacao values (1,1,1,TO_DATE('20/04/2012','dd/mm/yyyy'),TO_DATE('20/05/2012','dd/mm/yyyy'),TO_DATE('20/01/2013','dd/mm/yyyy'),1,10);
insert into Plano_Fertilizacao values (2,2,2,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_DATE('20/06/2012','dd/mm/yyyy'),TO_DATE('20/02/2014','dd/mm/yyyy'),1,20);
insert into Plano_Fertilizacao values (3,3,3,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('20/07/2012','dd/mm/yyyy'),TO_DATE('20/04/2015','dd/mm/yyyy'),2,30);
insert into Plano_Fertilizacao values (4,4,4,TO_DATE('23/07/2015','dd/mm/yyyy'),TO_DATE('20/08/2012','dd/mm/yyyy'),TO_DATE('20/05/2016','dd/mm/yyyy'),3,40);

insert into Registo_Fertilizacao values (1,1,TO_DATE('20/04/2012','dd/mm/yyyy'),1,TO_TIMESTAMP('20-12-2012 12:10', 'dd-mm-yyyy hh24:mi'),1,10);
insert into Registo_Fertilizacao values (2,2,TO_DATE('21/05/2013','dd/mm/yyyy'),2,TO_TIMESTAMP('25-01-2013 11:10', 'dd-mm-yyyy hh24:mi'),1,20);
insert into Registo_Fertilizacao values (3,3,TO_DATE('22/06/2014','dd/mm/yyyy'),3,TO_TIMESTAMP('21-02-2014 10:10', 'dd-mm-yyyy hh24:mi'),2,30);
insert into Registo_Fertilizacao values (4,4,TO_DATE('23/07/2015','dd/mm/yyyy'),4,TO_TIMESTAMP('01-03-2008 09:10', 'dd-mm-yyyy hh24:mi'),3,40);


--Particular
insert into Cliente values (1, 1, 'Manuel Guerra', 123456789, 'manuelguerra@gmail.com', 1000, 2, 10230, 1);
insert into Cliente values (2, 1, 'Joaquim Almeida',101112131, 'joaquimalmeida@gmail.com', 1300, 3, 14500, 1);
insert into Cliente values (3, 1, 'Catarina Pereira',987654321, 'catarinaPereira@gmail.com', 1200, 1, 4000, 2);
insert into Cliente values (4, 1, 'Beatriz Rodrigues', 154277382, 'beatrizrodrigues@gmail.com', 890, 4, 3560, 4);
--Empresa
insert into Cliente values (5, 2, 'Manuel Andrade', 123459789, 'manuelandrade@gmail.com', 10000, 10, 123456, 1);
insert into Cliente values (6, 2, 'Ana Ribeiro', 123459589, 'anaribeiro@gmail.com', 12000, 11, 133456, 1);
insert into Cliente values (7, 2, 'Maria Castro', 156725382, 'mariacastro@gmail.com', 12345, 50, 1234567, 1);
insert into Cliente values (8, 2, 'Eduarda Castro', 964567892, 'eduardacastro@gmail.com', 120345, 50, 1234567, 1);

insert into Morada values (1, 1,'Rua Dr. Manuel, 234', 0);
insert into Morada values (2, 2,'Rua José António, 120', 1);
insert into Morada values (3, 3,'Rua 2, 100', 0);
insert into Morada values (4, 4,'Rua 10, 300', 1);
insert into Morada values (5, 5,'Rua Henrique Guimarães, 90', 1);
insert into Morada values (6, 6,'Rua António Manuel, 500', 0);
insert into Morada values (7, 7,'Rua Faria Guimarães, 256', 1);
insert into Morada values (8, 8,'Rua Marquês, 145', 0);

insert into Estado_Encomenda values (1, 'Em pagamento');
insert into Estado_Encomenda values (2, 'A preparar');
insert into Estado_Encomenda values (3, 'A enviar');
insert into Estado_Encomenda values (4, 'A ser entregue');
insert into Estado_Encomenda values (5, 'Entregue');

insert into Encomenda values (1, 1, 1, 1, TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_DATE('25/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('21/04/2012', 'dd/mm/yyyy'));
insert into Encomenda values (2, 2, 2, 2, TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_DATE('26/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('20/04/2012', 'dd/mm/yyyy'));
insert into Encomenda values (3, 3, 3, 3, TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'));
insert into Encomenda values (4, 4, 4, 4, TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'));
insert into Encomenda values (5, 2, 5, 5, TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'));
insert into Encomenda values (6, 3, 6, 6, TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'));
insert into Encomenda values (7, 4, 7, 7, TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'));
insert into Encomenda values (8, 1, 8, 8, TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'));



insert into Encomenda values (10, 1, 8, 8, TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('23/08/2012', 'dd/mm/yyyy'));
insert into Item_Encomenda values (10,1,50, 3.99, 'Pereiras');
insert into Item_Encomenda values (10,2,80, 2.99, 'Macieiras');
insert into Item_Encomenda values (10,3,70, 1.99, 'Cebolinha');
insert into Item_Encomenda values (10,4,40, 0.99, 'Espinafre');


insert into Item_Encomenda values (1,1,50, 3.99, 'Pereiras');
insert into Item_Encomenda values (2,2,80, 2.99, 'Macieiras');
insert into Item_Encomenda values (3,3,70, 1.99, 'Cebolinha');
insert into Item_Encomenda values (4,4,40, 0.99, 'Espinafre');

insert into Incidente values (1, 1, TO_DATE('10/05/2012','dd/mm/yyyy'));
insert into Incidente values (2, 2, TO_DATE('20/05/2012','dd/mm/yyyy'));
insert into Incidente values (3, 3, TO_DATE('15/05/2012','dd/mm/yyyy'));
insert into Incidente values (4, 4, TO_DATE('10/05/2012','dd/mm/yyyy'));