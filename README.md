# Tailscale-Monitor
Monitors if new users connect through a tailscale instance on a server, if detected, it sends an e-mail.

# Uses
Prevents unauthorized access to tailscale devices, or private exit nodes.

# Installation

```
sudo apt update
sudo apt install mailutils
```

Edit `tailscale-monitor.sh` and set your *e-mailaddress*, save it.

```
touch /usr/local/bin/tailscale-monitor.sh
nano /usr/local/bin/tailscale-monitor.sh
```
Paste the `tailscale-monitor.sh` file

Save.

# Cron
```
sudo crontab -e
```
Add:
```
*/5 * * * * /usr/local/bin/tailscale-monitor.sh
```

To check every 5 minutes if a new user connected to tailscale. 

If so, take immediate action! Which could be: log into your tailscale admin and block the user in question, then do a security audit.
