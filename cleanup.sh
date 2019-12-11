#!/usr/bin/bash

systemctl stop prometheus
systemctl disable prometheus
rm -rf /etc/prometheus
rm /lib/systemd/system/prometheus.service
systemctl daemon-reload
