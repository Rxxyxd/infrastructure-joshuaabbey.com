server {
    listen 443 ssl;
    server_name joshuaabbey.com www.joshuaabbey.com;
    ssl_certificate     /etc/ssl/nginx/joshuaabbey.com.pem;
    ssl_certificate_key /etc/ssl/nginx/joshuaabbey.com.key;
    ssl_buffer_size 8k;
    ssl_stapling on;
    add_header Strict-Transport-Security max-age=31536000;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Port $server_port;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Server-Select $scheme;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Url-Scheme: $scheme;
        proxy_set_header Host $host;
        proxy_http_version 1.1;
        proxy_cache off;
    }
}

server {
	listen 80;
	server_name joshuaabbey.com www.joshuaabbey.com;
	return 301 https://$host$request_uri;
}
