Sonatype Nexus
==============

## 1. Java

## 2. Python
[docs](https://help.sonatype.com/repomanager3/formats/pypi-repositories)

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
[docs](https://help.sonatype.com/repomanager3/formats/npm-registry)

### 3.1 `npm`
* Configuring npm
    ```bash
    # sudo
    npm config --global set registry http://nexus:8081/repository/npm-proxy

    # when Anonymous Access is disabled
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
//TODO

## 4. apt

## 5. Raw
### 5.1 Conda
[tut](https://seenukarthi.com/repository/2018/10/23/conda-repository-in-nexus-oss-3/)
