CREATE EXTERNAL TABLE youtube_videos (
  video_id                STRING,
  trending_date           STRING,
  title                   STRING,
  channel_title           STRING,
  category_id             INT,
  publish_time            DATE,
  tags                    STRING,
  views                   INT,
  likes                   INT,
  dislikes                INT,
  comment_count           INT,
  thumbnail_link          STRING,
  comments_disabled       BOOLEAN,
  ratings_disabled        BOOLEAN,
  video_error_or_removed  BOOLEAN,
  description             STRING
)
COMMENT 'Daily statistics for trending YouTube videos'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs://hdfs-namenode:8020/datasets/raw/youtube/'
TBLPROPERTIES ("skip.header.line.count"="1");

CREATE TABLE youtube_videos_parquet
  STORED AS PARQUET
  LOCATION 'hdfs://hdfs-namenode:8020/datasets/parquet/youtube/'
  AS
SELECT *
FROM youtube_videos;

CREATE TABLE youtube_videos_orc
  STORED AS ORC
  LOCATION 'hdfs://hdfs-namenode:8020/datasets/orc/youtube/'
  TBLPROPERTIES ("transactional"="true")
  AS
SELECT *
FROM youtube_videos;
