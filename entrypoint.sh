#!/bin/sh

# Add Crontab Jobs
chmod 0644 /etc/cron.d/*
crontab /etc/cron.d/*

# Add Custom Service
for f in /etc/service.d/*; do
    if [ -f "$f" ]; then
        name=`basename $f`

        mkdir "/etc/service/$name"
        cp $f "/etc/service/$name/run"
        chmod +x "/etc/service/$name/run"
    fi
done