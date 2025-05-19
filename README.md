# Recursive-SQL-CTE-managing-graphs
How to flatten a graph in a SQL table: an example of datamart for Exploring Patterns in Social Networks

This repository contains the SQL scripts used to address the challenge of flattening a graph in a datamart allowing easy SQL code for the  data analysts:
(the scripts have been QAed on Google bigquery interactive environments) 
- **Social User Connections and Distance - 0. Table Setup**: loads the social_users and social_network tables with random data
-  **Social User Connections and Distance - 1.1 Datamart**: loads all paths in the core table **social_DM_paths**
-  **Social User Connections and Distance - 1.1 Datamart**: transforms, or better integrates, and loads the user profiles into **social_DM_users** 
-  **Social User Connections and Distance - 1.3 Datamart **: load all the disconnected pairs into **social_DM_disconnected_pairs table**
-  **Social User Connections and Distance - 2.0 Insights**: includes several queries implementing some analysis on the datamart tables just created

Note: Before to submit the SQL script remeember to teplace 'MyDataset' with the name of your bigquery dataset

The abstract and documentation of the project can be found at: https://medium.com/@mlasala1964/how-to-match-payments-and-charges-in-sql-1554abf1f302
