import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    kotlin("jvm") version "1.5.31"
    id("io.gitlab.arturbosch.detekt").version("1.16.0-RC1")
    application
}
group = "me.scmacdon"
version = "1.0-SNAPSHOT"

buildscript {
    repositories {
        jcenter()
    }
}

repositories {
    mavenCentral()
    mavenLocal()
    jcenter()
}

dependencies {
    implementation("aws.sdk.kotlin:firehose:0.9.4-beta")
    testImplementation("org.junit.jupiter:junit-jupiter:5.6.0")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.5.0")
    implementation("com.fasterxml.jackson.core:jackson-databind:2.12.3")

}
tasks.withType<KotlinCompile>() {
    kotlinOptions.jvmTarget = "1.8"
}
