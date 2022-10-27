with products_source as (
    select * from {{ source ('src_greenery', 'products') }}
),
recasted_product as (
    select
        product_id as product_guid,
        name as product_name,
        price as product_price,
        inventory as product_inventory
    from
        products_source
)
select * from recasted_product