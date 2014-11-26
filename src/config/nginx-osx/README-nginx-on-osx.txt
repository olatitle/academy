For the Ubuquitu + Mac setup, nginx is installed on the macs themselves
and the VMs are therefore not needed. Nginx does not come natively on the macs,
and there are a few (minor differences) in configuring and using it.

Useful commands:

Run and stop nginx directly (do not use if configured for start-on-boot):
   sudo nginx
   sudo nginx -s stop

Note that nginx is configured to run on boot. To load or unload it:
  sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.nginx.plist
  sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.nginx.plist

A copy of the file which is referred is provided in this directory.

Nginx is configured to run at boot, so it should work out of the box.
The relevant config files are provided in this folder.

Note that the www directory is located at /Users/admin/www, which is
the home directory of the server user. This is also reflected in nginx.conf.

(There most likely is a better way, but this seems to work for now.)

Location of key files:
www root --> /Users/admin/www
nginx.conf --> /usr/local/etc/nginx/nginx.conf
academy config --> /usr/local/etc/nginx/sites-enabled/academy
