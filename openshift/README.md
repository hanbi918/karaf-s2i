# 设置registry固定ip
oc get svc/docker-registry -o yaml > registry-svc.yaml
然后修改里面的ClusterIP，再删除重建
oc delete svc/docker-registry
oc create -f registry-svc.yaml
