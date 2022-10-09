with order_item_source as (
    select * from {{ source ('src_greenery', 'order_items') }}
),
recasted_order_item as (
    select
        ORDER_ID as order_guid,
        PRODUCT_ID as product_guid,
        QUANTITY as quantity
    from
        order_item_source
)
select * from recasted_order_item