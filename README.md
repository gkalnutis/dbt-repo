## Overview

This repository contains dbt scripts transforming Yellow Taxi trip data and instructions how to ingest data.

## How to use?

### Deploying Airbyte Locally
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

### Setup BigQuery Destination

First we will start by setting up BigQuery as your destination. For this first you will need to create a service account on your BigQuery project and download service account key as JSON file.

Once done, setup your destination source by inputing:
1. Project ID
2. Dataset location
3. Default Dataset ID (for writing in your raw data)
4. Paste your service account key into "Service Account Key JSON" field

The rest of the settings can be left default.

For further details please see screenshot below:
![Alt text](/screenshots/bigquery_destination_setup.png?raw=true "Optional Title")

### Setup Text File Sources



Then write instructions how to setup Text files as data sources:
include screenshots as well:

if you use Markdown (README.md):

Provided that you have the image in your repo, you can use a relative URL:

![Alt text](/relative/path/to/img.jpg?raw=true "Optional Title")
If you need to embed an image that's hosted elsewhere, you can use a full URL

![Alt text](http://full/path/to/img.jpg "Optional title")

### Structure

folder `macros` contains various reusable macros. Internal folder `udf` contains user defined function definitions. Function macros are called in `macros/create_udfs.sql` file, which is executed before running dbt. This is why when defining custom function, you must use `CREATE OR REPLACE FUNCTION...` or `CREATE FUNCTION ... IF NOT EXISTS`.

folder `models` contains model definitions. Internal folder `staging` contains tables that parse and structurize raw data, coming mostly from `bi_airbyte` dataset. Internal folder `marts` contain finalized models.

folder `tests` contains custom dbt tests. More info: [link](https://docs.getdbt.com/docs/building-a-dbt-project/tests#singular-tests)

CODE EXAMPLE
```
[sqlfluff:rules:L052]
multiline_newline = False
require_final_semicolon = False
```

## DBT Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
