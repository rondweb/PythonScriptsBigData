#!/bin/bash
# A script to install mosquitto and create a user with remote access

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install mosquitto and mosquitto clients
sudo apt install -y mosquitto mosquitto-clients

# Enable mosquitto service
sudo systemctl enable mosquitto.service

# Create a user with the name iotdevice and the password 123456
sudo mosquitto_passwd -c /etc/mosquitto/passwd iotdevice 123456

# Edit the mosquitto configuration file
sudo nano /etc/mosquitto/mosquitto.conf

# Add the following lines to the end of the file
allow_anonymous false
persistence true
password_file /etc/mosquitto/passwd
persistence_location /mosquitto/data/
log_type subscribe
log_type unsubscribe
log_type websockets
log_type error
log_type warning
log_type notice
log_type information
log_dest file /mosquitto/log/mosquitto.log
log_dest stdout

# MQTT Default listener
listener 1883 0.0.0.0

# MQTT over WebSockets
listener 9001 0.0.0.0
protocol websockets

# Restart the mosquitto service
sudo systemctl restart mosquitto.service
