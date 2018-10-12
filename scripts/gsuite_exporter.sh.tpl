#! /bin/bash

# Install Stackdriver Logging Agent
curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
bash install-logging-agent.sh

# Install Python and Pip
apt install -y git python-pip

# Install gsuite-exporter
# TODO: Replace this with `pip install gsuite-exporter` when released
echo "-e git+https://github.com/morgante/professional-services.git@gsuite-report-sync#egg=gsuite-exporter&subdirectory=infrastructure/gsuite-exporter" > requirements.txt
pip install -r requirements.txt

# Set up user
# adduser --disabled-password --gecos "" gsuite-exporter
# sudo su - gsuite-exporter

# Set up cronjob
(crontab -l 2>/dev/null; echo "${frequency} /usr/local/bin/gsuite-exporter --admin-user ${admin_user} --applications ${applications} --project-id ${project_id} > /var/log/gsuite-exporter.log 2>&1") | crontab -
