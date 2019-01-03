# mint19_setup

Quickly setup a Linux Mint 19 Workstation with software.

Keep private data out of all public repositories


# Manual steps - not yet ansiblized


## Dnsmasq
NetworkManager tries to use a dnsmasq plugin to resolve dns addresses
but the plugin does not use configuration files properly.

To avoid this problem

1) 'apt install dnsmasq' to run the dnsmasq service

2) disable the NetworkManager dnsmasq plugin

3) do not use the resolvconf services but the dnsmasq service instead


### in /etc/nsswitch.conf

mdns4_minimal and dns swap places leaving dns first


```
hosts:          files dns [NOTFOUND=return] mdns4_minimal myhostname
```

### in /etc/NetworkManager/NetworkManager.conf

comment out dnsmasq 

```
[main]
plugins=ifupdown,keyfile
# dns=dnsmasq
```

### in /etc/dnsmasq/dnsmasq.conf

Eliminate the use of resolv.conf

- uncomment: domain-needed - to always send the requested domain
- uncomment: bogus-priv    - to prevent non-routed address queries
- uncomment: log-queries   - to view queries in /var/log/system
- uncomment: bogus-nxdomain=64.94.110.11 - to preveint wildcard A records from this ip
- uncomment and edit: resolv-file=/etc/my-resolv.conf
- Place your dns entries at end of dnsmasq.conf


Then place the empty file to be used instead of resolv.conf

```
sudo touch /etc/my-resolv.conf
```



Check configuration:

```
sudo systemctl stop dnsmasq
dnsmasq --test

sudo systemctl restart dnsmasq
sudo systemctl restart networking
sudo systemctl restart NetworkManager
```

View logging and watching for run-away circular dns requests

```
tail -f /var/log/syslog &
```

## Usage
```
cd deployment
ansible-playbook -i local -K site.yml
```
