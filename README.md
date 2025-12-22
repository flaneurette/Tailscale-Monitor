# Tailscale-Monitor
Monitors if new users connect through a tailscale instance on a server, if detected, it sends an e-mail.

While tailscale is considered safe, we can never rule out unauthorized use. So in order to detect that, we can monitor tailscale and see if a new user has connected. The .sh file checks every 5 minutes if a new user is connected. If so, it send an e-mail to the administrator.

# Tailscale settings:

### Require approval for new devices
`tailscale set --auto-approve=false`

### Enable key expiry
`tailscale set --key-expiry=30d`

### Tailscale admin

Use Tailscale's Admin Console:

- Enable device authorization - you must manually approve each new device
- Set up MFA/2FA on your Tailscale account
- Use ACL policies to limit what each device can access
- Enable audit logging

# Uses
Prevents unauthorized access to tailscale devices, or private exit nodes. This script can tell if an unauthorized attempt occured in case of a breach. Which can be useful, especially if the webadmin has been comproised in unforseen ways. This adds an extra layer of security, because now we can tell for certain that a breach occured. If the tailscale webconsole is compromised, we might *never* know it. Now we do.

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

# Optional

### Make script immutable 
Even root can't modify without removing attribute:
`chattr +i /usr/local/bin/tailscale-monitor.sh`

### To modify later:
`chattr -i /usr/local/bin/tailscale-monitor.sh`
