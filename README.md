# 📽️ Projeto MovieStream Analytics

Este projeto tem como objetivo simular uma solução de engenharia e modelagem de dados para uma plataforma fictícia de aluguel de filmes — **MovieStream**. Ele cobre desde a ingestão de dados brutos até a geração de indicadores analíticos para suporte à tomada de decisão.

## 📂 Estrutura do Repositório

- `Documento_Tecnico_MovieStream.docx`: Documento técnico completo descrevendo a arquitetura, estratégias de ingestão, modelagem, SQLs analíticas e visualizações.
- `dags/`: DAGs do Apache Airflow para ingestão e execução dos modelos DBT.
- `dbt_project/`: Projeto DBT com modelos `staging` e `marts`.
- `docker-compose.yml`: Composição dos serviços com Airflow, PostgreSQL e DBT.
- `scripts/`: Scripts Python para ingestão com carga total e CDC.
- `requirements.txt`: Dependências do ambiente Python.

## ⚙️ Como executar o projeto

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/seuusuario/moviestream-analytics.git
   cd moviestream-analytics
   ```

2. **Suba os containers:**
   ```bash
   docker compose up --build
   ```

3. **Acesse o Apache Airflow:**
   - URL: `http://localhost:8080`
   - Usuário/Senha: `admin / admin` (caso não tenha sido alterado)

4. **Execute as DAGs:**
   - `pipeline_ingestao_cdc`: Faz a ingestão dos dados da base origem para a landing zone, com CDC nas tabelas `rental` e `payment`.
   - `pipeline_dbt`: Executa os modelos DBT após a ingestão.

5. **Resultados:**
   - As transformações e modelos analíticos estarão disponíveis no banco `landing_db`, schema `public`.

## 📊 Visualizações

O painel de indicadores foi desenvolvido com **Google Looker Studio** e pode ser acessado aqui:

🔗 [Painel no Looker Studio](https://lookerstudio.google.com/reporting/3d7f94bc-7f79-44c0-b7c4-784983ec04cc)

---

## 📄 Documento Técnico

Para detalhes completos sobre a solução (estratégia de CDC, DAGs, modelagem com DBT e SQLs analíticas), consulte o arquivo:

🔗 [Documento técnico](Documento_Tecnico_MovieStream.docx)


---

## 🛠️ Tecnologias Utilizadas

- Python, Pandas, SQLAlchemy
- Apache Airflow
- PostgreSQL
- DBT (Data Build Tool)
- Docker e Docker Compose

---

Feito com 💻 e ☕ para fins educacionais e demonstração técnica.