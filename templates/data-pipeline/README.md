# Data Pipeline Template

This is a specialized Kiro CLI template for data pipeline projects.

## Installation

From your project root:
```bash
git clone https://github.com/trezero/kiroTemplate.git temp
cd temp
./templates/data-pipeline/install-kiro-template.sh
cd ..
rm -rf temp
```

## Customizations

This template includes:
- **Data processing agents** - ETL operations, data validation, transformation
- **Pipeline workflow management** - Orchestration, scheduling, monitoring
- **Database integration** - Connection management, query optimization
- **Monitoring and alerting** - Performance tracking, error handling
- **MCP Servers** - Context7, Database tools, Monitoring tools

## Specialized Agents

- `data-processing` - Handle ETL operations and data transformations
- `pipeline-workflow` - Manage pipeline orchestration and scheduling
- `data-validation` - Ensure data quality and integrity
- `monitoring` - Track performance and handle alerts
- `database-management` - Optimize queries and manage connections

## Technology Support

- **Languages:** Python, SQL, Scala, Java
- **Frameworks:** Apache Airflow, Prefect, Dagster, Apache Spark
- **Databases:** PostgreSQL, MySQL, MongoDB, Redis, ClickHouse
- **Cloud:** AWS (S3, Redshift, Glue), GCP (BigQuery, Dataflow), Azure (Data Factory)
