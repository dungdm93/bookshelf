gitlab-pages
============

## 1. Configure
1. [Wildcard DNS](/tools/certbot/README.md)
2. Configure `gitlab-pages`
```rb
gitlab_pages['enable'] = true
pages_external_url "https://pages.example.com"

gitlab_pages['redirect_http'] = true
gitlab_pages['access_control'] = true

pages_nginx['enable'] = true
pages_nginx['redirect_http_to_https'] = true
pages_nginx['ssl_certificate'] = "/etc/gitlab/ssl/fullchain.pem"
pages_nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/privkey.pem"
```
