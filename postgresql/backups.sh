MYBACKUPDIR=/var/lib/postgresql/backup
mkdir -p ${MYBACKUPDIR}
cd ${MYBACKUPDIR}

pg_dumpall -c -U postgres > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql
