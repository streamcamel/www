##

server {
    server_name streamcamel.com;
    return 301 https://www.streamcamel.com$request_uri;

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/implicitconversions.com-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/implicitconversions.com-0001/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    server_name dev.streamcamel.com;
    return 301 https://www.dev.streamcamel.com$request_uri;

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/implicitconversions.com-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/implicitconversions.com-0001/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    server_name staging.streamcamel.com;
    return 301 https://www.staging.streamcamel.com$request_uri;

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/implicitconversions.com-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/implicitconversions.com-0001/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    server_name api.streamcamel.com;
    location / {
        gzip on;
        gzip_types text/plain application/json;
        gzip_min_length 1000;
        proxy_set_header Host $host;
        proxy_pass http://localhost:8800;
        proxy_redirect off;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/implicitconversions.com-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/implicitconversions.com-0001/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    server_name api.staging.streamcamel.com;
    location / {
        gzip on;
        gzip_types text/plain application/json;
        gzip_min_length 1000;
        proxy_set_header Host $host;
        proxy_pass http://localhost:8801;
        proxy_redirect off;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/implicitconversions.com-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/implicitconversions.com-0001/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    server_name api.dev.streamcamel.com;
    location / {
        gzip on;
        gzip_types text/plain application/json;
        gzip_min_length 1000;
        proxy_set_header Host $host;
        proxy_pass http://localhost:8802;
        proxy_redirect off;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/implicitconversions.com-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/implicitconversions.com-0001/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
   gzip on;
   gzip_disable "msie6";
   gzip_vary on;
   gzip_proxied any;
   gzip_comp_level 6;
   gzip_buffers 16 8k;
   gzip_http_version 1.1;
   gzip_types application/javascript application/rss+xml application/vnd.ms-fontobject application/x-font application/x-font-opentype application/x-font-otf application/x-font-truetype application/x-font-ttf application/x-javascript application/xhtml+xml application/xml font/opentype font/otf font/ttf image/svg+xml image/x-icon text/css text/javascript text/plain text/xml;

   server_name www.streamcamel.com;
   add_header Access-Control-Allow-Origin *;
   root /var/www/streamcamel.com;
   index index.html;

   set $fallback_file /index.html;
   try_files $uri $fallback_file;

   location ~ \.php$ {
       include snippets/fastcgi-php.conf;
       fastcgi_pass unix:/run/php/php7.2-fpm.sock;
   }

   location ~ /\.ht {
       deny all;
   }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/implicitconversions.com-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/implicitconversions.com-0001/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    server_name images.streamcamel.com;
    add_header Access-Control-Allow-Origin *;
    root /var/www/streamcamel.com/data/images;

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/implicitconversions.com-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/implicitconversions.com-0001/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    if ($host = streamcamel.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name streamcamel.com;
    return 404; # managed by Certbot
}

server {
    if ($host = www.streamcamel.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

	listen 80;
	server_name www.streamcamel.com;
	return 404; # managed by Certbot
}

server {
    if ($host = www.staging.streamcamel.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

	listen 80;
	server_name www.staging.streamcamel.com;
	return 404; # managed by Certbot
}

server {
    if ($host = www.dev.streamcamel.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

	listen 80;
	server_name www.dev.streamcamel.com;
	return 404; # managed by Certbot
}

server {
    if ($host = api.streamcamel.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name api.streamcamel.com;
    return 404; # managed by Certbot
}

server {
    if ($host = api.staging.streamcamel.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name api.staging.streamcamel.com;
    return 404; # managed by Certbot
}

server {
    if ($host = api.dev.streamcamel.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name api.dev.streamcamel.com;
    return 404; # managed by Certbot
}

server {
    if ($host = images.streamcamel.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name images.streamcamel.com;
    return 404; # managed by Certbot
}


