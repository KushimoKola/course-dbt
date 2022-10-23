
with int_sessions_events as (
    select * from {{ ref('int_sessions_events') }}
),
final as (
    select
        user_guid,
        count(session_guid) as total_sessions,
        sum(add_to_cart) as total_add_to_cart,
        sum(checkout) as total_checkout,
        sum(package_shipped) as total_package_shipped,
        sum(page_view) as total_page_view,
        min(session_started_at) as session_started_at,
        max(session_ended_at) as session_ended_at,
        sum(session_duration_minute) as total_session_duration_minute,
        sum(session_duration_hour) as total_session_duration_hour
    from
        int_sessions_events
        {{ dbt_utils.group_by(1) }}
)
select * from final