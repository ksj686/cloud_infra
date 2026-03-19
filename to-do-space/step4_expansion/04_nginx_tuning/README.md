# Nginx Performance Tuning

## Overview
Nginx is a high-performance web server, reverse proxy, and load balancer. Proper tuning can significantly improve application response times and handle more concurrent users.

### Core Tuning Areas
1. **Worker Processes**: Match the number of CPU cores.
   - `worker_processes auto;`
2. **Worker Connections**: Increase the maximum connections per worker.
   - `worker_connections 1024;` (up to 65535 depending on OS limits)
3. **Keepalive**: Reduce overhead by reusing existing connections.
   - `keepalive_timeout 65;`
4. **Gzip Compression**: Reduce the size of sent files.
   - `gzip on;`
5. **Caching**: Store frequently accessed data in memory or disk.
   - `proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=my_cache:10m;`

## Managing Nginx Service
- **Enable on boot**: `sudo systemctl enable nginx`
- **Stop**: `sudo systemctl stop nginx`
- **Start**: `sudo systemctl start nginx`
- **Restart (full)**: `sudo systemctl restart nginx`
- **Reload (soft)**: `sudo systemctl reload nginx` (highly recommended for config changes)
- **Check Status**: `sudo systemctl status nginx`

## Verification
Always test your configuration before reloading:
- `sudo nginx -t`
