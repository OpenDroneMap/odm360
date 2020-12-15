#!/bin/bash

# retrieve the child's old uuid and change the hostname of child accordingly
old_hostname_prefix=`sudo -u postgres psql -d odm360 -t -c "SELECT (device_uuid) FROM device;"`

# Remove existing device records and generate a new ID
sudo -u postgres psql -d odm360 -t -c "TRUNCATE TABLE device;"
sudo -u postgres psql -d odm360 -t -c "INSERT INTO device (name) VALUES ('picam');"
hostname_prefix=`sudo -u postgres psql -d odm360 -t -c "SELECT (device_uuid) FROM device;"`

# Apply new ID to hosts
echo $hostname_prefix | sudo tee /etc/hostname
sudo sed -i "s/$old_hostname_prefix/$hostname_prefix/g" /etc/hosts

