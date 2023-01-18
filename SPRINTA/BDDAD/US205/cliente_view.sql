CREATE OR REPLACE VIEW ViewCliente AS

SELECT CODIGO_INTERNO_CLT_PK,NOME_CLT,NUM_ENCOMENDAS_ULT12MESES_CLT,VALOR_TOTAL_ENCOMENDAS_ULT12MESES_CLT,NIVEL_NIV,

(SELECT COUNT(*) FROM Encomenda WHERE
Encomenda.data_pagamento_pelo_cliente_Enc IS NULL
AND Encomenda.ID_EstEnc_fk = 5
AND Encomenda.codigo_interno_Clt_fk=c.codigo_interno_Clt_pk AND MONTHS_BETWEEN (TO_DATE('10-03-2012','MM-DD-YYYY') ,Encomenda.data_limite_pagamento_Enc) <= 12) AS NumeroEncomendasNaoPagasNoUltimoAno,

CASE

WHEN (SELECT COUNT(*)
FROM Cliente INNER JOIN nivel ON nivel.ID_Niv_pk=cliente.ID_Niv_fk
INNER JOIN Incidente ON incidente.codigo_interno_Clt_fk=cliente.codigo_interno_Clt_pk
INNER JOIN Encomenda ON incidente.ID_Enc_pk = encomenda.ID_Enc_pk WHERE Cliente.codigo_interno_Clt_pk=c.codigo_interno_clt_pk)=0

THEN 'Sem Incidentes até à data'

ELSE (SELECT TO_CHAR(MAX(ENCOMENDA.data_limite_pagamento_enc)) FROM ENCOMENDA WHERE Encomenda.codigo_interno_Clt_fk=c.codigo_interno_clt_pk) END UltimoIncidente

FROM Cliente c INNER JOIN nivel ON nivel.ID_Niv_pk=c.ID_Niv_fk
INNER JOIN Encomenda ON encomenda.codigo_interno_CLT_fk = c.codigo_interno_CLT_pk

GROUP BY c.CODIGO_INTERNO_CLT_PK,NOME_CLT,NUM_ENCOMENDAS_ULT12MESES_CLT,VALOR_TOTAL_ENCOMENDAS_ULT12MESES_CLT,NIVEL_NIV
ORDER BY c.CODIGO_INTERNO_CLT_PK

--Ver a VIEW--
SELECT * FROM ViewCliente

--Novo insert--
insert into Encomenda values (16, 5, 8, 8, TO_DATE('21/05/2012', 'dd/mm/yyyy'), TO_DATE('28/06/2012', 'dd/mm/yyyy'), TO_DATE('23/06/2012', 'dd/mm/yyyy'), null);