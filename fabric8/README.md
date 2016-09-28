#  mount nexus

```bash
  oc volumes dc/nexus --add --claim-name=nexus-storage --mount-path=/sonatype-work \
                     -t persistentVolumeClaim --overwrite
```  

#  mount jenkins
