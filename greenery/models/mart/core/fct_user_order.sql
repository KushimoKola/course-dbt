with user_sessions as (
    select * from {{ ref('int_sessions_events') }}
),
promos as (
    select * from {{ ref('stg_postgres__promos') }}
),
products as (
    select * from {{ ref('stg_postgres__products') }}
),

orders as (
    select * from {{ ref('dim_order') }}
)
select
    ord.order_guid,
    ord.user_guid,
    ord.promo_desc,
    user_sessions.total_sessions,
    user_sessions.session_duration,
    user_sessions.add_to_cart,
    user_sessions.checkout,
    user_sessions.package_shipped,
    user_sessions.page_view,
    user_sessions.session_started_at_utc,
    user_sessions.session_ended_at_utc
from
    user_sessions
    left join orders as ord on user_sessions.user_guid = ord.user_guid