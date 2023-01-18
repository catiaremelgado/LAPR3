   CREATE OR REPLACE FUNCTION ClienteFatorRisco2(
id_cliente    number,
data_hoje date)
RETURN NUMBER
is
    ft_risco NUMBER;
    num_en_pend NUMBER;
    total_valor_inc NUMBER;
    data_ultimo_incidente date;
begin

  ft_risco := 0;
  /* Para contar o dinheiro de todos os incidentes dos últimos 12 meses */
    SELECT SUM(ie.preco_unitario_ItmEnc * ie.quantidade_encomendada_ItmEnc) INTO total_valor_inc
    FROM Item_Encomenda ie
    INNER JOIN Encomenda en
    ON ie.ID_Enc_ck = en.ID_Enc_pk
    WHERE en.codigo_interno_Clt_fk=id_cliente AND (en.data_pagamento_pelo_cliente_Enc > en.data_limite_pagamento_Enc
    AND MONTHS_BETWEEN ( data_hoje, data_limite_pagamento_Enc) <= 12);

 /* Para saber qual foi a data do último incidente dentro dos 12 meses */
     SELECT data_limite_pagamento_Enc INTO data_ultimo_incidente
     FROM Encomenda en
     WHERE en.codigo_interno_Clt_fk=id_cliente AND en.data_pagamento_pelo_cliente_Enc > en.data_limite_pagamento_Enc AND
     (MONTHS_BETWEEN (data_hoje, data_limite_pagamento_Enc) <= 12)
     ORDER BY data_limite_pagamento_Enc DESC
     FETCH FIRST 1 ROWS ONLY;

/* Para contar o número de encomendas por pagar depois do último incidente até à data */
    SELECT COUNT(*) INTO num_en_pend
    FROM Encomenda
    WHERE (codigo_interno_Clt_fk = id_cliente AND data_pagamento_pelo_cliente_Enc IS NULL AND  data_pedido_Enc <= data_hoje AND data_pedido_Enc >= data_ultimo_incidente);

    IF num_en_pend > 0 THEN
      ft_risco := total_valor_inc / num_en_pend;
    ELSE
      ft_risco := total_valor_inc;
    END IF;
    RETURN ft_risco;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Não existem dados suficientes');

    END ;



--chamar func--

SELECT UNIQUE ClienteFatorRisco2(8, date '2012-07-21') AS fator_de_risco from Encomenda;

--Inserts--

insert into Encomenda values (10, 1, 8, 8, TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/04/2012', 'dd/mm/yyyy'), TO_DATE('23/04/2012', 'dd/mm/yyyy'), TO_DATE('23/08/2012', 'dd/mm/yyyy'));
insert into Item_Encomenda values (10,1,50, 3.99, 'Pereiras');
insert into Item_Encomenda values (10,1,50, 3.99, 'Pereiras');
insert into Item_Encomenda values (10,2,80, 2.99, 'Macieiras');
insert into Item_Encomenda values (10,3,70, 1.99, 'Cebolinha');
insert into Item_Encomenda values (10,4,40, 0.99, 'Espinafre');
insert into Encomenda values (11, 1, 8, 8, TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/05/2012', 'dd/mm/yyyy'), TO_DATE('23/05/2012', 'dd/mm/yyyy'), null);
insert into Encomenda values (12, 1, 8, 8, TO_DATE('21/04/2012', 'dd/mm/yyyy'), TO_DATE('28/06/2012', 'dd/mm/yyyy'), TO_DATE('23/06/2012', 'dd/mm/yyyy'), null);
insert into Encomenda values (13, 1, 8, 8, TO_DATE('28/03/2012', 'dd/mm/yyyy'), TO_DATE('28/03/2012', 'dd/mm/yyyy'), TO_DATE('28/03/2012', 'dd/mm/yyyy'), null);
insert into Encomenda values (14, 1, 8, 8, TO_DATE('21/05/2012', 'dd/mm/yyyy'), TO_DATE('28/05/2012', 'dd/mm/yyyy'), TO_DATE('23/05/2012', 'dd/mm/yyyy'), null);
insert into Encomenda values (15, 1, 8, 8, TO_DATE('21/05/2012', 'dd/mm/yyyy'), TO_DATE('28/06/2012', 'dd/mm/yyyy'), TO_DATE('23/06/2012', 'dd/mm/yyyy'), null);