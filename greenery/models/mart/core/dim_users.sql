with users as (
    select * from {{ ref('stg_postgres__users') }}
),
address as (
    select * from {{ ref('stg_postgres__addresses') }}
)
select
    us.user_guid,
    ad.address_guid,
    us.first_name,
    us.last_name,
    us.phone_number,
    us.email,
    ad.address,
    ad.zipcode,
    ad.state,
    ad.country,
    us.created_at_utc,
    us.updated_at_utc
from
    users as us
    left join address as ad on us.address_guid = ad.address_guid
group by
    us.user_guid,
    ad.address_guid,
    us.first_name,
    us.last_name,
    us.phone_number,
    us.email,
    ad.address,
    ad.zipcode,
    ad.state,
    ad.country,
    us.created_at_utc,
    us.updated_at_utc