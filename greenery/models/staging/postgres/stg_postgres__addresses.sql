with address_source as (
    select * from {{ source ('src_greenery', 'addresses') }}
),
recasted_address as (
    select
        ADDRESS_ID as address_guid,
        ADDRESS as address,
        ZIPCODE as zipcode,
        STATE as state,
        COUNTRY as country
    from
        address_source
)
select * from recasted_address