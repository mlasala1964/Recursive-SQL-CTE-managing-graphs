--==================================================================================
-- 
-- Replace 'MyDataset' with the name of your bigquery dataset
-- 
--==================================================================================

DROP TABLE IF EXISTS MyDataset.social_users;
Create table MyDataset.social_users (
    user_id BIGINT,
    user_name STRING,
    birth_date DATE,
    id_education_level INT,
    education_level STRING    -- 0. Basic (0 None, 1 Elementary School, 2 Middle School, 3 High School
                              -- 1. Middle (4 Associate's Degree, 5 Bachelor's Degree)
                              -- 2. Advanced (6 Master's Degree, 7 Doctorate)
);


-- Load Users table using fake and random data 

INSERT INTO MyDataset.social_users (user_id, user_name, birth_date, id_education_level, education_level) 
With user_ids as (
    SELECT user_id FROM UNNEST ([1, 11, 111, 112, 113, 12, 121, 122, 123, 1211, 1212, 13, 131, 132, 133, 134, 2, 21, 22, 23, 3,  31, 311, 3111, 31111, 32, 4,  41, 5]) AS user_id
)
,random_data as (
    SELECT 
        user_id                                                         AS user_id
        ,MOD(ABS(FARM_FINGERPRINT(CAST(user_id AS STRING))), 365 * 35)  AS nr_days_from_1980
        ,MOD(ABS(FARM_FINGERPRINT(CAST(user_id AS STRING))), 7)         AS nr_education_level
    FROM user_ids
)

,user_names as (
    SELECT user_id, user_name
    FROM UNNEST ([
STRUCT(1 AS user_id,'Jannik' AS user_name) 
,STRUCT(2,'Alexander'),STRUCT(3,'Carlos'),   STRUCT(4,'Taylor'),   STRUCT(5,'Jack')
,STRUCT(11,'Daniil'),  STRUCT(12,'Tommy'),   STRUCT(13,'Ben')
,STRUCT(111,'Elmer'),  STRUCT(112,'Thanasi'),STRUCT(113,'Lucas ')
,STRUCT(121,'Tristan'),STRUCT(122,'Felipe'), STRUCT(123,'Daniel')
,STRUCT(1211,'Marco'), STRUCT(1212,'Piero')
,STRUCT(131,'Dušan'),  STRUCT(132,'Stan'),   STRUCT(133,'Thiago'), STRUCT(134,'Márton') 
,STRUCT(21,'Jakub'),   STRUCT(22,'Ugo')     ,STRUCT(23,'Sebastian')
,STRUCT(31,'Hubert'),  STRUCT(32,'Sebastián')
,STRUCT(311,'Andrej')
,STRUCT(3111,'Nicola')
,STRUCT(31111,'Michelangelo')
,STRUCT(41,'Jordan')
]) user_names
)


SELECT 
  random_data.user_id                                     AS user_id
  ,COALESCE(user_name, '---')                             AS user_name
  ,DATE_ADD('1980-01-01', INTERVAL nr_days_from_1980 DAY) AS birth_date
  ,nr_education_level                                     AS id_education_level
  ,CASE
  WHEN nr_education_level = 0 THEN 'None'
  WHEN nr_education_level = 1 THEN 'Elementary School'
  WHEN nr_education_level = 2 THEN 'Middle School'
  WHEN nr_education_level = 3 THEN 'High School'
  WHEN nr_education_level = 4 THEN 'Associate\'s Degree'
  WHEN nr_education_level = 5 THEN 'Bachelor\'s Degree'
  WHEN nr_education_level = 6 THEN 'Master\'s Degree'
  WHEN nr_education_level = 7 THEN 'Doctorate'
  ELSE 'UNDEFINED'
  END                                                    AS education_level
FROM random_data
LEFT OUTER JOIN user_names on (random_data.user_id = user_names.user_id);

DROP TABLE IF EXISTS MyDataset.social_network;
Create table MyDataset.social_network (
    user_id BIGINT,
    friend_id BIGINT
);

INSERT INTO MyDataset.social_network (user_id, friend_id) VALUES
(1, 11), (1, 12), (1, 13), 
    (11, 111), (11, 112), (11, 113),
    (12, 121), (12, 122), (12, 123),
         (121, 1211), (121, 1212), 
    (13, 131), (13, 132), (13, 133), (13, 134),
   
(2, 21), (2, 22), (2, 23),
(3, 31), (3, 32),
   (31, 311),
       (311, 3111), 
            (3111, 31111), 
(4, 41),

(1, 123),
(1, 1212),
(1, 134)
  
,(3, 1211)
;

