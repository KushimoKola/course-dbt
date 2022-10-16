## How many users do we have?
```
select count (distinct user_guid) from dev_db.dbt_kushimokolawole.stg_postgres__users;
```

## On average, how many orders do we receive per hour?
```
with hourly_orders as (
select
    date_trunc('hour', created_at_utc),
    count(distinct order_guid) as orders
from dev_db.dbt_kushimokolawole.stg_postgres__orders
    group by date_trunc('hour', created_at_utc)
)
select avg(orders) as average_hourly_orders from hourly_orders;
``` 

## On average, how long does an order take from being placed to being delivered?

```
with order_created_delivered_diff as (
select 
    datediff(hour, created_at_utc,delivered_at_utc) as time_to_deliver 
from
    dev_db.dbt_kushimokolawole.stg_postgres__orders
)
select avg(time_to_deliver) average_time_to_deliver from order_created_delivered_diff;
```

## How many users have only made one purchase? Two purchases? Three+ purchases?

```
    with order_freq_by_user as (
        -- count orders by user
        select
            user_guid
            , count(order_guid) as order_freq
        from dev_db.dbt_kushimokolawole.stg_postgres__orders
        group by 1
    ),
    user_order_segmentation as (
        -- classify users based on order frequency
        select
            user_guid
            , case
                when order_freq  = 1 then '1'
                when order_freq  = 2 then '2'
                when order_freq >= 3 then '3+'
                else null
            end as order_frequency
        from order_freq_by_user
    )
    -- count freq types
    select 
        order_frequency
        , count(user_guid) as freq_type_count
    from user_order_segmentation
    group by 1
    order by 1;
```

## On average, how many unique sessions do we have per hour?
```
with hourly_session as (
select
    date_trunc('hour', created_at_utc),
    count (distinct session_guid) as session
from 
    dev_db.dbt_kushimokolawole.stg_postgres__events
group by 1
)
select avg(session) average_hourly_session from hourly_session;
```