## Overview

This repository contains dbt scripts transforming Yellow Taxi trip data and instructions how to ingest data.

## How to use?

### Setup Data Ingestion

Following instructions provide details how to setup Extract Load (EL) process of syncing data from Text Files provided by nyc.gov website.

#### Deploying Airbyte Locally
Prequisite: docker installed on your computer locally.

First step is to deploy Airbyte for Extract Load (EL) of data locally.
This can be done by running the following commands:

```
git clone https://github.com/airbytehq/airbyte.git
cd airbyte
docker-compose up
```
In your browser, just visit http://localhost:8000

You will be asked for a username and password. By default, that's username airbyte and password password. Once you deploy airbyte to your servers, be sure to change these:
```
# Proxy Configuration
# Set to empty values, e.g. "" to disable basic auth
BASIC_AUTH_USERNAME=your_new_username_here
BASIC_AUTH_PASSWORD=your_new_password_here
```

#### Setup BigQuery Destination

First we will start by setting up BigQuery as your destination. For this first you will need to create a service account on your BigQuery project and download service account key as JSON file.

Once done, setup your destination source by inputing:
1. Project ID
2. Dataset location
3. Default Dataset ID (for writing in your raw data)
4. Paste your service account key into "Service Account Key JSON" field

The rest of the settings can be left default.

For further details please see screenshot below:
![Alt text](/screenshots/bigquery_destination_setup.png?raw=true "BigQuery Destination Setup")

#### Setup Text File Sources

Next we will setup 2 new Sources. Starting with Yellow Trip data. Just go to Sources tab and chose "Text File" as source type.

Input the following:
1. Source Name: we will use `Yellow Trip Data` as source name
2. URL: we will be using 2019 December data so input following URL: https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2019-12.parquet
3. File Format: `parquet`
4. Dataset Name: we will use `yellow_tripdata`
5. Reader Options: we will use `pyarrow` as engine, so input `{'engine':"pyarrow"}`

Once done Save Changes and Test your datasource to make sure it is working fine.

Your final setup should look like this:
![Alt text](/screenshots/yellow_tripdata_source_setup.png?raw=true "Yellow Trip Data Source Setup")

Next we will setup Taxi Destination Lookup table as another source. This table will be needed to lookup `location_id` to specific location names.

Input the following:
1. Source Name: we will use `Taxi Zone Lookup` as source name
2. URL: we will be using Taxi Zone Lookup Table (CSV) as our source so input following URL: https://d37ci6vzurychx.cloudfront.net/misc/taxi+_zone_lookup.csv
3. File Format: `csv`
4. Dataset Name: we will use `taxi_zone_lookup`

Your final Taxi Zone Lookup source setup should look like this:
![Alt text](/screenshots/taxi_destinations_source_setup.png?raw=true "Taxi Zone Lookup Source Setup")

Once you have your Destination and Sources Setup, simply setup 2 separate Syncs (Connections). These can later be scheduled using CRON or simply to be updated every N hours. Your final setup should look something like this (for manual data syncs):
![Alt text](/screenshots/syncs_setup.png?raw=true "Sync Connections Setup")

#### Run Data Syncs

Once you have everything setup simply run data syncs. Once you run them Airbyte will provide all necessary statistics of how data was loaded, such as:
1. Size of data processed
2. Number of records emitted
3. Number of records commited
4. Runtime
5. Detailed logs of how data was loaded (see screenshot below)

![Alt text](/screenshots/syncs_logs.png?raw=true "Sync Run Log")

### Data Transformations, Documentation & Testing

All data transformations, documentations and testing is handled by dbt.

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

#### Setup dbt

dbt can be setup by running pip command for specific adapter. In our case we will be using BigQuery as our database:

`pip install dbt-bigquery`

dbt configuration resides in your user directory called, folder called `.dbt`

You will need to edit `profiles.yml` file to link it to your BigQuery project. Please see example below:
![Alt text](/screenshots/profiles_configuration.png?raw=true "dbt profiles.yml Configuration")

folder `macros` contains various reusable macros. Internal folder `udf` contains user defined function definitions. Function macros are called in `macros/create_udfs.sql` file, which is executed before running dbt. This is why when defining custom function, you must use `CREATE OR REPLACE FUNCTION...` or `CREATE FUNCTION ... IF NOT EXISTS`.

folder `models` contains model definitions. Internal folder `staging` contains tables that parse and structurize raw data, coming mostly from `bi_airbyte` dataset. Internal folder `marts` contain finalized models.

folder `tests` contains custom dbt tests. More info: [link](https://docs.getdbt.com/docs/building-a-dbt-project/tests#singular-tests)
