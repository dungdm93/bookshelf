CREATE EXTERNAL TABLE reddit_posts (
  id                    STRING,
  title                 STRING,
  score                 INT,
  author                STRING,
  author_flair_text     STRING,
  removed_by            STRING,
  total_awards_received DECIMAL,
  awarders              STRING,
  created_utc           INT,
  full_link             STRING,
  num_comments          INT,
  over_18               BOOLEAN
)
COMMENT 'Posts of Data is Beautiful, a Reddit community.'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs://hdfs-namenode:8020/datasets/reddit/';
