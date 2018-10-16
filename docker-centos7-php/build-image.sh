#!/bin/bash

echo ""

echo -e "\nbuild docker official image\n"
sudo docker build -t cmhello/centos7-php:7.1 .

echo ""
