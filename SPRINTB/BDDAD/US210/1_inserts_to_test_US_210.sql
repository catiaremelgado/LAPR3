insert into Tipo_Rega values(20,'Bombeada');
insert into Tipo_Rega values(30,'Aspersão');
insert into Tipo_Rega values(50,'Pulverização');

insert into Tipo_Fator_Producao values (10,'Fertilizante');
insert into Tipo_Fator_Producao values (20,'Adubo');
insert into Tipo_Fator_Producao values (30,'Corretivo');
insert into Tipo_Fator_Producao values (40,'Produto fitofármaco');

insert into Fator_Producao values(10, 20, 3.99,'Atlus','Guanito');
insert into Fator_Producao values(20, 10, 2.99, 'Atlus', 'Siru');
insert into Fator_Producao values(30, 30, 1.99, 'Natura','Compo');
insert into Fator_Producao values(40, 40, 4.99, 'Greenie', 'Geolia');

insert into Tipo_Fertilizacao values (20,'Fertirrega');
insert into Tipo_Fertilizacao values (30,'Aplicação direta');

insert into Parcela values (10,'Outra parcela de cima do andre',20);
insert into Parcela values (20,'Outra parcela do meio do andre',30);
--insert into Parcela values (30,'Outra parcela de baixo do andre',25);

insert into Tipo_Cultura values (10,'Permanente');
insert into Tipo_Cultura values (20,'Temporária');

insert into Cultura values (100,10,'Tamareiras');
insert into Cultura values (200,20,'Arrozais');
--insert into Cultura values (300,20,'Maracujazeiro');

insert into Plantacao values (10,100,TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_DATE('01/01/2023','dd/mm/yyyy'),20);
insert into Plantacao values (20,200,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_DATE('21/04/2014','dd/mm/yyyy'),30);
--insert into Plantacao values (30,300,TO_DATE('22/06/2014','dd/mm/yyyy'),TO_DATE('22/4/2015','dd/mm/yyyy'),25);

-- O arrozal nunca poderá ser fertilizado com este fator produção
insert into Restricoes_Fator_Producao values(20,40,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_DATE('21/04/2014','dd/mm/yyyy'));
-- Durante alguns anos a tamareira nunca poderá receber este fator produção
insert into Restricoes_Fator_Producao values(10,40,TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_DATE('01/01/2018', 'dd/mm/yyyy'));


insert into Operacao values(10,100,TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('20/05/2012 13:10', 'dd/mm/yyyy hh24:mi'), null, 'Rega');
insert into Registo_Rega values(10, 100, TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('20/05/2012 13:10', 'dd/mm/yyyy hh24:mi'), 50, null, 25.2);

insert into Operacao values(10,100,TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('20/06/2012 14:00', 'dd/mm/yyyy hh24:mi'), null, 'Rega');
insert into Registo_Rega values(10, 100, TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('20/06/2012 14:00', 'dd/mm/yyyy hh24:mi'), 50, null, 27.8);

insert into Operacao values(10,100,TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('27/07/2012 16:00', 'dd/mm/yyyy hh24:mi'), null, 'Rega');
insert into Registo_Rega values(10, 100, TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('27/07/2012 16:00', 'dd/mm/yyyy hh24:mi'), 50, null, 30.9);


insert into Operacao values(10,100,TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('30/10/2012 20:00', 'dd/mm/yyyy hh24:mi'), null, 'Fertilização');
insert into Registo_Fertilizacao values(10, 100, TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('30/10/2012 20:00', 'dd/mm/yyyy hh24:mi'), 10, 30, null, 40.5);

insert into Operacao values(10,100,TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('31/12/2012 6:00', 'dd/mm/yyyy hh24:mi'), null, 'Fertilização');
insert into Registo_Fertilizacao values(10, 100, TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('31/12/2012 6:00', 'dd/mm/yyyy hh24:mi'), 10, 30, null, 36.7);

insert into Operacao values(10,100,TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('28/02/2013 23:00', 'dd/mm/yyyy hh24:mi'), null, 'Fertilização');
insert into Registo_Fertilizacao values(10, 100, TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('28/02/2013 23:00', 'dd/mm/yyyy hh24:mi'), 30, 30, null, 45.1);


insert into Operacao values(10,100,TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('29/10/2016 6:00', 'dd/mm/yyyy hh24:mi'), null, 'Colheita');
insert into Registo_Colheita values(10, 100, TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('29/10/2016 6:00', 'dd/mm/yyyy hh24:mi'), null, 20);

insert into Operacao values(10,100,TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('28/12/2016 7:00', 'dd/mm/yyyy hh24:mi'), null, 'Colheita');
insert into Registo_Colheita values(10, 100, TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('28/12/2016 7:00', 'dd/mm/yyyy hh24:mi'), null, 25);

insert into Operacao values(10,100,TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('01/02/2016 9:00', 'dd/mm/yyyy hh24:mi'), null, 'Colheita');
insert into Registo_Colheita values(10, 100, TO_DATE('01/01/2012', 'dd/mm/yyyy'),TO_TIMESTAMP('01/02/2016 9:00', 'dd/mm/yyyy hh24:mi'), null, 30.2);

---

insert into Operacao values(20,200,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('22/05/2013 20:00', 'dd/mm/yyyy hh24:mi'), null, 'Rega');
insert into Registo_Rega values(20, 200, TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('22/05/2013 20:00', 'dd/mm/yyyy hh24:mi'), 30, null, 300.2);

insert into Operacao values(20,200,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('24/05/2013 20:00', 'dd/mm/yyyy hh24:mi'), null, 'Rega');
insert into Registo_Rega values(20, 200, TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('24/05/2013 20:00', 'dd/mm/yyyy hh24:mi'), 30, null, 250.5);

insert into Operacao values(20,200,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('26/05/2013 21:30', 'dd/mm/yyyy hh24:mi'), null, 'Rega');
insert into Registo_Rega values(20, 200, TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('26/05/2013 21:30', 'dd/mm/yyyy hh24:mi'), 30, null, 275.8);


insert into Operacao values(20,200,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('21/05/2013 20:00', 'dd/mm/yyyy hh24:mi'), null, 'Fertilização');
insert into Registo_Fertilizacao values(20, 200, TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('21/05/2013 20:00', 'dd/mm/yyyy hh24:mi'), 20, 20, null, 23.4);

insert into Operacao values(20,200,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('07/07/2013 6:00', 'dd/mm/yyyy hh24:mi'), null, 'Fertilização');
insert into Registo_Fertilizacao values(20, 200, TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('07/07/2013 6:00', 'dd/mm/yyyy hh24:mi'), 20, 20, null, 50.7);

insert into Operacao values(20,200,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('25/11/2013 03:00', 'dd/mm/yyyy hh24:mi'), null, 'Fertilização');
insert into Registo_Fertilizacao values(20, 200, TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('25/11/2013 03:00', 'dd/mm/yyyy hh24:mi'), 20, 20, null, 4.1);


insert into Operacao values(20,200,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('01/12/2013 14:00', 'dd/mm/yyyy hh24:mi'), null, 'Colheita');
insert into Registo_Colheita values(20, 200, TO_DATE('21/05/2013','dd/mm/yyyy'), TO_TIMESTAMP('01/12/2013 14:00', 'dd/mm/yyyy hh24:mi'), null, 200);

insert into Operacao values(20,200,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('15/12/2013 7:00', 'dd/mm/yyyy hh24:mi'), null, 'Colheita');
insert into Registo_Colheita values(20, 200, TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('15/12/2013 7:00', 'dd/mm/yyyy hh24:mi'), null, 150);

insert into Operacao values(20,200,TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('01/02/2016 9:00', 'dd/mm/yyyy hh24:mi'), null, 'Colheita');
insert into Registo_Colheita values(20, 200, TO_DATE('21/05/2013','dd/mm/yyyy'),TO_TIMESTAMP('01/02/2016 9:00', 'dd/mm/yyyy hh24:mi'), null, 100);

