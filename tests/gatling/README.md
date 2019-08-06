[`gatling`](https://gatling.io)
===============================

1. Setup
* Install `sdkman`
    ```bash
    ##### USAGE #####
    # List posible candidates
    sdk ls

    # List candidate versions
    sdk ls java
    ```

* Install `scala` & `sbt`
    ```bash
    sdk install java    8.0.191-oracle
    sdk install scala
    sdk install sbt
    ```

* Create new gatling project
    ```bash
    sbt new gatling/gatling.g8
    ```
