Sonatype Nexus
==============

## 1. Maven
## 2. pip
## 3. npm
### 3.1 npm
[docs](https://help.sonatype.com/repomanager3/formats/npm-registry)

* Configuring npm

    ```bash
    npm config --global set registry http://nexus:8081/repository/npm-proxy

    # when Anonymous Access is disabled
    echo -n "_auth=$(echo -n 'username:password' | openssl base64)" >> /usr/etc/npmrc
    ```

  * Show all configs (included defaults)

    ```bash
    npm config ls -l
    ```

    ref: [cli config](https://docs.npmjs.com/cli/config)

  * `npmrc` location

    Global: `/usr/etc/npmrc`

    ref: [npmrc files](https://docs.npmjs.com/misc/config#npmrc-files)

* Testing proxy

    Use `--verbose` mode or `--loglevel info` when install new package, the command line output will reference the URLs.

    ```bash
    npm --loglevel info install mocha
    ```

### 3.2 yarn
//TODO

## 4. apt
