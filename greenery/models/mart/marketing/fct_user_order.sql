with dim_users as (
    select * from {{ ref('dim_users') }}
),
fact_orders as (
    select
        user_guid,
        count (order_guid) as total_order,
        sum(order_quantity) as total_order_volume,
        min(order_quantity) as minimum_order_volume,
        max(order_quantity) as maximum_order_volume,
        sum(order_cost) as total_order_value,
        min(order_cost) as minimun_order_value,
        max(order_cost) as maximum_order_value,
        sum(promo_discount) as total_promo_value,
        min(order_created_at_utc) as first_order_created_at,
        max(order_created_at_utc) as latest_order_created_at
    from
        {{ ref('fct_orders') }}
    group by
        user_guid
),
final as (
    select
        a.user_guid,
        first_name,
        last_name,
        phone_number,
        email,
        zipcode,
        state,
        country,
        zeroifnull(total_order) as total_order,
        zeroifnull(total_order_volume) as total_order_volume,
        zeroifnull(minimum_order_volume) as minimum_order_volume,
        zeroifnull(maximum_order_volume) as maximum_order_volume,
        zeroifnull(total_order_value) as total_order_value,
        zeroifnull(minimun_order_value) as minimun_order_value,
        zeroifnull(maximum_order_value) as maximum_order_value,
        zeroifnull(total_promo_value) as total_promo_value,
        created_at_utc as profile_created_at,
        updated_at_utc as profile_updated_at,
        first_order_created_at,
        latest_order_created_at
    from
        dim_users as a
        left join fact_orders as b on a.user_guid = b.user_guid
)
select * from final