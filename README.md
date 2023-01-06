Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices



This repository contains dbt scripts transforming Yellow Taxi trip data.


## How to use?

First write instructions according this guid how to deploy airbyte
https://docs.airbyte.com/deploying-airbyte/local-deployment/

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
