#!/usr/bin/bash

systemctl disable prometheus
rm -rf /etc/prometheus
rm /lib/systemd/system/prometheus.service
systemctl daemon-reload
systemctl stop prometheus
