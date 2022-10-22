with orders as (
    select * from {{ ref('int_order_details') }}
),
final as (
    select
        order_guid,
        user_guid,
        product_guid,
        tracking_guid,
        promo_desc,
        case when promo_desc is null then false else true end is_promo,
        order_created_at_utc,
        order_quantity,
        order_cost,
        order_status,
        zeroifnull(promo_discount) as promo_discount,
        promo_status,
        shipping_cost,
        order_total_cost,
        shipping_service,
        order_estimated_delivery_at_utc,
        order_delivered_at_utc,
        timediff(hour, created_at_utc, estimated_delivery_at_utc) as estimated_hours_to_delivery,
        timediff(hour, created_at_utc, delivered_at_utc) as actual_hours_to_delivery,
        timediff(hour, estimated_delivery_at_utc, delivered_at_utc) as hour_to_delivery_delay
    from
        orders
)
select * from final