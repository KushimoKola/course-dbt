with sessions as (
    select * from {{ ref('int_sessions_order_v1') }}
),
orders as (
    select distinct
        session_guid,
        count(distinct order_guid) as order_count
    from sessions
    {{ dbt_utils.group_by(1) }}
),
final as (
    select
        session_guid,
        {{ event_type_counts('int_sessions_order_v1', 'event_type', 'session_guid') }},
        count(distinct case when order_guid is null then product_guid else null end) as unique_product_viewed,
        count(distinct case when order_guid is not null then product_guid else null end) as unique_product_purchased,
        min(created_at_utc) as session_started_at_utc,
        max(created_at_utc) as session_ended_at_utc,
        timediff(minute, session_started_at_utc, session_ended_at_utc) as session_duration_minutes
    from sessions
    {{ dbt_utils.group_by(1) }}
)
select * from final