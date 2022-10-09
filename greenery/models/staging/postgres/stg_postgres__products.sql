with products_source as (
    select * from {{ source ('src_greenery', 'products') }}
),
recasted_product as (
    select
        PRODUCT_ID as product_guid,
        NAME as product_name,
        PRICE as product_price
    from
        products_source
)
select * from recasted_product