## https://developer.hashicorp.com/vault/docs/configuration
ui = true
# disable_mlock = true
# api_addr = "http://127.0.0.1:8200"
# cluster_addr = "http://127.0.0.1:8201"

storage "file" {
  path = "/vault/file"
}
