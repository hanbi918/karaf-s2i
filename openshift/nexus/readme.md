# npm 私服下载库
http://nexus-yz.apps.bogon.com/nexus/content/groups/npm-group/
# 下载步骤,以kalix-vue-navigate@1.0.7为例
1. npm config set registry http://nexus-yz.apps.bogon.com/nexus/content/groups/npm-group/
2. npm -loglevel info install kalix-vue-navigate@1.0.7
# npm 私服发布库
http://nexus-yz.apps.bogon.com/nexus/content/repositories/npm-host/
# 发布库步骤
1. npm config set email 1907310@qq.com
其中邮箱为nexus中admin用户设置的邮箱
2. npm config set always-auth true
3. npm config set _auth YWRtaW46YWRtaW4xMjM=
其中YWRtaW46YWRtaW4xMjM=为admin:admin123的base64编码
4. npm publish -registry http://nexus-yz.apps.bogon.com/nexus/content/repositories/npm-host/
# 附base64编码生成
1. 定义in.txt，内容为admin:admin123
2. 命令行下执行 certutil /encode in.txt out.txt