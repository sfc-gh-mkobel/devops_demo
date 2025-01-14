# devops_demo


## Create and Connect a Git Repository

```sql
USE ROLE ACCOUNTADMIN;

CREATE OR ALTER DATABASE DEVOPS_COMMON;


CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/sfc-gh-mkobel')
  ENABLED = TRUE;

CREATE OR REPLACE GIT REPOSITORY DEVOPS_COMMON.public.devops_demo_repo
  API_INTEGRATION = git_api_integration
  ORIGIN = 'https://github.com/sfc-gh-mkobel/devops_demo';
```


## Demo Steps
### Snowflake CLI
Snow git -–help

Present a create_or_alter table python script
Modify the table - ad new column
From terminal run:
Git add && git commit -m “object changes”
Git push
Snow git list
Snow git fetch git_repoi
Snow get execute @git_repo/branches/demo_branch/devops -D “env=’dev’”
View Results
Open table in snowsight or vs code


Python and SQL to manage snowflake objects
Git integrations
Database Change Management -  CREATE OR ALTER command 
Separate Dev and Prod Environments - Jinja Templating in Snowflake
Deployment Automation - CI/CD pipeline


  