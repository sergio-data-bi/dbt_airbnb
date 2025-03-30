{% docs dim__listings_doc %}

# dim__listings

This model provides a curated view of Airbnb listings. It transforms raw listing data into a structured format suitable for analysis.

## Columns

- `listing_id`: Unique identifier for each listing
- `host_id`: Identifier of the host
- `price`: Price per night
- Additional metadata such as location, availability, and property type

## Purpose

This model acts as a dimension table that enriches downstream models with listing-related attributes such as pricing, host information, and property characteristics. It serves as a foundational reference for analysis involving reviews, guest behavior, and financial metrics.

{% enddocs %}