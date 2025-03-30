WITH src__listings AS (
  SELECT * FROM {{ ref('src__listings') }}
)

SELECT
  listing_id,
  listing_name,
  host_id,
  CAST(REPLACE(REPLACE(price::text, '$', ''), ',', '') AS DECIMAL(10,2)) AS price
FROM src__listings