# DHIS2 Academy Setup Guide

This is a guide for setting up a DHIS2 Academy Server. It includes setting up one or more DHIS2 instances and Moodle. The specifications of the server hardware can be changed but is currently:

* Brix Pro GB-BXi7-4770R
* 16GB RAM
* 256GB SSD

**This guide should be updated and sent out with the server to reflect the setup of the server. This means including information on all the DHIS2 instances if there are more than one etc.**

## Content
1. [Intro](#intro)
2. [Credentials](#credentials)
3. [General Information](#general-information)
4. [Setup using Clonezilla](#setup-using-clonezilla)
5. [Setup from scratch](#setup-from-scratch)

## Intro
This guide is split in two parts, the first part is the easy setup where you copy an existing harddisk image to your servers harddisk. The second part describes in detail how to set up a new server fresh.

Configuration files are located [here](https://github.com/simjes/academy).

## Credentials
If you have a DHIS2 Academy server from earlier than 21.05.2016 these credentials might be different, check the folder named 'OldConfig' or the documents you recieved with the server.

This is the standard configuration. Remember to update if there are more DHIS2 instances etc.

Service | Format | Credentials
------- | ------ | -----------
Ubuntu Server (logon/ssh) | username:password | dhisadmin:dhis
Postgres root | command | $ sudo -u postgres psql postgres
DHIS2 instance and database name | name | dhis
Moodle admin user | username:password | admin:DHIS4ever!
Moodle Postgres | username:database:password | moodleuser:moodle:dhis
Router Admin | username:password | ubnt:ubnt
UniFi controller | username:password | dhis:dhis
WiFi | SSID (no password) | dhis2

## General Information
* Server IP: 192.168.1.2
  * Can ssh to it using 'ssh dhisadmin@192.168.1.2'.
* Domain: dhis.academy
* Access server through http://192.168.1.2 or http://www.dhis.academy
* Router admin panel can be accessed through http://192.168.1.2
* Web content is located at `/var/www/`
* Clients (connected via WiFi or on port eth4) will be on the 192.168.2.0/24 subnet.


### Logs
* Postgresql: `/var/log/postgresql-9.3-main.log`
* DHIS2: `/var/lib/dhis2/<instance name>/logs/*`
* Nginx: `/var/log/nginx/*`

### Equipment
**The equipment will be marked with numbers, it is important that only the matching numbers are connected!**

Equipment | Marked
--------- | ------:
EdgeRouter PoE, including power adapter (48V) | #1
Server: Brix Pro, including power adapter | #2
WiFi Access Point Dual Band | #3
WiFi Access Point 2.4GHz | #4
Ethernet cables x3 | -

**All of the equipment is marked with numbers, only connect the corresponding numbers so that the equipment is not damaged.**

![Marked equipment](/StandardConfig/images/equipment.jpg)

## Setup using Clonezilla
Setting up an academy server using this part of the guide will require you to clone an existing server image onto your server using Clonezilla.
> The destination partition must be equal or larger than the source one.

Requirements:
* The Ubuntu HDD Image:
  * [Dropbox](https://www.dropbox.com/sh/ldus8wg06sw6vtu/AAClEz1EzW0U67dOXOafdOzea?dl=0)
  <add more links>
* Clonezilla live USB:
  * [Make a bootable USB](http://clonezilla.org/liveusb.php).
* Linux Live USB, use the following links to create it:
  * [for Windows](http://www.linuxliveusb.com)
  * [for Mac OSX](https://goo.gl/fgoM5R)
    <linux version>

This will mostly be explained in pictures. You will need a bootable Clonezilla USB memory stick and a USB memory stick containing the HDD image (or get it from a SSH server). The pictures will show how to do it using a USB memory stick, but if you want to use a SSH server you can choose that option instead, the program guides you though the process.

Boot the server from the Clonezilla USB stick, choose default settings and then keyboard layout. Continue following the onscreen instructions or click the picture below for full picture guide.

<a href="/StandardConfig/images/clonezilla_setup/"><img src="/StandardConfig/images/clonezilla_setup/1.jpg" /></a>  


## Setup from scratch
For this method you can find configurations in the [academy github repository](https://github.com/simjes/academy). When the guide asks you to copy configuration files the root will be this folder.

### Server setup
1. Download Ubuntu Desktop LTS 14.04 or 16.04
    * Can use Ubuntu Server as well.
2. Install it to a USB drive:
    * [for Windows](http://www.linuxliveusb.com)
    * [for Mac OSX](https://goo.gl/fgoM5R)
      <linux version>
3. Install Ubuntu on the server, use:
    * Username: dhisadmin
    * Password: dhis
    * Hostname: academyserver
4. Install SSH, Postgresql and Nginx using the terminal:  
```bash
sudo apt-get install ssh  
sudo apt-get install postgresql  
sudo apt-get install nginx
```
### DHIS2 Instance setup
This is a guide for setting up a general DHIS2 academy server. The server will run one DHIS2 instance and Moodle. If you want to add multiple instances or additional services Nginx needs to be configured to handle this.

#### Installing the dhis2-tools
##### Option 1
Install git and clone the dhis2-tools repository. Install the tools using the provided script.
```bash
sudo apt-get install git
git clone https://github.com/dhis2/dhis2-tools.git
cd dhis2-tools
sudo ./install.sh
```

##### Option 2
1. Install Java8
```bash
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
```
2. Install dhis2-tools
```bash
sudo add-apt-repository ppa:simjes91/dhis2-tools
sudo apt-get update
sudo apt-get install dhis2-tools
```

#### Postgres configuration
1. Copy `StandardConfig/postgres/dhis-postgres.conf` into the main folder for Postgres. Should look similar to this `/etc/postgresql/9.3/main/dhis-postgres.conf`.
2. Incude the `dhis-postgres.conf` file in the `/etc/postgresql/9.3/main/postgres.conf`
    * Add the following line to the file: `include = 'dhis-postgres.conf'`

#### Set up a new DHIS2 instance
This method can be used to create multiple DHIS2 instances. In the guide only one instance will be set up. This guide uses the credentials described in the [credentials section](#credentials). For more information on the different commands see the man pages. Use `apropos dhis` to see which man pages are available.
1. Create a DHIS2 admin account.
```bash
dhis2-create-admin dhisadmin
```
2. Create a new DHIS2 instance. The default port is 8080, you can change this by using the `-p portNumber` paramteter. Use the `-p` paramterer to create multiple instances, but remember to also configure Nginx for all the instances.
```bash
dhis2-instance-create dhis
```
3. Configure the system to use HTTP instead of HTTPS. Edit `/var/lib/dhis2/<instance name>/conf/server.xml`. Change proxyport to `proxyport="80"` and scheme to `scheme="http"`.
4. (Optional) If you want to restore a database, do it before the next step. If you want an empty database, skip this step. Restoring a database is explained in [Restore a database to a DHIS2 instance](#restore-a-database-to-a-dhis2-instance)
5. Deploy a WAR file to the DHIS2 instance. The standard command will get the latest stable version, see the man pages for other options.
```bash
dhis2-deploy-war dhis
```
6. Configure Nginx with `StandardConfig/nginx/academy.conf`
```bash
sudo dhis2-nginx academy.conf
```
7. Create the web folder and copy the provided content from `StandardConfig/html/`.
```bash
sudo mkdir /var/www
sudo chgrp www-data /var/www
sudo cp -r StandardConfig/html/* /var/www
```
You should now be able to access your DHIS2 instance in the web browser. Navigate to localhost and click the link to DHIS2. You can edit `/var/www/index.html` to fit your needs, for example if you have mutliple DHIS2 instances.

##### Restore a database to a DHIS2 instance
It is possible to use an existing database for a DHIS2 instance. Sample databases can be found at the [dhis2 download page](https://www.dhis2.org/downloads). Restore the database before deploying a WAR file.
```bash
wget https://www.dhis2.org/download/resources/2.23/dhis2-demo.zip
unzip dhis2-demo.zip
dhis2-restoredb dhis demo.sql
dhis2-startup dhis
```

### Moodle setup
