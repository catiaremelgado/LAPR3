/* To test Tipo_Cliente */
/* Invalid designacao */
insert into Tipo_Cliente values (20,'Organizacao');
/* Valid designation 1º option */
insert into Tipo_Cliente values (20,'Empresa');
/* Valid designation 2º option */
insert into Tipo_Cliente values (10,'Particular');


/* To test Cultura */
/* Adding Tipo_Cultura to have a valid ipo_Cultura fk in Cultura */
insert into Tipo_Cultura values (25,'Temporária');
/* Invalid price */
insert into Cultura values (25,25,'Espinafre','-1');
/* Valid price */
insert into Cultura values (25,25,'Espinafre','1');
/* Invalid Tipo_Cultura */
insert into Cultura values (25,3,'Espinafre','1');
/* Invalid price and Tipo_Cultura */
insert into Cultura values (25,3,'Espinafre','-1');


/* To test Parcela */
/* Invalid Area inferior limit */
insert into Parcela values (2,'Solar de cima', -1);
/* Invalid Area superior limit */
insert into Parcela values (2,'Solar de cima', 10001);
/* Valid area value */
insert into Parcela values (2,'Solar de cima', 10000);


/* To test Plantacao */
/* Adding Cultura and Parcela to have a valid ID_Cult fk in Cultura and a valid ID_Prcl in Parcela */
insert into Tipo_Cultura values (25,'Temporária');
insert into Cultura values (10,25,'Espinafre','1');
insert into Parcela values (2,'Solar de cima','10000');
/* Invalid Data */
insert into Plantacao values (20,10,TO_DATE('29/10/2003', 'dd/mm/yyyy'),TO_DATE('20/09/2015', 'dd/mm/yyyy'), 2);
/* Invalid Area superior limit */
insert into Plantacao values (20,10,TO_DATE('29/10/2007', 'dd/mm/yyyy'),TO_DATE('20/09/2015', 'dd/mm/yyyy'), 10001);
/* Invalid Area inferior limit */
insert into Plantacao values (20,10,TO_DATE('29/10/2007', 'dd/mm/yyyy'),TO_DATE('20/09/2015', 'dd/mm/yyyy'), -1);
/* Invalid fk */
insert into Plantacao values (30,1,TO_DATE('29/10/2007', 'dd/mm/yyyy'),TO_DATE('20/09/2015', 'dd/mm/yyyy'), 10000);
/* Valid values */
insert into Plantacao values (20,10,TO_DATE('29/10/2007', 'dd/mm/yyyy'),TO_DATE('20/09/2015', 'dd/mm/yyyy'), 10000);


/* To test Plano_Rega */
/* Adding Parcela to have a valid id og parcela */
insert into Parcela values (50, 'Quintinha', 250);
/* A valid Cultura already exists id = 25*/
/* Adding valid Plantacao */
insert into Plantacao values (50,25,TO_DATE('20/04/2012', 'dd/mm/yyyy'),TO_DATE('20/04/2013','dd/mm/yyyy'),20);
/* Adding valid Tipo_Rega */
insert into Tipo_Rega values(100,'Gravidade');
/* Invalid Parcela */
insert into Plano_Rega values(500,25, TO_DATE('20/04/2012', 'dd/mm/yyyy'), 1, 20, 30, 10);
/* Invalid Cultura */
insert into Plano_Rega values(50,300, TO_DATE('20/04/2012', 'dd/mm/yyyy'), 1, 20, 30, 10);
/* Invalid Plano_Rega */
insert into Plano_Rega values(50,25, TO_DATE('20/04/2012', 'dd/mm/yyyy'), 1000, 20, 30, 10);
/* Invalid tempo rega */
insert into Plano_Rega values(50,25, TO_DATE('20/04/2012', 'dd/mm/yyyy'), 100, -1, 30, 10);
/* Invalid quantidade */
insert into Plano_Rega values(50,25, TO_DATE('20/04/2012', 'dd/mm/yyyy'), 100, 20, -1, 10);
/* Invalid periodicidade */
insert into Plano_Rega values(50,25, TO_DATE('20/04/2012', 'dd/mm/yyyy'), 100, 20, 30, -1);
/* All valid data */
insert into Plano_Rega values(50,25, TO_DATE('20/04/2012', 'dd/mm/yyyy'), 100, 20, 30, 10);


/* To test Registo_Rega */
/* A valid Parcela already exists id = 50 */
/* A valid Cultura already exists id = 25 */
/* A valid data Plantacao already exists = TO_DATE('20/04/2012', 'dd/mm/yyyy') */
/* A valid Tipo_Rega already exists id = 100 */
/* Invalid Parcela */
insert into Registo_Rega values(500,1, TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_TIMESTAMP('21-04-2012 12:10', 'dd-mm-yyyy hh24:mi'), 30, 100);
/* Invalid Cultura */
insert into Registo_Rega values(1,250, TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_TIMESTAMP('21-04-2012 12:10', 'dd-mm-yyyy hh24:mi'), 30, 100);
/* Invalid data Plantacao */
insert into Registo_Rega values(50,25, TO_DATE('20/04/2000', 'dd/mm/yyyy'), TO_TIMESTAMP('21-04-2012 12:10', 'dd-mm-yyyy hh24:mi'), 30, 100);
/* Invalid Tipo_Rega */
insert into Registo_Rega values(50,25, TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_TIMESTAMP('21-04-2012 12:10', 'dd-mm-yyyy hh24:mi'), 30, 1000);
/* Invalid quantidade */
insert into Registo_Rega values(50,25, TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_TIMESTAMP('21-04-2012 12:10', 'dd-mm-yyyy hh24:mi'), -1, 100);
/* Invalid data registo rega */
insert into Registo_Rega values(50,25, TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_TIMESTAMP('21-04-2000 12:10', 'dd-mm-yyyy hh24:mi'), -1, 100);
/* All valid data */
insert into Registo_Rega values(50,25, TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_TIMESTAMP('21-04-2012 12:10', 'dd-mm-yyyy hh24:mi'), 100, 100);


/* To test Registo_Colheita */
/* Adding Plantacao to have a valid ID_Cult fk, ID_Prcl fk and data_Plant in Plantacao */
insert into Tipo_Cultura values (25,'Temporária');
insert into Cultura values (10,25,'Espinafre','1');
insert into Parcela values (2,'Solar de cima', 10);
insert into Plantacao values (2,10,TO_DATE('29/10/2007', 'dd/mm/yyyy'),TO_DATE('20/09/2015', 'dd/mm/yyyy'), 10000);
/* Invalid Quantidade inferior limit and ivalid data colheita*/
insert into Registo_Colheita values (2,10,TO_DATE('29/10/2003', 'dd/mm/yyyy'),TO_DATE('30/10/2018', 'dd/mm/yyyy'), -1);
/* Invalid Quantidade superior limit and ivalid data colheita*/
insert into Registo_Colheita values (2,10,TO_DATE('29/10/2007', 'dd/mm/yyyy'),TO_DATE('30/10/2018', 'dd/mm/yyyy'), 50001);
/* Invalid data colheita */
insert into Registo_Colheita values (2,10,TO_DATE('29/10/2007', 'dd/mm/yyyy'),TO_DATE('30/10/2018', 'dd/mm/yyyy'), 10000);
/* Valid data */
insert into Registo_Colheita values (2,10,TO_DATE('29/10/2007', 'dd/mm/yyyy'),TO_DATE('20/09/2015', 'dd/mm/yyyy'), 1000);


/* To test Registo_Sensor */
/* Adding Plantacao and Sensor to have a valid ID_Cult fk, ID_Prcl fk, ID_Sens fk and data_Plant in Plantacao */
insert into Tipo_Cultura values (25,'Temporária');
insert into Cultura values (10,25,'Espinafre','1');
insert into Parcela values (2,'Solar de cima', 10);
insert into Plantacao values (2,10,TO_DATE('29/10/2007', 'dd/mm/yyyy'),TO_DATE('20/09/2015', 'dd/mm/yyyy'), 10000);
insert into Tipo_Sensor values(2,'Sensor de temperatura do solo', 'ºC', 0.50);
insert into Sensor values(1,2);
/* Invalid keys*/
insert into Registo_Sensor values (20,1,TO_DATE('29/10/2007', 'dd/mm/yyyy'),23,TO_DATE('30/10/2018', 'dd/mm/yyyy'), 50);
/* Invalid data capturada */
insert into Registo_Sensor values (2,10,TO_DATE('29/10/2007', 'dd/mm/yyyy'), 1, TO_DATE('30/10/2006', 'dd/mm/yyyy'), 10);
/* Valid data */
insert into Registo_Sensor values (2,10,TO_DATE('29/10/2007', 'dd/mm/yyyy'), 1, TO_DATE('28/11/2017', 'dd/mm/yyyy') ,12);


/* To test Fator_Producao */
/* Invalid primary key */
insert into Fator_Producao values(null, 0.01, 'Zé dos fertilizantes', 'Solo Fértil');
/* Invalid price */
insert into Fator_Producao values(40, -0.01, 'Zé dos fertilizantes', 'Solo Fértil');
/* Invalid fornecedor */
insert into Fator_Producao values(40, 0.01, null, 'Solo Fértil');
/* Invalid nome comercial */
insert into Fator_Producao values(40, 0.01, 'Zé dos fertilizantes', null);
/* All valid data */
insert into Fator_Producao values(40, 0.01, 'Zé dos fertilizantes', 'Solo Fértil');


/* To test Cliente */
/* Adding valid Tipo_Cliente and Nivel */
insert into Tipo_Cliente values (10,'Particular');
insert into Nivel values(3, 'A');
/* Invalid name */
insert into Cliente values (12, 10, 'M', 123456789, 'manuelguerra@gmail.com', 1000, 2, 10230, 3);
/* Invalid nº fiscal */
insert into Cliente values (2, 10, 'Maria', 12345678, 'manueluerra@gmail.com', 1000, 2, 10230, 3);
/* Invalid email */
insert into Cliente values (3, 10, 'Maria', 123456782, 'mgmail.com', 1000, 2, 10230, 3);
/* Invalid nº plafond */
insert into Cliente values (7, 10, 'Maria', 123456783, 'manuelerra@gmail.com', 0, 2, 10230, 3);
/* Invalid nº encomendas */
insert into Cliente values (8, 10, 'Maria', 123456784, 'manueluerra@gmail.com', 9, -2, 10230, 3);
/* Invalid nº valor total encomendas */
insert into Cliente values (13, 10, 'Maria', 123456788, 'manueguerra@gmail.com', 10, 2, -10230, 3);
/* Invalid keys */
insert into Cliente values (11, 1, 'Maria', 123456999, 'manuelguea@gmail.com', 8, 20, 10230, 3);
/* Valid data */
insert into Cliente values (12, 10, 'Manuel', 123456789, 'manuelguerra@gmail.com', 1000, 2, 10230, 3);


/* To test Morada */
/* Adding valid Cliente */
insert into Cliente values (12, 10, 'Manuel Guerra', 123456789, 'manuelguerra@gmail.com', 1000, 2, 10230, 3);
/* Invalid fiscal option1*/
insert into Morada values (1, 12, 'Rua das Flores', 2);
/* Invalid  keys*/
insert into Morada values (1, 1, 'Rua das Flores', 0);
/* Valid  data*/
insert into Morada values (1, 12, 'Rua das Flores', 1);


/* To test Encomenda */
/* Adding valid Estado Encomenda */
insert into Cliente values (12, 10, 'Manuel Guerra', 123456789, 'manuelguerra@gmail.com', 1000, 2, 10230, 3);
insert into Estado_Encomenda values (4, 'A ser entregue');
insert into Morada values (1, 12, 'Rua das Flores', 1);
/* Invalid data pedido */
insert into Encomenda values (5, 4, 12, 1, TO_DATE('20/04/2006', 'dd/mm/yyyy'), TO_DATE('25/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('21/04/2012', 'dd/mm/yyyy'));
/* Invalid data entrega*/
insert into Encomenda values (2, 4, 12, 1, TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_DATE('18/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('21/04/2012', 'dd/mm/yyyy'));
/* Invalid data limite pagamento*/
insert into Encomenda values (3, 4, 12, 1, TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_DATE('25/04/2012', 'dd/mm/yyyy'), TO_DATE('26/04/2012', 'dd/mm/yyyy'), TO_DATE('21/04/2012', 'dd/mm/yyyy'));
/* Invalid data pagamento pelo cliente*/
insert into Encomenda values (4, 4, 12, 1, TO_DATE('24/04/2012', 'dd/mm/yyyy'), TO_DATE('25/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('22/04/2012', 'dd/mm/yyyy'));
/* Invalid keys*/
insert into Encomenda values (4, 2, 1, 7, TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_DATE('25/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('21/04/2012', 'dd/mm/yyyy'));
/* Valid  data*/
insert into Encomenda values (1, 4, 12, 1, TO_DATE('20/04/2012', 'dd/mm/yyyy'), TO_DATE('25/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('21/04/2012', 'dd/mm/yyyy'));


/* To test Plano_Fertilizacao */
/* A valid Parcela already exists id = 50 */
/* A valid Cultura already exists id = 25 */
/* A valid data Plantacao already exists = TO_DATE('20/04/2012', 'dd/mm/yyyy') */
/* A valid Fator_Producao already exists id = 40 */
/* Adding valid Tipo_Fertilizacao */
insert into Tipo_Fertilizacao values (60,'Foliar');
/* Invalid Parcela */
insert into Plano_Fertilizacao values (500,25,40,TO_DATE('20/04/2012','dd/mm/yyyy'),TO_DATE('20/05/2012','dd/mm/yyyy'),TO_DATE('20/01/2013','dd/mm/yyyy'),60,10);
/* Invalid Cultura */
insert into Plano_Fertilizacao values (50,250,40,TO_DATE('20/04/2012','dd/mm/yyyy'),TO_DATE('20/05/2012','dd/mm/yyyy'),TO_DATE('20/01/2013','dd/mm/yyyy'),60,10);
/* Invalid data Plantacao */
insert into Plano_Fertilizacao values (50,25,40,TO_DATE('20/04/2000','dd/mm/yyyy'),TO_DATE('20/05/2012','dd/mm/yyyy'),TO_DATE('20/01/2013','dd/mm/yyyy'),60,10);
/* Invalid Fator_Producao */
insert into Plano_Fertilizacao values (50,25,400,TO_DATE('20/04/2012','dd/mm/yyyy'),TO_DATE('20/05/2012','dd/mm/yyyy'),TO_DATE('20/01/2013','dd/mm/yyyy'),60,10);
/* Invalid Tipo_Fertilizacao */
insert into Plano_Fertilizacao values (50,25,40,TO_DATE('20/04/2012','dd/mm/yyyy'),TO_DATE('20/05/2012','dd/mm/yyyy'),TO_DATE('20/01/2013','dd/mm/yyyy'),600,10);
/* Invalid data inicial */
insert into Plano_Fertilizacao values (50,25,40,TO_DATE('20/04/2012','dd/mm/yyyy'),TO_DATE('20/05/2000','dd/mm/yyyy'),TO_DATE('20/01/2013','dd/mm/yyyy'),60,10);
/* Invalid data final */
insert into Plano_Fertilizacao values (50,25,40,TO_DATE('20/04/2012','dd/mm/yyyy'),TO_DATE('20/05/2012','dd/mm/yyyy'),TO_DATE('20/01/2010','dd/mm/yyyy'),60,10);
/* Invalid quantidade */
insert into Plano_Fertilizacao values (50,25,40,TO_DATE('20/04/2012','dd/mm/yyyy'),TO_DATE('20/05/2012','dd/mm/yyyy'),TO_DATE('20/01/2013','dd/mm/yyyy'),60,-10);
/* All valid data */
insert into Plano_Fertilizacao values (50,25,40,TO_DATE('20/04/2012','dd/mm/yyyy'),TO_DATE('20/05/2012','dd/mm/yyyy'),TO_DATE('20/01/2013','dd/mm/yyyy'),60,10);


/* To test Registo_Fertilizacao */
/* A valid Parcela already exists id = 50 */
/* A valid Cultura already exists id = 25 */
/* A valid data Plantacao already exists = TO_DATE('20/04/2012', 'dd/mm/yyyy') */
/* A valid Fator_Producao already exists id = 40 */
/* A valid Tipo_Fertilizacao already exists id = 60 */
/* Invalid Parcela */
insert into Registo_Fertilizacao values (500,25,TO_DATE('20/04/2012','dd/mm/yyyy'),40,TO_TIMESTAMP('20-12-2012 12:10', 'dd-mm-yyyy hh24:mi'),60,100);
/* Invalid Cultura */
insert into Registo_Fertilizacao values (50,250,TO_DATE('20/04/2012','dd/mm/yyyy'),40,TO_TIMESTAMP('20-12-2012 12:10', 'dd-mm-yyyy hh24:mi'),60,100);
/* Invalid data Plantacao */
insert into Registo_Fertilizacao values (50,25,TO_DATE('20/04/2002','dd/mm/yyyy'),40,TO_TIMESTAMP('20-12-2012 12:10', 'dd-mm-yyyy hh24:mi'),60,100);
/* Invalid Fator_Producao */
insert into Registo_Fertilizacao values (50,25,TO_DATE('20/04/2012','dd/mm/yyyy'),400,TO_TIMESTAMP('20-12-2012 12:10', 'dd-mm-yyyy hh24:mi'),60,100);
/* Invalid Tipo_Fertilizacao */
insert into Registo_Fertilizacao values (50,25,TO_DATE('20/04/2012','dd/mm/yyyy'),40,TO_TIMESTAMP('20-12-2012 12:10', 'dd-mm-yyyy hh24:mi'),600,100);
/* Invalid data hora */
insert into Registo_Fertilizacao values (50,25,TO_DATE('20/04/2012','dd/mm/yyyy'),40,TO_TIMESTAMP('20-12-2000 12:10', 'dd-mm-yyyy hh24:mi'),60,100);
/* Invalid quantidade */
insert into Registo_Fertilizacao values (50,25,TO_DATE('20/04/2012','dd/mm/yyyy'),40,TO_TIMESTAMP('20-12-2012 12:10', 'dd-mm-yyyy hh24:mi'),60,-100);
/* All valid data */
insert into Registo_Fertilizacao values (50,25,TO_DATE('20/04/2012','dd/mm/yyyy'),40,TO_TIMESTAMP('20-12-2012 12:10', 'dd-mm-yyyy hh24:mi'),60,100);


/* To test Item_Encomenda */
/* A valid Encomenda already exits id = 1*/
/* A valid Cultura already exists id = 25 */
/* Invalid id Encomenda */
insert into Item_Encomenda values (10,25,50, 5.99, 'Mirtilos');
/* Invalid id Cultura */
insert into Item_Encomenda values (1,250,50, 5.99, 'Mirtilos');
/* Invalid quantidade encomenda */
insert into Item_Encomenda values (1,25,-50, 5.99, 'Mirtilos');
insert into Item_Encomenda values (1,25,100000, 5.99, 'Mirtilos');
/* Inavalid nome produto */
insert into Item_Encomenda values (1,25,50, 5.99, null);
/* All valid data */
insert into Item_Encomenda values (1,25,50, 5.99, 'Mirtilos');
