#!/bin/bash

apt install dante-server

cat << EOF > /etc/danted.conf

logoutput: syslog
user.privileged: root
user.unprivileged: nobody

internal: 0.0.0.0 port=1080

external: enp1s0

socksmethod: none
clientmethod: none

client pass {
        from: 0.0.0.0/0 to: 0.0.0.0/0
        log: connect disconnect error
}

socks pass {
        from: 0.0.0.0/0 to: 0.0.0.0/0
        log: connect disconnect error
}
EOF

sudo iptables -A INPUT -p tcp --dport 1080 -j ACCEPT

service danted start
service danted status
