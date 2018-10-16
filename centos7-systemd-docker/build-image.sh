#!/bin/bash

echo ""

echo -e "\nbuild docker base centos7 image\n"
sudo docker build -t cmhello/centos7-systemd:1.0 .

echo ""
