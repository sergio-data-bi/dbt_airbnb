{% docs __overview__ %}
# Welcome to dbt_airbnb

This dbt project transforms raw Airbnb listing data into a guest-centric data model designed for analytics and personalized insights.

## ️ Project Overview

- **Source schema**: `raw`
- **Core models**:
  - `dim__listings`: Listing-level dimensions and pricing
  - `fct__reviews`: Fact table of guest reviews
  - `agg__guest_stats`: Guest-centric aggregated KPIs

##  Purpose
The goal of this project is to reorient the dataset from listing-based records to a guest-first model. This structure better supports:
- Behavioral analysis
- Retention strategies
- Price sensitivity and segmentation


## Demo Data Ingestion
To populate the `raw` schema with demo data, a Python script is provided in this project. It extracts listing, review, host, and visualisation data from Inside Airbnb’s open data portal and loads it into a local DuckDB database.
To run the script:
```bash
python scripts/ingest_airbnb_to_duckdb.py
```
---

Use the navigation tabs on the left to explore source tables, models, and column-level documentation.
{% enddocs %}