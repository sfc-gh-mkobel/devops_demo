# DEVOPS DEMO

## DEMO Setup Environment

### Local Python env
Make sure you have on your local env Python env

### Snowflake Extension for VS Code
You can run SQL queries against Snowflake in many different ways (through the Snowsight UI, SnowSQL, etc.) but for this Quickstart we'll be using the Snowflake extension for VS Code. For a brief overview of Snowflake's native extension for VS Code, please check out our VS Code Marketplace Snowflake extension page.

### Snowflake CLI
Snowflake CLI is an open-source command-line tool explicitly designed for developer-centric workloads in addition to SQL operations. With Snowflake CLI, developers can create, manage, update, and view apps running on Snowflake across workloads such as Streamlit in Snowflake, the Snowflake Native App Framework, Snowpark Container Services, and Snowpark.

Here we will make use of the CLI to quickly setup a CI/CD pipeline.

### Connecting to Snowflake
Both the VS Code extension and the CLI manage their Snowflake connections in a shared file. Create new file .snowflake/config.toml and add your account identifier, username and password in the corresponding placeholders. Note that the user must have ACCOUNTADMIN privileges. 

Example:
[connections.DEVOPS] 
account=
user=
authenticator = "SNOWFLAKE_JWT"
private_key_path =
role="ACCOUNTADMIN"

Now use these credentials to login with the VS Code extension, by clicking the Snowflake logo in the activity bar to the left of the editor. The dialog should have been pre-filled from the config file. Press "Sign in" and you are good to go.

### Load Data from the Marketplace
Run step 3 from Quickstart: 
[Getting Started with Snowflake DevOps](https://quickstarts.snowflake.com/guide/getting_started_with_snowflake_devops/index.html#3)


### Run Demo Data Setup

Run scripts:
- demo_setup/01_setup_snowflake.sql
- demo_setup/02_harmonize_data.py


## DEMO

### Review Dataset

- We will do basic review over the data
- Explain about the source of data from marketplace
Source of Data:
 - Open file explore_data/review_marketplace_data.sql

Target Of Data
- Table that wil provide me details about vacation spots and will join both source tables

### GIT INTEGRATIONS
- Explain about API INTEGRATION
- Explain about GIT REPOSITORY
- Review the GIT REPOSITORY creation in file /demo_setup/03_git_integration.sql
- Open snowsight and review GIT REPOSITORY object 

### Snowflake CLI
Snowflake CLI tool for developers 
Snowflake CLI overview
```snow git -–help```
```snow git list```

### Database Change Management

- switch to branch dev
- Review scripts in devops directory
- Declarative Pipeline Evolution using create or alter command

#### Declarative Using create or alter command
- Run describe table command in file sql explore_data/validate_results.sql
- Modify table vacation_spots and add new column. Script: devops/schema_level/table_vacation_spots.sql
- Modify tasks and add new new column. Script: devops/schema_level/tasks.sql
- Run the following:
```git Add -A```
```git commit -m "changed table and task```
```git push```
```snow git fetch DEMO_REPO```
```snow git execute @DEMO_REPO/branches/dev/devops```
- Open snowsight/VS and review the change

#### Separate Dev and Prod Environments
- Jinja Templating in Snowflake for separate Environments
- Run the following
```snow git fetch DEMO_REPO```
```snow git execute @DEMO_REPO/branches/main/devops -D "env='prod'" -D "t_vacation_spots_data_retention_days=1"```
- Open snowsight/VS and review the new created objects


### CI/CD Using Git Actions

Review the pipeline 
- Connection secrets
- Git [secrets](https://github.com/sfc-gh-mkobel/devops_demo/settings/secrets/actions)
- 


[Managing Snowflake connections](https://docs.snowflake.com/en/developer-guide/snowflake-cli/connecting/configure-connections)

TBD