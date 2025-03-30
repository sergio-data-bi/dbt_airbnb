WITH raw_visualisations_listings AS (
    SELECT * FROM {{ source('airbnb', 'visualisations_listings') }}
)
SELECT
    id
FROM
    raw_visualisations_listings
