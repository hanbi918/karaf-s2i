#couchdb
 ````docker tag klaemo/couchdb 172.30.93.175:5000/openshift/couchdb````  
 ````docker push 172.30.93.175:5000/openshift/couchdb````  
 ````oc new-app klaemo/couchdb -e 'COUCHDB_USER=admin' -e 'COUCHDB_PASSWORD=123456' -l 'name=couchdb'````  
 ``oc volumes dc/couchdb --add --claim-name=couchdb-claim --mount-path=/usr/local/var/lib/couchdb \
                     -t persistentVolumeClaim --overwrite  
``
  
## export template
``oc export all --as-template=couchdb-template -l name=couchdb >couchdb-template.yaml``
