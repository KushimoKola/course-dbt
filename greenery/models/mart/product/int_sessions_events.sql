with events as (
    select * from {{ ('stg_postgres__events') }}
)
select
    user_guid,
    product_guid,
    count(*) as total_sessions,
    timediff(minute, min(created_at_utc), max(created_at_utc)) session_duration,
    sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart,
    sum(case when event_type = 'checkout' then 1 else 0 end) as checkout,
    sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped,
    sum(case when event_type = 'page_view' then 1 else 0 end) as page_view,
    min(created_at_utc) session_started_at_utc,
    max(created_at_utc) session_ended_at_utc
from
    events
group by
    user_guid,
    session_guid
