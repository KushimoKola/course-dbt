with src_promo as (
    select * from {{ ref('stg_postgres__promos') }}
),
add_idempotent_key as (
    select
        'promo' as source_system,
        promo_desc,
        promo_discount,
        promo_status
    from
        src_promo
),
final as (
    select
        {{ idempotent_key(['source_system', 'promo_desc']) }} as promo_guid,
        promo_desc,
        promo_discount,
        promo_status
    from
        add_idempotent_key
)
select * from final