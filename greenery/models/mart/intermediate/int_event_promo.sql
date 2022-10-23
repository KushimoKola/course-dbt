/*
-- TODO 
#Check for every max(created_at_utc) if there is a PROMO, and the final event type
*/
with src_events as (
    select * from {{ ref('stg_postgres__events')}}
),
order_details as (
    select * from {{ ref('int_order_details') }}
),
dim_promo as (
    select * from {{ ref('dim_promo') }}
),
final as (
    select
        a.event_guid,
        a.session_guid,
        a.user_guid,
        a.order_guid,
        a.product_guid,
        c.promo_guid,
        a.page_url,
        a.created_at_utc,
        a.event_type
    from
        src_events as a
        left join order_details as b on a.order_guid = b.order_guid
        left join dim_promo as c on b.promo_guid = c.promo_guid
)
select * from final
