#!/bin/bash
#	Phusion Passenger for Apache2 installation script

#updating repos
sudo apt-get update

#packages install
sudo apt-get install -y apache2 mysql-server libcurl4-openssl-dev apache2-prefork-dev libapr1-dev libaprutil1-dev

#install passenger gem
gem install passenger
sudo passenger-install-apache2-module
