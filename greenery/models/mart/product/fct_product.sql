with product as (
    select * from {{ ref('stg_postgres__products') }}
),
events as (
    select * from {{ ref('stg_postgres__events') }}
),
order_item as (
    select * from {{ ref('stg_postgres__order_items') }}
),
final as (
    select
      {{ idempotent_key(['product_guid', 'product_name'], 'a') }} product_unique_key,
      a.product_guid,
      a.product_name,
      a.product_price,
      a.product_inventory,
      count (distinct c.order_guid) as order_per_product,
      count (distinct b.event_guid) as events_per_product
    from
        product as a
        left join events as b on a.product_guid=b.product_guid
        left join order_item as c on a.product_guid=c.product_guid
        {{ dbt_utils.group_by(5) }}
)
select * from final