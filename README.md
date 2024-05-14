# Product_Data_Analyst_Assignment
Product_Data_Analyst_Assignment for tryloop.ai
Analyzing the Impact of Business Hour Mismatch on Order Volume in the Food Delivery Industry: A Case Study of UEats and Ghub
Prompt

It is important for a store to have consistent business hours across all food delivery platforms to avoid operational inconsistencies.
If a store's business hours on one platform do not match the hours listed on another platform, it can create potential problems.
Ensuring that a store's business hours are the same across all food delivery platforms is a key operational metric.
Example of business hours in Doordash

<img width="820" alt="doordash" src="https://github.com/SaathvikaSrinath/Product_Data_Analyst_Assignment/assets/122283568/a4901113-85dc-4703-acab-fc72cab623ff">

Goal

The goal of this interview is to come up with a query to understand differences in the business hours for a store across all platforms. You will compute a metric called business hour mismatch between a store on Grubhub and a store on UberEats

For this problem statement, we will only focus on Grubhub and UberEats.

Write a SQL query/set of queries that
Computes Business Hours Mismatch between a restaurant on two platforms. For the sake of simplicity, we will assume UberEats as the ground truth. We will then try to find the issues in Grubhub store hours.
Identify if Grubhub Hours are within the range of UberEats hours (column:is_out_of_range: “In Range”, “Out of Range with 5 mins difference”, “Out of Range”)
Computing Business Hour Mismatch
Data

Note all the data is sample data available in BigQuery. (To view the data, open your personal BigQuery console and run these queries).

UberEats	SELECT * FROM arboreal-vision-339901.take_home_v2.virtual_kitchen_ubereats_hours LIMIT 1000;
Grubhub	SELECT * FROM arboreal-vision-339901.take_home_v2.virtual_kitchen_grubhub_hours LIMIT 1000;
Note: The (b_name,vb_name) tuple can be used as a key to identify the same store and join across the two tables.

Input

Uber Eats Business Hours

Take the first key value pair in the menu dictionary and the first section and assume that as the store business hours.

Note: daysBitArray starts with Monday and indicates the days of the week for this time window is applicable. The might be more than element in the regularHours array.


UberEats

Grubhub Business Hours

Grubhub

Virtual Restaurant ID (slug)	JSON response (response)	Link to Block
johnspizz_sicilianpi_gh	SELECT response FROM arboreal-vision-339901.take_home_v2.virtual_kitchen_grubhub_hours LIMIT 1000;	
GrubHub
<img width="431" alt="ghub_schema" src="https://github.com/SaathvikaSrinath/Product_Data_Analyst_Assignment/assets/122283568/69a65ee5-e6b8-4ba6-bb37-9a32310970b6">
Output

Grubhub slug	Virtual Restuarant Business Hours	Uber Eats slug	Uber Eats Business Hours	is_out_range (expected output)
In Range
Out of Range
Out of Range with 5 mins difference between GH and UE
Submission instructions

Send us a SQL or sets of SQL that ouputs data in this format.
Tips
Please use your personal BigQuery, it is free. ( https://cloud.google.com/bigquery/public-data/ ⇒ click on Go to analytics hub , https://cloud.google.com/blog/products/data-analytics/query-without-a-credit-card-introducing-bigquery-sandbox , https://towardsdatascience.com/bigquery-without-a-credit-card-discover-learn-and-share-199e08d4a064 )

<img width="1207" alt="bigquery" src="https://github.com/SaathvikaSrinath/Product_Data_Analyst_Assignment/assets/122283568/d930458e-1d1b-4064-aa17-b6533fc054f3">

You can view the data once you open BigQuery and run from this table.

Please use json parsing and do not use regex.

There is a way to write the SQL without brute forcing all day combinations etc, we would strongly prefer that.

Some starting point that might help https://stackoverflow.com/questions/34890339/how-to-extract-all-the-keys-in-a-json-object-with-bigquery
Slug is a unique idenfitier for a store

If there are multiple entries for a store, use the one with the latest timestamp.

You can use unnest to flatten business hours array in JSON
