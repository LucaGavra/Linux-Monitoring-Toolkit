# Linux-Monitoring-Toolkit

A Linux system monitoring and self-healing toolkit using Bash and systemd.

## Features
- Self-heals nginx, MySQL, and SSH if they crash
- Automatically kills zombie processes hourly
- Cleans up disk space daily
- Fully automated using systemd and systemd timers

## Setup
1. Copy scripts to `/home/youruser/monitoring_toolkit/`
2. Add and enable `.service` file to `/etc/systemd/system/`
3. Run:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable your.timer
   sudo systemctl start your.timer
