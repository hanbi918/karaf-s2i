#postgresql
````[root@master ~]# docker tag sameersbn/postgresql 172.30.93.175:5000/openshift/postgresql
[root@master ~]# docker push 172.30.93.175:5000/openshift/postgresql````

#create pg database  
````[root@master ~]# oc new-app openshift/postgresql -e 'PG_PASSWORD=1234' -e 'DB_NAME=kalix'````
````--> Found image bff714b (About an hour old) in image stream "postgresql" in project "openshift" under tag "latest" for "openshift/postgresql"````

    * This image will be deployed in deployment config "postgresql"
    * Port 5432/tcp will be load balanced by service "postgresql"
      * Other containers can access this service through the hostname "postgresql"
    * This image declares volumes and will default to use non-persistent, host-local storage.
      You can add persistent volumes later by running 'volume dc/postgresql --add ...'
    * WARNING: Image "postgresql" runs as the 'root' user which may not be permitted by your cluster administrator

````--> Creating resources with label app=postgresql ...
    deploymentconfig "postgresql" created
    service "postgresql" created
--> Success
    Run 'oc status' to view your app.````
