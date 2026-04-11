plugins {
    id("java")
}

group = "me.dungdm93.kafka"
version = "0.0-SNAPSHOT"

repositories {
    mavenCentral()
    maven {
        name = "Confluent"
        url = uri("https://packages.confluent.io/maven/")
    }
}

val versionSR = "8.2.0"

dependencies {
    implementation("io.confluent:kafka-connect-avro-converter:$versionSR")
    implementation("io.confluent:kafka-connect-protobuf-converter:$versionSR")
    implementation("io.confluent:kafka-connect-json-schema-converter:$versionSR")
}

configurations.all {
    exclude(group = "org.slf4j", module = "*")
    exclude(group = "org.apache.kafka", module = "*")
    exclude(group = "com.fasterxml.jackson.core", module = "*")
    exclude(group = "com.fasterxml.jackson.datatype", module = "*")
    exclude(group = "com.fasterxml.jackson.dataformat", module = "*")
    exclude(group = "org.yaml", module = "snakeyaml")
    exclude(group = "io.swagger.core.v3", module = "swagger-annotations")
}

tasks.register<Copy>("copyDeps") {
    val outDir = project.findProperty("outDir") as String? ?: "${layout.buildDirectory}/dependencies"

    from(configurations.runtimeClasspath)
    into(outDir)
}
