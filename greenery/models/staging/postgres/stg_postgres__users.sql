with users_source as (
    select * from {{ source ('src_greenery', 'users') }}
),
recasted_user as (
    select
        USER_ID as user_guid,
        FIRST_NAME as first_name,
        LAST_NAME as last_name,
        PHONE_NUMBER as phone_number,
        CREATED_AT as created_at_utc,
        UPDATED_AT as updated_at_utc,
        ADDRESS_ID as address_guid
    from
        users_source
)
select * from recasted_user