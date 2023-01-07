{{ config(
  materialized='table'
) }}

select
  case
    when vendor_id = 1 then 'Creative Mobile Technologies'
    when vendor_id = 2 then 'VeriFone Inc.'
  else 'Unknown' end as vendor_name,
  pickup_datetime,
  dropoff_datetime,
  passenger_count,
  trip_distance_miles,
  pickup_location.service_zone as pickup_location_service_zone,
  pickup_location.zone as pickup_location_zone,
  pickup_location.borough as pickup_location_borough,
  dropoff_location.service_zone as dropoff_location_service_zone,
  dropoff_location.zone as dropoff_location_zone,
  dropoff_location.borough as dropoff_location_borough,
  case
    when rate_code_id = 1 then 'Standard rate'
    when rate_code_id = 2 then 'JFK'
    when rate_code_id = 3 then 'Newark'
    when rate_code_id = 4 then 'Nassau or Westchester'
    when rate_code_id = 5 then 'Negotiated fare'
    when rate_code_id = 6 then 'Group ride'
  else 'Unknown' end as rate_type,
  case
    when store_and_fwd_flag = 'Y' then true
    when store_and_fwd_flag = 'N' then false
  else null end as is_store_forward_trip,
  case
    when payment_type_id = 1 then 'Credit card'
    when payment_type_id = 2 then 'Cash'
    when payment_type_id = 3 then 'No charge'
    when payment_type_id = 4 then 'Dispute'
    when payment_type_id = 5 then 'Unknown'
    when payment_type_id = 6 then 'Voided trip'
  else 'Unknown' end as payment_type,
  fare_amount,
  extra_charges_amount,
  mta_tax_amount,
  improvement_surcharge_amount,
  tip_amount,
  tolls_amount,
  total_amount,
  congestion_surcharge_amount,
  airport_fee_amount
from
  {{ ref('stg_yellow_tripdata') }} as trip_data
left join
  {{ ref('stg_taxi_zone_lookup') }} as pickup_location
on
  trip_data.pickup_location_id = pickup_location.location_id
left join
  {{ ref('stg_taxi_zone_lookup') }} as dropoff_location
on
  trip_data.dropoff_location_id = dropoff_location.location_id
