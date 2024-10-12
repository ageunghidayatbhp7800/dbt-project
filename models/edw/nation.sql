{{ config(
    materialized='table'
) }}

SELECT *
FROM {{ source('STG', 'nation') }}