with orders_source as (
    select * from {{ source ('src_greenery', 'orders') }}
),
recasted_order as (
    select
        ORDER_ID as order_guid,
        USER_ID as user_guid,
        PROMO_ID as promo_desc,
        ADDRESS_ID as address_guid,
        CREATED_AT as created_at_utc,
        ORDER_COST as order_cost,
        SHIPPING_COST as shipping_cost,
        ORDER_TOTAL as order_total_cost,
        TRACKING_ID as tracking_guid,
        SHIPPING_SERVICE as shipping_service,
        ESTIMATED_DELIVERY_AT as estimated_delivery_at_utc,
        DELIVERED_AT as delivered_at_utc,
        STATUS as order_status
    from
        orders_source
)
select * from recasted_order