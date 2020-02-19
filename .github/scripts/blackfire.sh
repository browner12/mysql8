#!/usr/bin/env bash

ls -al /

wget -q -O - https://packages.blackfire.io/gpg.key | apt-key add -
echo "deb http://packages.blackfire.io/debian any main" | tee /etc/apt/sources.list.d/blackfire.list

# Install Blackfire
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y blackfire-agent blackfire-php

agent="[blackfire]
ca-cert=
collector=https://blackfire.io
log-file=stderr
log-level=1
server-id=12345
server-token=67890
socket=unix:///var/run/blackfire/agent.sock
spec=
"

client="[blackfire]
ca-cert=
client-id=13579
client-token=24680
endpoint=https://blackfire.io
timeout=15s
"

echo "$agent" > "/etc/blackfire/agent"
echo "$client" > "/home/.blackfire.ini"

service php7.1-fpm restart
service php7.2-fpm restart
service php7.3-fpm restart
service php7.4-fpm restart
service blackfire-agent restart

