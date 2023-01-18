--Simples select para ver as vendas mensais por cultura e hub
SELECT Dim_Cultura.especie_vegetal_Cult, Dim_Hub.nome_Hub, Dim_Mes.Nome_Mes,
SUM(Fact_Venda.quantidade_Vend * Fact_Venda.preco_vendido_Vend) as Total_Vendas
    FROM Fact_Venda
    INNER JOIN Dim_Produto ON Dim_Produto.ID_Produto_pk = Fact_Venda.ID_Produto_ck
    INNER JOIN Dim_Cultura ON Dim_Cultura.ID_Cult_pk = Dim_Produto.ID_Cult_fk
    INNER JOIN Dim_Hub ON Dim_Hub.ID_Hub_pk = Fact_Venda.ID_Hub_fk
    INNER JOIN Dim_Tempo ON Dim_Tempo.ID_Tempo_pk = Fact_Venda.ID_Tempo_ck
    INNER JOIN Dim_Mes ON Dim_Mes.ID_Mes_ck = Dim_Tempo.ID_Mes_fk AND Dim_Mes.ID_Ano_ck = Dim_Tempo.ID_Ano_fk
    GROUP BY Dim_Cultura.especie_vegetal_Cult, Dim_Hub.nome_Hub, Dim_Mes.Nome_Mes;

----------
create or replace FUNCTION analisar_vendas (p_especie_vegetal_cult IN VARCHAR2, p_nome_hub IN VARCHAR2, p_nome_mes IN VARCHAR2)
RETURN NUMBER
IS
  total_vendas NUMBER;
BEGIN
  SELECT SUM(Fact_Venda.quantidade_Vend * Fact_Venda.preco_vendido_Vend) INTO total_vendas FROM Fact_Venda
  INNER JOIN Dim_Produto ON Dim_Produto.ID_Produto_pk = Fact_Venda.ID_Produto_ck
  INNER JOIN Dim_Cultura ON Dim_Cultura.ID_Cult_pk = Dim_Produto.ID_Cult_fk
  INNER JOIN Dim_Hub ON Dim_Hub.ID_Hub_pk = Fact_Venda.ID_Hub_fk
  INNER JOIN Dim_Tempo ON Dim_Tempo.ID_Tempo_pk = Fact_Venda.ID_Tempo_ck
  INNER JOIN Dim_Mes ON Dim_Mes.ID_Mes_ck = Dim_Tempo.ID_Mes_fk AND Dim_Mes.ID_Ano_ck = Dim_Tempo.ID_Ano_fk
  WHERE Dim_Cultura.especie_vegetal_Cult = p_especie_vegetal_cult AND Dim_Hub.nome_Hub = p_nome_hub AND Dim_Mes.Nome_Mes = p_nome_mes;
  RETURN total_vendas;
END analisar_vendas;


--Falta testar a função