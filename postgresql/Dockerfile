FROM sameersbn/postgresql
#ADD backups-cron /etc/cron.d/backups-cron
RUN cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
ADD backups.sh /etc/cron.daily/backups.sh
