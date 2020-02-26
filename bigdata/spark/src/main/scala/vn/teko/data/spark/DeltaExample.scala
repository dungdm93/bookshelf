package vn.teko.data.spark

import org.apache.spark.sql.SparkSession

object DeltaExample extends App {
    val spark = SparkSession.builder()
        .master("local[1]")
        .appName("DeltaExample")
        .getOrCreate()

    val data = spark.range(0, 5)
    data.write.format("delta")
        .mode("overwrite")
        .save("/tmp/delta-table")

    data.show()
}
