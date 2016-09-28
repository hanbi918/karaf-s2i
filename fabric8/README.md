#  mount nexus

```bash
  oc volumes dc/nexus --add --claim-name=nexus-storage --mount-path=/sonatype-work \
                     -t persistentVolumeClaim --overwrite
```  

#  mount jenkins
```bash
 oc volumes dc/jenkins --add --claim-name=jenkins-jobs --mount-path=/var/jenkins_home/jobs                      -t persistentVolumeClaim --overwrite
 oc volumes dc/jenkins --add --claim-name=jenkins-workspace --mount-path=/var/jenkins_home/workspace                 -t persistentVolumeClaim --overwrite
 ``` 

#  mount gogs
```bash
oc volumes dc/gogs --add --claim-name=gogs --mount-path=/app/gogs/data                      -t persistentVolumeClaim --overwrite
deploymentconfigs/gogs
```  
