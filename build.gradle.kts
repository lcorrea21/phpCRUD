/*
 * This file was generated by the Gradle 'init' task.
 *
 * This generated file contains a sample Java application project to get you started.
 * For more details take a look at the 'Building Java & JVM projects' chapter in the Gradle
 * User Manual available at https://docs.gradle.org/7.2/userguide/building_java_projects.html
 */

plugins {
    // Apply the application plugin to add support for building a CLI application in Java.
    id("org.liquibase.gradle") version "2.2.1"
    id("org.springframework.boot") version "3.2.4"
    java
}

repositories {
    // Use Maven Central for resolving dependencies.
    mavenCentral()
    google()
}

val junitVersion = "5.10.2"
val dgsVersion = "8.6.0"

dependencies {
    implementation("org.wiremock:wiremock:3.5.2")
    implementation("org.junit.jupiter:junit-jupiter:$junitVersion")
    implementation(platform("com.netflix.graphql.dgs:graphql-dgs-platform-dependencies:$dgsVersion"))
    implementation("com.netflix.graphql.dgs:graphql-dgs-extended-scalars:$dgsVersion")
    implementation("com.netflix.graphql.dgs:graphql-dgs-spring-boot-starter:$dgsVersion")
}
