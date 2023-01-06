{{ config(
  materialized='table'
) }}

select
  cast(json_value(_airbyte_data, '$.LocationID') as integer) as location_id,
  json_value(_airbyte_data, '$.service_zone') as service_zone,
  json_value(_airbyte_data, '$.Zone') as zone,
  json_value(_airbyte_data, '$.Borough') as borough
from
  {{source('Airbyte', '_airbyte_raw_taxi_zone_lookup')}}
