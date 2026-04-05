# E-commerce Strategic Dashboard

Dashboard estratégico de e-commerce construído sobre dados reais do marketplace Olist,
com análise exploratória em Python, modelagem semântica com dbt e visualização executiva em Power BI.

---

## Situação

O Olist é um marketplace brasileiro que conecta pequenos lojistas a grandes canais de venda.
Com operações em todo o território nacional e mais de 96 mil pedidos registrados entre 2016 e 2018,
a empresa acumulou dados ricos sobre comportamento de compra, logística e satisfação de clientes —
mas sem uma visão consolidada que permitisse decisões estratégicas baseadas em dados.

## Tarefa

Transformar 9 tabelas relacionais brutas em um dashboard executivo capaz de responder:
- Qual é a evolução de receita e ticket médio ao longo do tempo?
- Quais regiões concentram receita e onde há oportunidade de expansão?
- Como está a qualidade operacional medida por NPS e prazo de entrega?

## Ação

**1. Análise Exploratória (Python)**
Condução de EDA documentada em notebooks públicos, cobrindo volumetria,
qualidade dos dados, integridade referencial e distribuições.
Identificação de 1 anomalia crítica: pedido sem registro de pagamento tratado antes da modelagem.

**2. Modelagem Semântica (dbt + DuckDB)**
Construção de camada semântica com 3 modelos governados:
- `stg_pedidos` — staging com limpeza e padronização
- `mart_receita_mensal` — métricas agregadas por período
- `mart_receita_por_estado` — análise geográfica com participação percentual

Testes de qualidade automatizados: `unique` e `not_null` nas colunas críticas — 4/4 passando.

**3. Dashboard Executivo (Power BI)**
3 páginas com hierarquia visual orientada a decisão:
- **Visão Executiva** — KPIs principais + evolução de receita mensal
- **Análise Geográfica** — concentração de receita e ticket médio por estado
- **Qualidade Operacional** — distribuição de NPS e prazo de entrega

## Resultado

| Métrica | Valor |
|---------|-------|
| Receita total (2016–2018) | R$ 15,4 milhões |
| Ticket médio | R$ 159,86 |
| Crescimento de volume | 20x em 24 meses |
| NPS médio | 4,16 / 5,0 |
| Prazo médio de entrega | 12,1 dias |
| Taxa de entrega | 97% |

**Insights estratégicos identificados:**
- SP concentra 37% da receita com ticket 11% abaixo da média nacional
- Estados do Norte (AP, AC, RO) têm ticket médio 50% superior a SP — oportunidade de margem em mercados menos explorados
- Pico de volume em novembro de 2017 (7.289 pedidos) seguido de estabilização — sinal de maturação do canal

---

## Stack

| Camada | Tecnologia |
|--------|-----------|
| Análise exploratória | Python 3.11 · pandas · seaborn · matplotlib |
| Modelagem semântica | dbt-core 1.11 · DuckDB 1.5 |
| Visualização | Power BI Desktop |
| Versionamento | Git · GitHub |

## Estrutura do Repositório
```
├── data/
│   ├── raw/                           # CSVs originais do dataset Olist
│   └── gold/                          # Marts exportados pelo dbt
├── notebooks/
│   ├── 01_eda_visao_geral.ipynb       # Volumetria, qualidade e integridade
│   └── 02_preparacao_dados.ipynb      # Limpeza, joins e KPIs exploratórios
├── dbt/ecommerce/
│   └── models/
│       ├── staging/stg_pedidos.sql    # Camada de limpeza
│       └── marts/                     # Métricas de negócio governadas
├── scripts/
│   └── export_marts.py               # Exportação dbt → CSV → Power BI
└── ecommerce-dashboard.pbix          # Dashboard executivo
```

## Dataset

[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
— 9 tabelas relacionais · 96.478 pedidos entregues · 2016–2018