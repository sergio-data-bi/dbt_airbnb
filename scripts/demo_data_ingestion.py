import pandas as pd
import requests
import io
import duckdb

SEED_CSV_PATH = "../seeds/demo_extractions.csv"
DUCKDB_DATABASE_PATH = "../dev.duckdb"
SCHEMA = "raw"

tables = {
    "data_listings": {"type": "data", "category": "listings"},
    "data_reviews": {"type": "data", "category": "reviews"},
    "data_hosts": {"type": "data", "category": "hosts"},
    "visualisations_listings": {"type": "visualisations", "category": "listings"}
}


def extraction_from_record(record):
    url = (
        f"https://data.insideairbnb.com/"
        f"{record['country']}/"
        f"{record['region']}/"
        f"{record['city']}/"
        f"{record['extraction_date']}/"
        f"{record['type']}/"
        f"{record['category']}.{record['extension']}"
    )
    response = requests.get(url)
    response.raise_for_status()
    return pd.read_csv(
        io.BytesIO(response.content),
        compression="gzip" if record["extension"] == "csv.gz" else None
    )


def demo_extraction_to_duckdb():
    records = pd.read_csv(SEED_CSV_PATH)
    conn = duckdb.connect(database=DUCKDB_DATABASE_PATH)
    conn.execute(f"CREATE SCHEMA IF NOT EXISTS {SCHEMA}")
    for table in tables:
        print(f"Processing {table}")
        type_idx = records["type"] == tables[table]["type"]
        category_idx = records["category"] == tables[table]["category"]
        filtered_records = records[type_idx & category_idx].to_dict(orient="records")
        dfs = list(map(extraction_from_record, filtered_records))
        df = pd.concat(dfs, ignore_index=True)
        conn.register('df_view', df)
        conn.execute(f'DROP TABLE IF EXISTS {SCHEMA}.{table}')
        conn.execute(f'CREATE TABLE IF NOT EXISTS {SCHEMA}.{table} AS SELECT * FROM df_view')
    conn.close()


if __name__ == "__main__":
    demo_extraction_to_duckdb()
