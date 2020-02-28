package vn.teko.data.spark

import java.util.Properties

import org.apache.spark.sql.SparkSession

object MySQLExample extends App {
    val spark = SparkSession.builder()
        .master("local[1]")
        .appName("MySQL Example")
        .getOrCreate()

    val props = new Properties()
    props.put("user", "root")
    props.put("password", "SuperSecr3t")

    val df = spark.read.jdbc("jdbc:mysql://localhost:3306", "sakila.actor", props)

    df.show()
    df.printSchema()

    df.write.parquet("src/main/resources/sakila-actor")
}
