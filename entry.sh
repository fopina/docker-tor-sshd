#!/bin/sh

/usr/bin/ssh-keygen -A

# check if root has password defined

if grep -q ^root:: /etc/shadow; then
	echo "Setting random password for user root"
	RND=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
	echo root:$RND | chpasswd
	echo "Temporary password for root :: $RND"
	echo
fi

rm -f /var/log/tor/notices.log

sed -e s/PORT_TO_REPLACE/$TOR_PORT/ /etc/tor/torrc.tpl > /etc/tor/torrc

s6-setuidgid tor tor --runasdaemon 1

echo "Waiting for tor:"
while ! grep -qF '100%: Done' /var/log/tor/notices.log
do
  sleep 1
  echo -n .
done

echo " Done"
echo
echo "Your .onion sshd: $(cat /var/lib/tor/hidden_service/hostname) port $TOR_PORT"

exec "$@"