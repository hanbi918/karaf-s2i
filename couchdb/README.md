#couchdb
 ```bash
 docker tag klaemo/couchdb 172.30.93.175:5000/openshift/couchdb
  docker push 172.30.93.175:5000/openshift/couchdb````  
  
 oc new-app klaemo/couchdb -e 'COUCHDB_USER=admin' -e 'COUCHDB_PASSWORD=123456' -l 'name=couchdb'
 ```  
 ```bash
 oc volumes dc/couchdb --add --claim-name=couchdb-claim --mount-path=/opt/couchdb/data  -t persistentVolumeClaim --overwrite 
```
  
## export template
```oc export all --as-template=couchdb-template -l name=couchdb >couchdb-template.yaml```
