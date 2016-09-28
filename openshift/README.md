# 设置registry固定ip
oc get svc/docker-registry -o yaml > registry-svc.yaml
然后修改里面的ClusterIP，再删除重建
oc delete svc/docker-registry
oc create -f registry-svc.yaml
# create registry console

  create registry console from other template.
  
  ```bash
  oc create route passthrough --service registry-console --port registry-console -n default --hostname=registry.sokylin.com.cn
   oc create -f cockpit-oauth.yaml
  ```
