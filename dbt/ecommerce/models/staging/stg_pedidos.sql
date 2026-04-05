-- Modelo staging: limpeza e padronização dos pedidos entregues
-- Fonte: fato_pedidos.csv gerado no notebook de preparação

with source as (

    select * from read_csv_auto(
        '{{ env_var("DBT_DATA_PATH", "data/gold/fato_pedidos.csv") }}',
        header = true
    )

),

renamed as (

    select
        -- identificadores
        order_id,
        customer_id,

        -- datas
        order_purchase_timestamp::timestamp  as pedido_em,
        order_delivered_customer_date::timestamp as entregue_em,
        order_estimated_delivery_date::timestamp as previsao_entrega_em,

        -- geografia
        customer_state   as estado_cliente,
        customer_city    as cidade_cliente,

        -- métricas financeiras
        receita_total,
        receita_itens,
        frete_total,
        num_itens,
        num_parcelas,
        tipo_pagamento,

        -- qualidade
        review_score     as nps_score,
        prazo_entrega_dias,

        -- tempo
        cast(mes_compra as varchar) as mes_compra,
        ano_compra

    from source

)

select * from renamed
where receita_total is not null