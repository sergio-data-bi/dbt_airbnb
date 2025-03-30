{% docs agg__guest_stats_doc %}

# agg__guest_stats

This model aggregates review activity at the guest level, offering a guest-centric summary of behavior and engagement across listings.

## Columns

- `reviewer_id`: Unique identifier for each guest
- `price_per_night`: Average nightly price paid across all reviewed stays
- Other derived metrics such as total number of reviews or average review frequency

## Purpose

This model supports segmentation and profiling of guests for use in personalization, retention analysis, and revenue forecasting. It serves as a bridge between raw review activity and higher-level guest behavior insights.

{% enddocs %}