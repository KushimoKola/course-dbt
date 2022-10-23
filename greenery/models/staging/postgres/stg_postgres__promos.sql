with promo_source as (
    select * from {{ source ('src_greenery', 'promos') }}
),
final as (
    select
        promo_id as promo_desc,
        discount as promo_discount,
        status as promo_status
    from
        promo_source
)
select * from final