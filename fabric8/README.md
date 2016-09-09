#mount nexus
````oc volumes rc/nexus --add --claim-name=nexus --mount-path=/sonatype-work/storage \
                     -t persistentVolumeClaim --overwrite````  
#mount jenkins
