with promo_source as (
    select * from {{ source ('src_greenery', 'promos') }}
),
recasted_promo as (
    select
        PROMO_ID as promo_desc,
        DISCOUNT as promo_discount,
        STATUS as promo_status
    from
        promo_source
)
select * from recasted_promo