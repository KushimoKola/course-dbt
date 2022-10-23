with events as (
    select * from {{ ('stg_postgres__events') }}
),
events_agg as (
select
    user_guid,
    session_guid,
    sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart,
    sum(case when event_type = 'checkout' then 1 else 0 end) as checkout,
    sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped,
    sum(case when event_type = 'page_view' then 1 else 0 end) as page_view,
    min(created_at_utc) session_started_at,
    max(created_at_utc) session_ended_at,
    timediff(minute, min(created_at_utc), max(created_at_utc)) session_duration_minute,
    timediff(hour, min(created_at_utc), max(created_at_utc)) session_duration_hour
from
    events
/*
group by
    user_guid,
    session_guid
*/
    {{ dbt_utils.group_by(2) }}

)
select * from events_agg
