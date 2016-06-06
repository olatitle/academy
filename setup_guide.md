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

The harddisk image can be downloaded from:
* [Dropbox](https://www.dropbox.com/sh/ldus8wg06sw6vtu/AAClEz1EzW0U67dOXOafdOzea?dl=0)
<add more links>
