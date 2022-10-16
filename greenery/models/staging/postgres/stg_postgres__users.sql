with users_source as (
    select * from {{ source ('src_greenery', 'users') }}
),
recasted_user as (
    select
        user_id as user_guid,
        first_name,
        last_name,
        phone_number,
        created_at as created_at_utc,
        uodated_at as updated_at_utc,
        address_id as address_guid
    from
        users_source
)
select * from recasted_user