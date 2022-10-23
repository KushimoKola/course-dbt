with orders as (
    select * from {{ ref('stg_postgres__orders') }}
),
order_items as (
    select * from {{ ref('stg_postgres__order_items') }}
),
promos as (
    select * from {{ ref('dim_promo') }}
),
final as (
    select
        ord.order_guid,
        ord.user_guid,
        ordi.product_guid,
        ord.tracking_guid,
        pro.promo_guid,
        pro.promo_desc,
        ord.created_at_utc as order_created_at_utc,
        ordi.quantity as order_quantity,
        ord.order_cost,
        ord.shipping_cost,
        ord.order_total_cost,
        ord.shipping_service,
        ord.estimated_delivery_at_utc as order_estimated_delivery_at_utc,
        ord.delivered_at_utc as order_delivered_at_utc,
        ord.order_status,
        pro.promo_discount,
        pro.promo_status
    from
        orders as ord
        left join order_items as ordi on ord.order_guid = ordi.order_guid
        left join promos as pro on ord.promo_desc = pro.promo_desc
)
select * from final
