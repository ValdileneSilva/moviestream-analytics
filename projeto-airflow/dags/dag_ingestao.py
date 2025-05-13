from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=2),
}

with DAG(
    dag_id='pipeline_ingestao_cdc',
    default_args=default_args,
    description='Ingestão completa e CDC para MovieStream DB',
    schedule_interval='@daily',
    start_date=datetime(2024, 1, 1),
    catchup=False,
) as dag:

    ingestao = BashOperator(
        task_id='executa_ingestao',
        bash_command='python /opt/airflow/dags/ingestao_dados.py'
    )

    aciona_dbt = TriggerDagRunOperator(
        task_id='aciona_pipeline_dbt',
        trigger_dag_id='pipeline_dbt'  # precisa bater com o nome da DAG do DBT
    )

    ingestao >> aciona_dbt
