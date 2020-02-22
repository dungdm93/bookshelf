name := "spark-example"
version := "0.1"
scalaVersion := "2.11.12"

val sparkVerion = "2.4.4"

libraryDependencies += "org.scala-sbt" %% "zinc" % "1.2.1"

libraryDependencies += "org.apache.spark" %% "spark-core" % sparkVerion
libraryDependencies += "org.apache.spark" %% "spark-sql" % sparkVerion
libraryDependencies += "org.apache.spark" %% "spark-avro" % sparkVerion
