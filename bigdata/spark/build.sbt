name := "spark-example"
version := "0.1"
scalaVersion := "2.11.12"

val sparkVersion = "2.4.4"

libraryDependencies += "org.scala-sbt" %% "zinc" % "1.2.1"

libraryDependencies += "org.apache.spark" %% "spark-core" % sparkVersion
libraryDependencies += "org.apache.spark" %% "spark-sql" % sparkVersion
libraryDependencies += "org.apache.spark" %% "spark-avro" % sparkVersion
libraryDependencies += "io.delta" %% "delta-core" % "0.5.0"
