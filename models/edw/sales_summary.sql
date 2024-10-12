-- models/sales_summary.sql
{{ config(
    materialized='table'
) }}

WITH customer_data AS (
    SELECT * FROM {{ ref('customer') }}
),
nation_data AS (
    SELECT * FROM {{ ref('nation') }}
),
order_data AS (
    SELECT * FROM {{ ref('orders') }}
)

    SELECT
        n.n_name AS region_name,  -- Region name from the nation table
        SUM(o.o_totalprice) AS sum_orders  -- Total price from the orders table
    FROM
        order_data o  -- Orders table
    JOIN
        customer_data c ON c.c_custkey = o.o_custkey  -- Join with customer
    JOIN
        nation_data n ON n.n_nationkey = c.c_nationkey  -- Join with nation
    GROUP BY
        n.n_name  -- Group by region name
