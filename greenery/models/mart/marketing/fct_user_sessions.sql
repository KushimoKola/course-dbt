with users as (
    select * from {{ ref('dim_users') }}
),
sessions_events as (
    select * from {{ ref('int_sessions_events') }}
)
    select
        us.user_guid,
        us.first_name,
        us.last_name,
        us.phone_number,
        us.email,
        us.address,
        us.zipcode,
        us.state,
        us.country,
        min(session_started_at_utc) first_session_started_at_utc,
        max(session_started_at_utc) last_session_started_at_utc,
        count(*) total_sessions,
        sum(session_duration) as session_duration,
        sum(add_to_cart) as add_to_cart,
        sum(checkout) as checkout,
        sum(package_shipped) as package_shipped,
        sum(page_view) as page_view
    from
        users as us
        left join sessions_events as se on us.user_guid = se.user_guid
    group by
        us.user_guid,
        us.first_name,
        us.last_name,
        us.phone_number,
        us.email,
        us.address,
        us.zipcode,
        us.state,
        us.country

