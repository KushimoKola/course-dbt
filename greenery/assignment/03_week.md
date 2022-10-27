# Part One
- What is our overall conversion rate?
  - `Total conversion rate = 62.4567`
```
with conversation_rate as (
select
    count(distinct session_guid)  as unique_sessions,
    count(distinct order_guid)    as unique_orders,
    (unique_orders/unique_sessions) * 100       as conversion_rate
from int_sessions_order_v1
    )
select * from conversation_rate;
```
- What is our conversion rate by product?
```
with conversation_rate_by_product as (
select
    a.product_guid,
    product_name,
    count(distinct session_guid)  as unique_sessions,
    count(distinct order_guid)    as unique_orders,
    (unique_orders/unique_sessions) * 100 as product_conversion_rate
from int_sessions_order_v1 as a
    join fct_product as b on a.product_guid = b.product_guid
    group by 1,2
    )
select
    product_name, 
    product_conversion_rate
from
    conversation_rate_by_product
    order by 2 desc;
    ```
