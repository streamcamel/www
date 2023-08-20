# www
Web Server Configuration

The directory more or less mimicks the actually directory structure on the Ubuntu Linux server.

## Installing
```
sudo apt install nginx
```

## How to deploy
1. Make a backup of the files you are going to edit on the server: 
   `sudo cp /etc/nginx/sites-availables/streamcamel.com /etc/nginx/sites-availables/streamcamel.com.bak`
1. Modify the file using your favorite editor: `sudo vi /etc/nginx/sites-availables/streamcamel.com`
1. Test your configuration: `sudo nginx -t`, if correct, you will get this message:
   ```shell
   nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
   nginx: configuration file /etc/nginx/nginx.conf test is successful
   ```
1. Check state of nginx: `sudo systemctl status nginx`
1. Reload configuration: `sudo systemctl reload nginx`
1. Check state again: `sudo systemctl status nginx`
1. Confirm website is still working, browse to www.streamcamel.com.
1. If any issues, look at error log: `tail -f /var/log/nginx/error.log`
1. If everything is broken, copy your backup file, and reload ngix again to restore previous stable configuration.
