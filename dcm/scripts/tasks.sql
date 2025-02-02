-- task to merge pipeline results into target table

USE SCHEMA gold_dev_db.gold;


create or alter task vacation_spots_update
  schedule = '1440 minute'
  warehouse = 'analyze_wh'
  ERROR_ON_NONDETERMINISTIC_MERGE = false
  AS MERGE INTO vacation_spots USING (
    select *
    from DEVOPS_DEMO_COMMON.silver.flights_from_home flight
    join DEVOPS_DEMO_COMMON.silver.weather_joined_with_major_cities city on city.geo_name = flight.arrival_city
    -- STEP 5: INSERT CHANGES HERE
  ) as harmonized_vacation_spots ON vacation_spots.city = harmonized_vacation_spots.arrival_city and vacation_spots.airport = harmonized_vacation_spots.arrival_airport
  WHEN MATCHED THEN
    UPDATE SET
        vacation_spots.co2_emissions_kg_per_person = harmonized_vacation_spots.co2_emissions_kg_per_person
      , vacation_spots.punctual_pct = harmonized_vacation_spots.punctual_pct
      , vacation_spots.avg_relative_humidity_pct = harmonized_vacation_spots.avg_relative_humidity_pct
      , vacation_spots.avg_cloud_cover_pct = harmonized_vacation_spots.avg_cloud_cover_pct
      , vacation_spots.precipitation_probability_pct = harmonized_vacation_spots.precipitation_probability_pct
      , vacation_spots.avg_temperature_air_f = harmonized_vacation_spots.avg_temperature_air_f
  WHEN NOT MATCHED THEN 
    INSERT VALUES (
        harmonized_vacation_spots.arrival_city
      , harmonized_vacation_spots.arrival_airport
      , harmonized_vacation_spots.co2_emissions_kg_per_person
      , harmonized_vacation_spots.punctual_pct
      , harmonized_vacation_spots.avg_relative_humidity_pct
      , harmonized_vacation_spots.avg_cloud_cover_pct
      , harmonized_vacation_spots.precipitation_probability_pct
      , harmonized_vacation_spots.avg_temperature_air_f
    );


-- task to select perfect vacation spot and send email with vacation plan
-- NOTE: NOT ALL CORTEX ML MODELS MAY BE AVAILABLE ON ALL DEPLOYMENTS
create or alter task email_notification
  warehouse = 'analyze_wh'
  after vacation_spots_update
  as 
    begin
      let options varchar := (
        select to_varchar(array_agg(object_construct(*)))
        from vacation_spots
        where true
          and punctual_pct >= 50
          and avg_temperature_air_f >= 70
          -- STEP 5: INSERT CHANGES HERE
        limit 10);


      if (:options = '[]') then
        CALL SYSTEM$SEND_EMAIL(
            'email_integration',
            'meny.kobel@snowflake.com', -- INSERT YOUR EMAIL HERE
            'New data successfully processed: No suitable vacation spots found.',
            'The query did not return any results. Consider adjusting your filters.');
      end if;

      let query varchar := 'Considering the data provided below in JSON format, pick the best city for a family vacation in summer?
      Explain your choise, offer a short description of the location and provide tips on what to pack for the vacation considering the weather conditions? 
      Finally, could you provide a detailed plan of daily activities for a one week long vacation covering the highlights of the chosen destination?\n\n';
      
      let response varchar := (SELECT SNOWFLAKE.CORTEX.COMPLETE('mistral-7b', :query || :options));

      CALL SYSTEM$SEND_EMAIL(
        'email_integration',
        'meny.kobel@snowflake.com', -- INSERT YOUR EMAIL HERE
        'New data successfully processed: The perfect place for your summer vacation has been found.',
        :response);
    exception
        when EXPRESSION_ERROR then
            CALL SYSTEM$SEND_EMAIL(
            'email_integration',
            'meny.kobel@snowflake.com', -- INSERT YOUR EMAIL HERE
            'New data successfully processed: Cortex LLM function inaccessible.',
            'It appears that the Cortex LLM functions are not available in your region');
    end;


-- resume follow-up task so it is included in DAG runs
-- don't resume the root task so the regular schedule doesn't get invoked
alter task email_notification resume;


-- manually initiate a full execution of the DAG
execute task vacation_spots_update;