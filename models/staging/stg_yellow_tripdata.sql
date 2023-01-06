{{ config(
  materialized='table'
) }}

select
  cast(json_value(_airbyte_data, '$.VendorID') as integer) as vendor_id,
  datetime(json_value(_airbyte_data, '$.tpep_pickup_datetime')) as pickup_datetime,
  datetime(json_value(_airbyte_data, '$.tpep_dropoff_datetime')) as dropoff_datetime,
  cast(json_value(_airbyte_data, '$.passenger_count') as numeric) as passenger_count,
  cast(json_value(_airbyte_data, '$.trip_distance') as numeric) as trip_distance_miles,
  cast(json_value(_airbyte_data, '$.PULocationID') as integer) as pickup_location_id,
  cast(json_value(_airbyte_data, '$.DOLocationID') as integer) as dropoff_location_id,
  cast(json_value(_airbyte_data, '$.RatecodeID') as numeric) as rate_code_id,
  json_value(_airbyte_data, '$.store_and_fwd_flag') as store_and_fwd_flag,
  cast(json_value(_airbyte_data, '$.payment_type') as integer) as payment_type_id,
  cast(json_value(_airbyte_data, '$.fare_amount') as numeric) as fare_amount,
  cast(json_value(_airbyte_data, '$.extra') as numeric) as extra_charges_amount,
  cast(json_value(_airbyte_data, '$.mta_tax') as numeric) as mta_tax_amount,
  cast(json_value(_airbyte_data, '$.improvement_surcharge') as numeric) as improvement_surcharge_amount,
  cast(json_value(_airbyte_data, '$.tip_amount') as numeric) as tip_amount,
  cast(json_value(_airbyte_data, '$.tolls_amount') as numeric) as tolls_amount,
  cast(json_value(_airbyte_data, '$.total_amount') as numeric) as total_amount,
  cast(json_value(_airbyte_data, '$.congestion_surcharge') as numeric) as congestion_surcharge_amount,
  cast(json_value(_airbyte_data, '$.airport_fee') as numeric) as airport_fee_amount
from
  {{source('Airbyte', '_airbyte_raw_yellow_tripdata')}}
limit 1000
