
SELECT * FROM oag_flight_emissions_data_sample.public.estimated_emissions_schedules_sample LIMIT 100;
SELECT * FROM oag_flight_status_data_sample.public.flight_status_latest_sample LIMIT 100;
SELECT * FROM global_weather__climate_data_for_bi.standard_tile.forecast_day LIMIT 100;
SELECT * FROM global_government.cybersyn.datacommons_timeseries LIMIT 100;
SELECT * FROM us_addresses__poi.cybersyn.point_of_interest_index LIMIT 100;



SELECT *
FROM TABLE(DEVOPS_DEMO_COMMON.INFORMATION_SCHEMA.TASK_HISTORY(
    SCHEDULED_TIME_RANGE_START=>DATEADD('DAY',-1,CURRENT_TIMESTAMP()),
    RESULT_LIMIT => 100))
ORDER BY SCHEDULED_TIME DESC;


select * from gold_prod_db.gold.vacation_spots limit 10;

select * from DEVOPS_DEMO_COMMON.SILVER.weather_joined_with_major_cities limit 10;
select * from DEVOPS_DEMO_COMMON.silver.flights_from_home flight limit 10;

select *
    from DEVOPS_DEMO_COMMON.silver.flights_from_home flight
    join DEVOPS_DEMO_COMMON.silver.weather_joined_with_major_cities city on city.geo_name = flight.arrival_city;



