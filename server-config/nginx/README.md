
## Setup nginx

### setup
```bash
sudo apt-get update
sudo apt-get install nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# reloading with 1ms downtime (update for new routes)
sudo nginx -t
sudo nginx -s reload
sudo systemctl reload nginx # on change config
```

### config forwarding to another domain and HTTPS

```bash
# /etc/nginx/sites-available/example-ru
server {
    listen 80;
    listen [::]:80;
    server_name example.ru;
    
    # Redirect to the .com version preserving scheme and URI.
    return 301 https://example.com$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name example.ru;
    
    ssl_certificate /etc/letsencrypt/live/example.ru/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.ru/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
    
    return 301 https://example.com$request_uri;
}

# /etc/nginx/sites-available/subdomains-ru
server {
    listen 80;
    listen [::]:80;
    # Using a regex to capture any subdomain on example.ru
    server_name ~^(?<subdomain>.+)\.example\.ru$;
    
    # Redirect to the corresponding subdomain on .com
    return 301 https://$subdomain.example.com$request_uri;
}
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name ~^(?<subdomain>.+)\.example\.ru$;
    
    ssl_certificate /etc/letsencrypt/live/example.ru/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.ru/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
    
    return 301 https://$subdomain.example.com$request_uri;
}

# REAL APP
# /etc/nginx/sites-available/chat-example-com
server {
    listen 80;
    listen [::]:80;
    server_name chat.example.com;
    
    # (You might want to redirect HTTP to HTTPS)
    return 301 https://chat.example.com$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name chat.example.com;
    
    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
    
    location / {
        # Proxy to your Python/Node.js backend, e.g., for a Python app on port 8000
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### symlink for activate/deactivate websites

```bash
# activate websites
sudo ln -s /etc/nginx/sites-available/pythonapp /etc/nginx/sites-enabled/

# deactivate websites
sudo unlink /etc/nginx/sites-enabled/pythonapp
```

### SSL Configuration

```bash
sudo apt-get install certbot python3-certbot-nginx
# need updated DNS records
sudo certbot --nginx -d yourdomain.com -d app1.yourdomain.com -d app2.yourdomain.com
# also duplicate for another zone if needed
sudo certbot --nginx -d yourdomain.ru -d app1.yourdomain.ru -d app2.yourdomain.ru
sudo certbot renew --dry-run
```
Certificates auto-renew every 90 days. Verify the renewal timer:
```bash
systemctl list-timers | grep certbot
```

## Domain configuration

```bash
Type    Name             Value
A       app1             your.server.ip.address
A       app2             your.server.ip.address
A       *                your.server.ip.address    # Wildcard for all subdomains
```

```bash
Type    Name             Value
CNAME   app1             yourdomain.com
CNAME   app2             yourdomain.com
```