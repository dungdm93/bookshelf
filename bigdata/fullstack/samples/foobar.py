from pyspark.sql import SparkSession

packages = [
    # "com.amazonaws:aws-java-sdk:1.11.521",
    # "com.amazonaws:aws-java-sdk-s3:1.10.6",
    "org.apache.hadoop:hadoop-aws:3.1.2",
    # "org.apache.hadoop:hadoop-hdfs:2.7.3"
    # 2.7.3 | 2.8.5 | 3.2.0
]

spark = SparkSession.builder \
            .master("local") \
            .appName("example-pyspark-read-and-write") \
            .config("spark.jars.packages", ",".join(packages)) \
            .config("spark.hadoop.fs.s3a.access.key", "minio.teko.key") \
            .config("spark.hadoop.fs.s3a.secret.key", "N0YlM8H36Yz0tIqaD4kOCUFPwxPvJPNY") \
            .config("spark.hadoop.fs.s3a.endpoint", "http://123.31.32.178:9091") \
            .config("spark.hadoop.fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem") \
            .config("spark.hadoop.fs.s3a.path.style.access", "true") \
            .getOrCreate()

lines = spark.read.format("csv") \
            .option("header", "true") \
            .load("s3a://demos/trees.csv")

print(*lines, sep='\n')

lines.write.format("csv") \
    .option("header", "true") \
    .save("s3a://demos/root.csv", mode="overwrite")
