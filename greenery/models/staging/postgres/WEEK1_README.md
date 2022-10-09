## How many users do we have?
```
select count (distinct user_guid) from dev_db.dbt_kushimokolawole.stg_postgres__users;
```

## On average, how many orders do we receive per hour?
with hourly_orders as (
```
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
with order_per_user as (
select 
    count (a.order_guid) orders, b.user_guid 
from 
    dev_db.dbt_kushimokolawole.stg_postgres__order_items as a
inner join 
    dev_db.dbt_kushimokolawole.stg_postgres__orders as b
on a.order_guid = b.order_guid
group by user_guid
)
select orders as count_of_orders, count (user_guid) as unique_user
from order_per_user
group by 1
order by 1;
```

## On average, how many unique sessions do we have per hour?
```
with hourly_session as (
select
    date_trunc('hour', created_at_utc),
    count (session_guid) as sessioncd 
from 
    dev_db.dbt_kushimokolawole.stg_postgres__events
group by 1
)
select avg(session) average_hourly_session from hourly_session;
```