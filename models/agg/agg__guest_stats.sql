WITH reviews AS (
  SELECT * FROM {{ ref('fct__reviews') }}
),
listings AS (
  SELECT * FROM {{ ref('dim__listings') }}
),
review_intervals AS (
  SELECT
    reviewer_id,
    AVG(diff_days) AS avg_time_between_stays
  FROM (
    SELECT
      reviewer_id,
      DATEDIFF('day',
        LAG(review_date) OVER (PARTITION BY reviewer_id ORDER BY review_date),
        review_date
      ) AS diff_days
    FROM reviews
  ) sub
  WHERE diff_days IS NOT NULL
  GROUP BY reviewer_id
)
SELECT
  r.reviewer_id,
  COUNT(DISTINCT r.listing_id) AS stays,
  AVG(l.price) AS price_per_night,
  ri.avg_time_between_stays
FROM reviews r
LEFT JOIN listings l ON l.listing_id = r.listing_id
LEFT JOIN review_intervals ri ON r.reviewer_id = ri.reviewer_id
GROUP BY r.reviewer_id, ri.avg_time_between_stays