use role accountadmin;

-- declarative target table of pipeline
create or alter table gold_dev_db.gold.vacation_spots (
    city varchar
  , airport varchar
  , co2_emissions_kg_per_person float
  , punctual_pct float
  , avg_relative_humidity_pct float
  , avg_cloud_cover_pct float
  , precipitation_probability_pct float
  , avg_temperature_air_f float
) data_retention_time_in_days = 0;

