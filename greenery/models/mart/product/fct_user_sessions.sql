with users as (
    select * from {{ ref('dim_users') }}
),
sessions_events as (
    select * from {{ ref('int_sessions_events_agg') }}
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
        zeroifnull(se.total_sessions) as total_sessions,
        zeroifnull(se.total_add_to_cart) as total_add_to_cart,
        zeroifnull(se.total_checkout) as total_checkout,
        zeroifnull(se.total_package_shipped) as total_package_shipped,
        zeroifnull(se.total_page_view) as total_page_view,
        se.session_started_at,
        se.session_ended_at,
        se.total_session_duration_minute,
        se.total_session_duration_hour
    from
        users as us
        left join sessions_events as se on us.user_guid = se.user_guid


