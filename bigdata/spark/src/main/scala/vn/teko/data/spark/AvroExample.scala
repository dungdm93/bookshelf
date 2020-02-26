package vn.teko.data.spark

import java.io.File

import org.apache.avro.Schema
import org.apache.spark.sql.SparkSession

object AvroExample extends App {
    val spark = SparkSession.builder()
        .master("local[1]")
        .appName("AvroExamples")
        .getOrCreate()

    val schema = new Schema.Parser().parse(new File("src/main/resources/mysql.avsc"))
    val df = spark.read
        .format("avro")
        .option("avroSchema", schema.toString)
        .load("src/main/resources/mysql.avro")

    df.show()
    df.printSchema()

    spark.close()
}
