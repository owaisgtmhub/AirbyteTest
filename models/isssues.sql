-- issues.sql

-- Define the dbt model
{{ config(materialized='table') }}

select
    _AIRBYTE_DATA['created'] as created_at
from raw.account1._airbyte_raw_issues

