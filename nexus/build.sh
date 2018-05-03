#!/bin/sh
docker login -u admin -p $(oc whoami -t)  docker-registry.default.svc:5000; \
docker build -t docker-registry.default.svc:5000/openshift/kalix-nexus . ; \
docker push docker-registry.default.svc:5000/openshift/kalix-nexus
