with order_item_source as (
    select * from {{ source ('src_greenery', 'order_items') }}
),
recasted_order_item as (
    select
        order_id as order_guid,
        product_id as product_guid,
        quantity as quantity
    from
        order_item_source
)
select * from recasted_order_item