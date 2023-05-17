-- issues.sql

-- Define the dbt model
{{ config(materialized='table') }}

-- Check if the destination table already exists
WITH table_check AS (
  SELECT COUNT(*) AS table_exists
  FROM information_schema.tables
  WHERE table_schema = 'ANALYTICS.ACCOUNT1'
    AND table_name = 'ISSUES'
),

-- Generate the destination table schema dynamically
schema AS (
  SELECT generate_schema(
    'ANALYTICS.ACCOUNT1.ISSUES',
    (
      SELECT OBJECT_KEYS(_airbyte_data) AS keys
      FROM RAW.ACCOUNT1._AIRBYTE_RAW_ISSUES
      LIMIT 1
    )
  ) AS schema_sql
),

-- Create a temporary table with the generated schema
temp_table AS (
  SELECT *
  FROM {{ schema.schema_sql }} -- Update this line
  LIMIT 0
),

-- Create the destination table by selecting from the temporary table
create_table AS (
  SELECT *
  FROM temp_table
  LIMIT 0
)

-- Conditionally create the destination table
SELECT *
FROM (
  SELECT *
  FROM create_table
) ct
WHERE (
  (SELECT table_exists FROM table_check) = 0
)
