Sonatype Nexus
==============

## 1. Java
* [docs](https://help.sonatype.com/repomanager3/formats/maven-repositories)
* [tut](https://blog.sonatype.com/using-nexus-3-as-your-repository-part-1-maven-artifacts)

### 1.1 `maven`
* Installation
    ```bash
    apt install openjdk-8-jdk maven
    ```

* Configuring maven
    ```xml
    <!-- //usr/share/maven/conf -> /etc/maven -->
    <settings>
        <mirrors>
            <mirror>
            <id>nexus</id>
            <url>http://nexus:8081/repository/maven-central/</url>
            <mirrorOf>*</mirrorOf>
            </mirror>
        </mirrors>
    </settings>
    ```

* Testing proxy
    ```bash
    # Create sample project
    # interactive
    mvn archetype:generate

    # or
    mvn archetype:generate  \
        -DgroupId=vn.teko   \
        -DartifactId=sample \
        -DarchetypeArtifactId=maven-archetype-quickstart \
        -DinteractiveMode=false
    ```

    Sone helpful commands:
    ```bash
    mvn dependency:list
    mvn dependency:tree
    mvn dependency:list-repositories

    # resolve
    mvn dependency:resolve
    mvn dependency:resolve-plugins
    mvn dependency:sources

    # help command
    mvn help:describe -Dcmd=install
    mvn help:describe -Dcmd=help:describe

    mvn help:describe -Dplugin=help
    mvn help:describe -Dplugin=org.apache.maven.plugins:maven-help-plugin

    mvn help:describe -DgroupId=org.apache.maven.plugins -DartifactId=maven-help-plugin

    # Try 'mvn help:help -Ddetail=true' for more information.
    ```

### 1.2 `gradle`
* Installation
    ```bash
    apt install openjdk-8-jdk gradle
    ```

* Configuring gradle
    ```groovy
    // $GRADLE_HOME/init.d/mirror.gradle
    // In Unix, GRADLE_HOME=/usr/share/gradle
    allprojects {
      buildscript {
        repositories {
        // More repos here, e.g: `mavenLocal()`
        maven { url "http://nexus:8081/repository/maven-central/" }
      }
    }
      repositories {
        // More repos here, e.g: `mavenLocal()`
        maven { url "http://nexus:8081/repository/maven-central/" }
      }
    }
    ```

    ref: [tut](https://rahulsom.github.io/blog/2016/gradle-equivalent-of-maven-mirror.html) | [init_scripts](https://docs.gradle.org/current/userguide/init_scripts.html)

* Testing proxy
    ```bash
    gradle build --debug --no-daemon --no-parallel
    ```

    Sone helpful commands:
    ```bash
    gradle tasks --all --quiet
    gradle dependencies
    ```

### 1.3 `ivy`
* Configuring
    ```xml
    <!-- ivysettings.xml -->
    <ivysettings>
      <settings defaultResolver="nexus"/>
      <property name="nexus-public" value="http://nexus:8081/repository/maven-central/"/>
      <resolvers>
        <ibiblio name="nexus" m2compatible="true" root="${nexus-public}"/>
      </resolvers>
    </ivysettings>
    ```

    Then put `ivysettings.xml` next to `ivy.xml` and `build.xml` files in your project.  
    In `Spark`, config `spark-defaults.conf` as bellow:
    ```properties
    spark.jars.ivySettings   /path/to/your/ivysettings.xml
    ```

* Testing proxy

    Run `spark-shell`
    ```bash
    # --packages        spark.jars.packages
    # --repositories    spark.jars.repositories
    $SPARK_HOME/bin/spark-shell \
        --packages 'com.google.guava:guava:28.0-jre' \
        --repositories 'http://nexus:8081/repository/maven-central/'

    scala> spark.sparkContext.listJars.foreach(println)
    scala> spark.sparkContext.getConf.getAll.foreach(println)
    ```

    Run, `pyspark`
    ```python
    from pyspark.sql import SparkSession

    spark = SparkSession \
        .builder \
        .appName("PythonPi") \
        .config("spark.jars.packages", "com.google.guava:guava:28.0-jre") \
        .getOrCreate()

    # other stuff here
    ```

**References**:
* [ivy standalone](https://ant.apache.org/ivy/history/2.4.0/standalone.html)
* [ivysettings.xml](https://ant.apache.org/ivy/history/2.4.0/settings.html)

## 2. Python
* [docs](https://help.sonatype.com/repomanager3/formats/pypi-repositories)

### 2.1 `pip`
* Installation
    ```bash
    # sudo
    apt install python3-pip
    ln -s pip3 /usr/bin/pip
    ```

* Configuring pip
    ```ini
    # /etc/pip.conf
    [global]
    timeout = 60
    trusted-host = nexus
    index = http://nexus:8081/repository/pypi-proxy/pypi
    index-url = http://nexus:8081/repository/pypi-proxy/simple
    ```

  * Verify configuration is correct
    ```bash
    pip config list -v
    ```

    ref: [`pip config`](https://pip.pypa.io/en/stable/reference/pip_config/)
  * ref: [config-file](https://pip.pypa.io/en/stable/user_guide/#config-file) location

* Testing proxy
    ```bash
    pip install flask
    ```

### 2.2 `easy_install` (a.k.a `setuptools`)
* Installation
    ```bash
    pip install setuptools

    # or
    apt install python3-setuptools
    ```

* Configuring easy_install

    // TODO

## 3. Node.js
* [docs](https://help.sonatype.com/repomanager3/formats/npm-registry)

### 3.1 `npm`
* Configuring npm
    ```bash
    # sudo
    npm config --global set registry http://nexus:8081/repository/npm-proxy

    # when Anonymous Access is disabled
    npm login --registry=http://nexus:8081/repository/npm-proxy [--scope=@orgname]

    # or
    echo -n "_auth=$(echo -n 'username:password' | openssl base64)" >> /usr/etc/npmrc
    ```

  * Show all configs (included defaults)
    ```bash
    npm config ls -l
    ```

    ref: [cli config](https://docs.npmjs.com/cli/config)
  * ref: [npmrc files](https://docs.npmjs.com/misc/config#npmrc-files) location

* Testing proxy

    Use `--verbose` mode or `--loglevel info` when install new package, the command line output will reference the URLs.

    ```bash
    npm --loglevel info install mocha
    ```

### 3.2 `yarn`
* Installation
    ```bash
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

    sudo apt-get update
    sudo apt-get install yarn

    yarn --version
    ```

* Configuring yarn
    ```bash
    yarn config set registry 'http://nexus:8081/repository/npm-proxy' --global
    yarn config set disable-self-update-check true --global
    ```

  * Show yarn config & `.yarnrc` file location
    ```bash
    yarn config list --verbose
    ```

* Testing proxy
    ```bash
    yarn add webdriverio --verbose
    ```

**References**:
* [Using different registries in yarn and npm](https://medium.com/@crysfel/using-different-registries-in-yarn-and-npm-766541d6f851)

## 4. apt

## 5. Raw
### 5.1 Conda

* Configuring yarn

    Some helpful commands:
    ```bash
    # Show all configs
    conda config --show
    # Describe all configuration options
    conda config --describe

    conda config --add channels conda-forge [--system | --env]
    conda config --remove channels conda-forge [--system | --env]
    ```
* [`.condarc`](https://conda.io/projects/conda/en/latest/user-guide/configuration/use-condarc.html) file location:
  * user-wide: `$HOME/.condarc`
  * system-wide: `$CONDA_HOME/.condarc`

* Additional channels:
    ```
    conda-forge:    https://conda.anaconda.org/conda-forge
    ```

* Testing
    ```bash
    conda install bonsu
    ```

**References**:
* [tut](https://seenukarthi.com/repository/2018/10/23/conda-repository-in-nexus-oss-3/)
