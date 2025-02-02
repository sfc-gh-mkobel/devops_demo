from snowflake.core import Root
from snowflake.snowpark import Session
from snowflake.core.warehouse import Warehouse


root = Root(Session.builder.getOrCreate())

ingest_wh = Warehouse(name="analyze_wh")
ingest_wh.warehouse_size = "SMALL"
ingest_wh.auto_suspend = 120
ingest_wh.initially_suspended = "true"

root.warehouses["analyze_wh"].create_or_alter(ingest_wh)
