with users_source as (
    select * from {{ source ('src_greenery', 'users') }}
),
recasted_user as (
    select
        user_id as user_guid,
        first_name,
        last_name,
        phone_number,
        email,
        created_at::timestampntz as created_at_utc,
        updated_at::timestampntz as updated_at_utc,
        address_id as address_guid
    from
        users_source
)
select * from recasted_user