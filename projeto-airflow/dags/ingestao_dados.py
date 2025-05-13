import pandas as pd
from sqlalchemy import create_engine
from datetime import datetime
import os

# Conexões com os bancos
src_engine = create_engine("postgresql+psycopg2://postgres:postgres@host.docker.internal:5432/dbinterview")
dst_engine = create_engine("postgresql+psycopg2://postgres:postgres@host.docker.internal:5432/landing_db")

# Tabelas com carga completa
full_tables = [
    'actor', 'actor_info', 'customer_list', 'film_list', 'nicer_but_slower_film_list',
    'sales_by_film_category', 'store', 'sales_by_store', 'staff_list', 'address',
    'category', 'city', 'country', 'customer', 'film_actor', 'film_category',
    'inventory', 'language', 'staff', 'film'
]

# Tabelas com CDC
cdc_tables = {
    'rental': 'last_update',
    'payment': 'payment_date'
}

# Pasta para armazenar últimos timestamps processados
cdc_tracking_path = 'cdc_tracking'
os.makedirs(cdc_tracking_path, exist_ok=True)

# Carga completa com TRUNCATE
for table in full_tables:
    print(f"Fazendo carga completa da tabela: {table}")
    df = pd.read_sql(f"SELECT * FROM {table}", src_engine)

    # Executa TRUNCATE com CASCADE
    with dst_engine.begin() as conn:
        conn.execute(f'TRUNCATE TABLE {table} CASCADE')

    df.to_sql(table, dst_engine, index=False, if_exists='append', method='multi')

# Carga incremental com CDC
for table, timestamp_column in cdc_tables.items():
    print(f"Fazendo CDC da tabela: {table}")

    track_file = os.path.join(cdc_tracking_path, f"{table}_last.txt")

    if os.path.exists(track_file):
        with open(track_file, 'r') as f:
            last_ts = f.read().strip()
        query = f"""
            SELECT * FROM {table}
            WHERE {timestamp_column} > '{last_ts}'
        """
    else:
        query = f"SELECT * FROM {table}"

    df = pd.read_sql(query, src_engine)

    if not df.empty:
        df.to_sql(table, dst_engine, index=False, if_exists='append', method='multi')
        new_ts = df[timestamp_column].max()
        with open(track_file, 'w') as f:
            f.write(str(new_ts))
