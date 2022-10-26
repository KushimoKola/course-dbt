with sessions as (
    select * from {{ ref('int_sessions_order_v1') }}
),
int_sessions_order_v2 as (
    select * from {{ ref('int_sessions_order_v2')}}
),
orders as (
    select distinct
        session_guid,
        count(distinct order_guid) as order_count
    from sessions
    {{ dbt_utils.group_by(1) }}
),
final as (
    select distinct
        a.session_guid,
        c.order_count,

        b.page_view_count,
        b.add_to_cart_count,
        b.package_shipped_count,

        b.unique_product_viewed,
        b.unique_product_purchased,

        b.session_duration_minutes

    from sessions as a
    left join int_sessions_order_v2 as b on a.session_guid = b.session_guid
    left join orders as c on a.session_guid = c.session_guid
)
select * from final