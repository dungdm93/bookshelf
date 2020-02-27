package vn.teko.data.spark

import io.delta.tables.DeltaTable
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions.{col, expr}

object example {
    def dfWrite(spark: SparkSession) {
        val data = spark.range(0, 5)

        data.write.format("delta")
            .mode("overwrite")
            .save("/tmp/delta-table")

        data.show()
    }

    def dfChange(spark: SparkSession) {
        val deltaTable = DeltaTable.forPath("/tmp/delta-table")

        // Update every even value by adding 100 to it
        deltaTable.update(
            condition = expr("id % 2 == 0"),
            set = Map("id" -> expr("id + 100"))
        )

        // Delete every even value
        deltaTable.delete(condition = expr("id % 2 == 0"))

        // Upsert (merge) new data
        val newData = spark.range(0, 20).toDF

        deltaTable.as("oldData")
            .merge(newData.as("newData"), "oldData.id = newData.id")
            .whenMatched
            .update(Map("id" -> col("newData.id")))
            .whenNotMatched
            .insert(Map("id" -> col("newData.id")))
            .execute()

        deltaTable.toDF.show()
    }

    def dfTimeTravel(spark: SparkSession) {
        val df = spark.read.format("delta").option("versionAsOf", 1).load("/tmp/delta-table")

        df.show()
    }
}

object DeltaExample extends App {
    val spark = SparkSession.builder()
        .master("local[1]")
        .appName("DeltaExample")
        .getOrCreate()

    example.dfTimeTravel(spark)
}
