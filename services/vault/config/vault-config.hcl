storage "file" {
  path = "/vault/file"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

ui = true
disable_mlock = true
# api_addr = "http://127.0.0.1:8200"
# cluster_addr = "http://127.0.0.1:8201"
