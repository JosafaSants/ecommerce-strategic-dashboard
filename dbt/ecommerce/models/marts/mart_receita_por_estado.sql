-- Mart: receita agregada por estado do cliente
-- Pergunta respondida: "Quais estados concentram receita e qual o ticket médio regional?"

with pedidos as (

    select * from {{ ref('stg_pedidos') }}

),

agregado as (

    select
        estado_cliente,
        count(order_id)         as total_pedidos,
        sum(receita_total)      as receita_total,
        avg(receita_total)      as ticket_medio,
        avg(nps_score)          as nps_medio,
        avg(prazo_entrega_dias) as prazo_medio_dias

    from pedidos
    group by estado_cliente

)

select
    *,
    round(receita_total / sum(receita_total) over (), 4) as pct_receita_total,
    round(ticket_medio, 2)      as ticket_medio_arredondado,
    round(nps_medio, 2)         as nps_medio_arredondado,
    round(prazo_medio_dias, 1)  as prazo_medio_arredondado

from agregado
order by receita_total desc