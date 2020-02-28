package vn.teko.data.spark

import io.delta.tables._
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions._


case class Data(key: String, value: String)

case class ChangeData(key: String, newValue: String, deleted: Boolean, time: Long) {
    assert(newValue != null ^ deleted)
}

object CDCMergingExample {
    def generateData(spark: SparkSession): Unit = {
        import spark.implicits._

        val originDF = Seq(
            Data("a", "0"),
            Data("b", "1"),
            Data("c", "2"),
            Data("d", "3")
        ).toDF()
        originDF.write
            .format("delta")
            .mode("overwrite")
            .save("/tmp/cdc/origin")

        val changesDF = Seq(
            ChangeData("a", "10", deleted = false, time = 0),
            ChangeData("a", null, deleted = true, time = 1), // a was updated and then deleted

            ChangeData("b", null, deleted = true, time = 2), // b was just deleted once

            ChangeData("c", null, deleted = true, time = 3), // c was deleted and then updated twice
            ChangeData("c", "20", deleted = false, time = 4),
            ChangeData("c", "200", deleted = false, time = 5)
        ).toDF()
        changesDF.write
            .format("delta")
            .mode("overwrite")
            .save("/tmp/cdc/change")
    }

    def mergeChange(spark: SparkSession): Unit = {
        val deltaTable = DeltaTable.forPath("/tmp/cdc/origin")
        val changesDF = spark.read.format("delta").load("/tmp/cdc/change")

        deltaTable.toDF.show()
        changesDF.show()
        val latestChangeForEachKey = changesDF
            .selectExpr("key", "struct(time, newValue, deleted) as otherCols")
            .groupBy("key")
            .agg(max("otherCols").as("latest"))
            .selectExpr("key", "latest.*")

        latestChangeForEachKey.show()
        latestChangeForEachKey.printSchema()

        deltaTable.as("t")
            .merge(latestChangeForEachKey.as("s"),
                "s.key = t.key")
            .whenMatched("s.deleted = true")
            .delete()
            .whenMatched()
            .updateExpr(Map("key" -> "s.key", "value" -> "s.newValue"))
            .whenNotMatched("s.deleted = false")
            .insertExpr(Map("key" -> "s.key", "value" -> "s.newValue"))
            .execute()

        deltaTable.toDF.show()
    }
}

object CDCMerging extends App {
    val spark = SparkSession.builder()
        .master("local[1]")
        .appName("CDCMerging")
        .getOrCreate()

    // CDCMergingExample.generateData(spark)
    CDCMergingExample.mergeChange(spark)
}
