with event_source as (
    select * from {{ source ('src_greenery', 'events') }}
),
recasted_event as (
    select
        EVENT_ID as event_guid,
        SESSION_ID as session_guid,
        USER_ID as user_guid,
        PAGE_URL as page_url,
        CREATED_AT as created_at_utc,
        EVENT_TYPE as event_type,
        ORDER_ID as order_guid,
        PRODUCT_ID as product_guid
    from
        event_source
)
select * from recasted_event