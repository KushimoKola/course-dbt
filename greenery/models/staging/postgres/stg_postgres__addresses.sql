with address_source as (
    select * from {{ source ('src_greenery', 'addresses') }}
),
recasted_address as (
    select
        address_id as address_guid,
        address,
        zipcode::string as zipcode,
        state,
        country
    from
        address_source
)
select * from recasted_address