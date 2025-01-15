from snowflake.core import Root
from snowflake.snowpark import Session
from snowflake.core.warehouse import Warehouse
import os
import toml


PRIVATE_KEY_FILE = os.getenv("SNOWFLAKE_PRIVATE_KEY_FILE")
connection_params= toml.load(".snowflake/config.toml")['connections']['DEVOPS']
connection_params['private_key_file']=PRIVATE_KEY_FILE
session = Session.builder.configs(connection_params).create()
session.sql("USE ROLE ACCOUNTADMIN")
root = Root(session)

ingest_wh = Warehouse(name="analyze_wh")
ingest_wh.warehouse_size = "SMALL"
ingest_wh.auto_suspend = 120
ingest_wh.initially_suspended = "true"

root.warehouses["analyze_wh"].create_or_alter(ingest_wh)
