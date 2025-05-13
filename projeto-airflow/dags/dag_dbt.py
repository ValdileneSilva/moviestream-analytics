from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2024, 1, 1),
    'retries': 1
}

with DAG(
    dag_id='pipeline_dbt',
    default_args=default_args,
    schedule_interval='@daily',  # ou None para executar apenas manualmente
    catchup=False,
    description='Executa dbt run após ingestão',
    tags=['dbt', 'modelagem']
) as dag:

    executa_dbt = BashOperator(
    task_id='executa_dbt_run',
    bash_command='cd /opt/airflow/dags/moviestream_analytics && dbt run --profiles-dir ./.dbt'
)
