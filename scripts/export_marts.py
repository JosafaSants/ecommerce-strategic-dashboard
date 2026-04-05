import duckdb

conn = duckdb.connect('data/gold/ecommerce.duckdb')

conn.execute(
    "COPY mart_receita_mensal TO 'data/gold/mart_receita_mensal.csv' (HEADER, DELIMITER ',')"
)

conn.execute(
    "COPY mart_receita_por_estado TO 'data/gold/mart_receita_por_estado.csv' (HEADER, DELIMITER ',')"
)

print('Exports concluidos.')
conn.close()