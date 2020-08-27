server {
    server_name implicitconversions.com;
    return 301 http://www.implicitconversions.com$request_uri;

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/implicitconversions.com-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/implicitconversions.com-0001/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot



}

server {
   server_name www.implicitconversions.com;
   root /var/www/implicitconversions.com;
   index index.html;

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/implicitconversions.com-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/implicitconversions.com-0001/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot



}

server {
    if ($host = implicitconversions.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name implicitconversions.com;
    return 404; # managed by Certbot


}

server {
    if ($host = www.implicitconversions.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


   listen 80;
   server_name www.implicitconversions.com;
    return 404; # managed by Certbot


}