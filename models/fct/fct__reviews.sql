{% set start_date = var('start_date', None) %}
{% set end_date   = var('end_date', None) %}

{{
  config(
    materialized='incremental',
    on_schema_change='fail'
  )
}}

WITH src_reviews AS (
  SELECT *
  FROM {{ ref('src__reviews') }}
)

SELECT
  {{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} as review_id,
  *
FROM src_reviews
{% if is_incremental() %}
    WHERE TRUE
  {% if start_date and end_date %}
    {{ log("Loading " ~ this ~ " incrementally (start_date: " ~ start_date ~ ", end_date: " ~ end_date ~ ")", info=True) }}
    AND review_date >= '{{ start_date }}'
    AND review_date < '{{ end_date }}'
  {% else %}
    {{ log("No dates passed. Loading " ~ this ~ " incrementally (from current max review date)", info=True) }}
    AND review_date > (SELECT MAX(review_date) FROM {{ this }})
  {% endif %}
{% endif %}