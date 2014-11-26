For the Ubuquitu + Mac setup, nginx is installed on the macs themselves
and the VMs are therefore not needed. Nginx does not come natively on the macs,
and there are a few (minor differences) in configuring and using it.

Commands:
Run:    sudo nginx
Stop:   sudo nginx -s stop

Nginx is configured to run at boot, so it should work out of the box.
The relevant config files are provided in this folder.

Note that the www directory is located at /Users/admin/www, which is
the home directory of the server user. This is also reflected in nginx.conf.

(There most likely is a better way, but this seems to work for now.)

Location of key files:
www root --> /Users/admin/www
nginx.conf --> /usr/local/etc/nginx/nginx.conf
academy config --> /usr/local/etc/nginx/sites-enabled/academy
