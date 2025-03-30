WITH raw_reviews AS (
    SELECT * FROM {{ source('airbnb', 'reviews') }}
)
SELECT
    reviewer_id,
    reviewer_name,
    CAST(date AS DATE) AS review_date,
    comments AS review_text,
    listing_id
FROM
    raw_reviews