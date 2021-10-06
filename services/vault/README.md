Hashicorp Vault
===============

## 1. Prepare
* `export VAULT_ADDR=http://localhost:8200`
* login:
  ```console
  $ vault login
  Token (will be hidden):

  # or
  $ vault login -method=userpass \
      username=<user> password=<pass>
  ```

## 2. Policy
* List policy
  ```bash
  vault policy list
  vault read sys/policy/
  ```

* Read policy
  ```bash
  vault policy read default
  vault read sys/policy/default
  ```

* Write policy
  ```bash
  vault policy write admin /path/to/policy.hcl
  cat /path/to/policy.hcl | vault policy write admin -
  ```

  Example `admin` policy:
  ```hcl
  # admin
  path "/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
  }
  ```

References:
* [Vault Policy concept](https://www.vaultproject.io/docs/concepts/policies)
* [`vault policy` command](https://www.vaultproject.io/docs/commands/policy)

## 3. AuthMethod
* List
  ```bash
  vault auth list

  ```

* Enable/Disable AuthMethod:
  ```bash
  vault auth enable userpass
  vault auth help userpass/
  vault auth disable userpass/

  vault read sys/auth/
  ```

References:
* [Vault AuthMethod concept](https://www.vaultproject.io/docs/concepts/auth)
* [`vault auth` command](https://www.vaultproject.io/docs/commands/auth)

## 4. KV Secret
## 5. Database Secret
* Enable `database` secret engine
  ```bash
  vault secrets enable database
  ```

* Create connection
  ```bash
  vault write database/config/mysql \
    plugin_name="mysql-database-plugin" \
    connection_url="{{username}}:{{password}}@tcp(mysql:3306)/" \
    allowed_roles="mysql-static,mysql-dynamic" \
    username="root" \
    password="SuperSecr3t"
  ```

* Dynamic role
  ```bash
  vault write database/roles/mysql-dynamic \
    db_name=mysql \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}'; GRANT SELECT ON *.* TO '{{name}}'@'%';" \
    default_ttl="1h" \
    max_ttl="24h"

  # retrive dynamic secret
  vault read database/creds/mysql-dynamic
  ```

* Static role
  ```bash
  vault write database/static-roles/mysql-static \
      db_name=mysql \
      rotation_statements="ALTER USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';" \
      username="foobar" \
      rotation_period=86400

  # retrive static secret
  vault read database/static-creds/mysql-static
  ```

References:
* Tutorial: [Database Dynamic Roles](https://learn.hashicorp.com/tutorials/vault/database-secrets)
* Tutorial: [Database Static Roles](https://learn.hashicorp.com/tutorials/vault/database-creds-rotation)
