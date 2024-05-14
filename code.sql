-- Importing and exploring Grubhub data
WITH grubhub_data AS (
  SELECT *
  FROM `arboreal-vision-339901.take_home_v2.virtual_kitchen_grubhub_hours`
  LIMIT 100 -- Limiting to 100 records for initial exploration
)

-- Displaying the first 5 records to understand the data structure
SELECT *
FROM grubhub_data
LIMIT 5;

-- Extracting keys from JSON response
CREATE TEMP FUNCTION jsonObjectKeys(input STRING)
RETURNS ARRAY<String>
LANGUAGE js AS """
  return Object.keys(JSON.parse(input));
""";

WITH json_keys AS (
  SELECT DISTINCT key
  FROM grubhub_data,
  UNNEST(jsonObjectKeys(response)) AS key
)

-- Displaying the keys to understand the JSON structure
SELECT *
FROM json_keys;

-- Extracting business hours from the response field
WITH business_hours AS (
  SELECT 
    JSON_EXTRACT_SCALAR(response, '$.availability_by_catalog.STANDARD_DELIVERY.schedule_rules.days_of_week[0]') AS day,
    JSON_EXTRACT_SCALAR(response, '$.availability_by_catalog.STANDARD_DELIVERY.schedule_rules.from') AS open_time,
    JSON_EXTRACT_SCALAR(response, '$.availability_by_catalog.STANDARD_DELIVERY.schedule_rules.to') AS close_time
  FROM grubhub_data
)

-- Displaying the extracted business hours
SELECT *
FROM business_hours;

-- Defining function to extract hours from JSON
CREATE FUNCTION ExtractHours(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  const hours = json.availability_by_catalog.STANDARD_DELIVERY.schedule_rules;
  
  return hours.map(rule => {
    return rule.days_of_week[0] + ':' + 
           rule.from + '-' + 
           rule.to;
  });
""";

-- Extracting hours using the defined function
SELECT
  response,
  ExtractHours(response) AS hours 
FROM grubhub_data;

-- Reviewing schema and retrieving regular hours from UberEats data
SELECT
  JSON_EXTRACT(value, '$.regularHours.startTime') AS start_time,
  JSON_EXTRACT(value, '$.regularHours.endTime') AS end_time
FROM 
  `arboreal-vision-339901.take_home_v2.virtual_kitchen_ubereats_hours`,
  UNNEST(JSON_QUERY_ARRAY(response, '$.data.menus.sections')) AS value
LIMIT 5;
