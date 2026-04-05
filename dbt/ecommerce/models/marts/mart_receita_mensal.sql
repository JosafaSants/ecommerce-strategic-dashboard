-- Mart: receita mensal agregada com ticket médio e volume de pedidos
-- Pergunta respondida: "Como evoluiu a receita e o ticket médio mês a mês?"

with pedidos as (

    select * from {{ ref('stg_pedidos') }}

),

agregado as (

    select
        mes_compra,
        ano_compra,
        count(order_id)          as total_pedidos,
        sum(receita_total)       as receita_total,
        avg(receita_total)       as ticket_medio,
        avg(nps_score)           as nps_medio,
        avg(prazo_entrega_dias)  as prazo_medio_dias,
        sum(frete_total)         as frete_total

    from pedidos
    group by mes_compra, ano_compra

)

select
    *,
    round(ticket_medio, 2)      as ticket_medio_arredondado,
    round(nps_medio, 2)         as nps_medio_arredondado,
    round(prazo_medio_dias, 1)  as prazo_medio_arredondado

from agregado
order by mes_compra