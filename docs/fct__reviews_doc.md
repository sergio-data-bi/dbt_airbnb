{% docs fct__reviews_doc %}

# fct__reviews

This model represents the fact table for Airbnb reviews. It combines raw review data with necessary listing references to provide a structured view of guest feedback activity.

## Columns

- `reviewer_id`: Identifier for the guest who left the review
- `listing_id`: Associated listing ID
- `review_date`: Timestamp of the review
- `comments`: Free-text guest feedback

## Purpose

The reviews fact model supports analytics related to guest satisfaction, review frequency, and listing-level feedback patterns. It provides a base for aggregations and guest-centric transformations.

{% enddocs %}