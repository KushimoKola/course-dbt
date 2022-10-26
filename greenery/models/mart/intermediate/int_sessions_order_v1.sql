with events as (
    select * from {{ ref('stg_postgres__events') }}
),
order_items as (
    select * from {{ ref('stg_postgres__order_items') }}
),
final as (
select
    {{ idempotent_key(['session_guid', 'event_type', 'created_at_utc'], 'a') }} as unique_guid,
    a.session_guid,
    a.order_guid,
    a.user_guid,
    coalesce (b.product_guid, a.product_guid) as product_guid,
    a.event_type,
    a.created_at_utc
from
    events as a
    left join order_items as b on a.order_guid = b.order_guid
)
select 
    distinct
        {{ idempotent_key(['product_guid', 'unique_guid']) }} as unique_guid,
        session_guid,
        order_guid,
        user_guid,
        product_guid,
        event_type,
        created_at_utc
    from 
        final
