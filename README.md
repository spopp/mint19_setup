# mint19_setup

Quickly setup a Linux Mint 19 Workstation with software.

## Usage
```
cd deployment
ansible-playbook -i local -K site.yml
```

# Manual steps - not yet ansiblized

## Dnsmasq manual setup
Connect to your wireless network



### Disable the systemd-resolv service
```
systemctl stop --now systemd-resolved.service
systemctl disable --now systemd-resolved.service
```

### Dnsmasq config

```

in /etc/nsswitch.conf - mdns4_minimal and dns swap places:
hosts:          files dns [NOTFOUND=return] mdns4_minimal myhostname

in /etc/NetworkManager/NetworkManager.conf:
[main]
plugins=ifupdown,keyfile
dns=none

Check configuration:
sudo systemctl restart dnsmasq
dnsmasq --test

sudo systemctl restart dnsmasq
sudo systemctl restart networking
```

Enable dns logging and watch for circular dns requests
which need to be corrected if found

```
tail -f /var/log/syslog &
```

## pip/pip3 - confusion resolution
There was no pip3.  It was just named pip for python3
So it had to be called by python3 -m pip ...
The ansible pip command can not use executable pip3
since it is pip3 is not on mint19

Solution:  Place an executable bash script called pip3
in /usr/local/bin. Then I and asible can use the pip3 command.3
