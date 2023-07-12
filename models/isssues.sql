-- issues.sql

-- Define the dbt model
{{ config(materialized='table') }}

SELECT
    TO_TIMESTAMP_TZ(_AIRBYTE_DATA:created::string, 'YYYY-MM-DD"T"HH24:MI:SS.FFTZHTZM') AS created_at,
    TO_TIMESTAMP_TZ(_AIRBYTE_DATA:updated::string, 'YYYY-MM-DD"T"HH24:MI:SS.FFTZHTZM') AS updated_at,
    _AIRBYTE_DATA:id::integer as id,
    _AIRBYTE_DATA:key::string as name,
    _AIRBYTE_DATA:self::string as url,
    _AIRBYTE_DATA:fields:summary::string as summary,
    _AIRBYTE_DATA:fields:status:name::string as status,
    _AIRBYTE_DATA:fields:reporter:emailAddress::string as reporter,
    _AIRBYTE_DATA:fields:project:name::string as project_name,
    _AIRBYTE_DATA:fields:project:id::integer as project_id,
    _AIRBYTE_DATA:fields:priority:name::string as priority,
    _AIRBYTE_DATA:fields:labels::ARRAY as labels,
    _AIRBYTE_DATA:fields:issuetype:name::string as issue_type,
    _AIRBYTE_DATA:fields:creator:emailAddress::string as creator,
    _AIRBYTE_DATA:fields:comment:comments::ARRAY as comments,
    _AIRBYTE_DATA:fields:assignee:emailAddress::string as assignee
FROM
  jira._airbyte_raw_issues
