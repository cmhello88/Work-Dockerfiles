#!/bin/bash

echo ""

echo -e "\nbuild docker official image\n"
sudo docker build -t cmhello/centos7-nginx:1.8.0 .

echo ""
