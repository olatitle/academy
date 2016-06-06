# DHIS2 Academy Setup Guide

summary

## Content
1. [Intro](#intro)
2. [Credentials](#credentials)
3. [General Information](#general-information)

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
WiFi | SSID:password | dhis2:<no password>

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
--------- | ------
EdgeRouter PoE, including power adapter (48V) | #1
Server: Brix Pro, including power adapter | #2
WiFi Access Point Dual Band | #3
WiFi Access Point 2.4GHz | #4
Ethernet cables x3 |

**All of the equipment is marked with numbers, only connect the corresponding numbers so that the equipment is not damaged.**

<insert screenshot here> screenshot

## Easy setup
Setting up an academy server using this part of the guide will require you to clone an existing server image onto your server, using Clonezilla.

Requirements:
* The Ubuntu Image:
  * [Dropbox](https://www.dropbox.com/sh/ldus8wg06sw6vtu/AAClEz1EzW0U67dOXOafdOzea?dl=0)
  <add more links>
* [Clonezilla](http://clonezilla.org/downloads.php)
* Linux Live USB, use the following links to create it:
  * [for Windows](http://www.linuxliveusb.com)
  * [for Mac OSX](https://goo.gl/fgoM5R)
    <linux version>

The image was created using a 256GB ssd, your harddisk must be equal or greater in size <sjekk info her>

... guide for this ...

## Setup from scratch
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
