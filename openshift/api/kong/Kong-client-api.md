## Java API
使用https://github.com/vaibhav-sinha/kong-java-client.git源码版，maven库中版本为0.1.0，源码版为0.1.4
#### Kong初始化
    // KONG_ADMIN_URL: Kong管理端的URL,"http://kong-admin-yz2.apps.bogon.com"
    // KONG_API_URL: OAuth2相关的Url,null
    // needOAuth2Support: 是否支持OAuth2,false
    KongClient kongClient = new KongClient(KONG_ADMIN_URL, KONG_API_URL, needOAuth2Support);
#### Kong API 操作
*api创建,为兼容openshift访问,使用uri设置,API操作使用Api对象*

    // API_URIS是访问Kong代理地址的Uri
    // API_UPSTREAM_URL是被代理的url
    // API_METHODS 是Rest访问的Method集合
    private void createAPI() {
        Api request = new Api();
        request.setUris(Arrays.asList(API_URIS));
        request.setName("b2");
        request.setUpstreamUrl(API_UPSTREAM_URL);
        request.setMethods(Arrays.asList(API_METHODS));
        Api response = kongClient.getApiService().createApi(request);
    }

*api获取,参数可以是API的名字或者ID*

    Api response = kongClient.getApiService().getApi("b2"); 
    
*api修改,需要重新创建Api对象修改,修改时需要Api的ID参数*

    Api request = new Api();
    request.setName("A2");
    request.setUris(Arrays.asList(new String[]{"/a2"}));
    Api responseUpdate = kongClient.getApiService().updateApi(response.getId(), request);
    
*api删除,参数可以是API名字或者ID*

    kongClient.getApiService().deleteApi("A2");
    
*查询所有api*
    
    // 列表参数依次对应API中的id,upstreamUrl,name,retries,size,offset
    private static void getAllAPIs() {
        List<Api> apis = new ArrayList<>();
        ApiList apiList = kongClient.getApiService().listApis(null, null, null, null, 1L, null);
        apis.addAll(apiList.getData());
        while (apiList.getOffset() != null) {
            apiList = kongClient.getApiService().listApis(null, null, null, null, 1L, apiList.getOffset());
            apis.addAll(apiList.getData());
        }
    }
    
#### Kong Consumer 操作
*consumer创建,创建使用Consumer对象*

    private void createConsumer() {
        Consumer request = new Consumer();
        request.setCustomId("123");
        request.setUsername("test");
        request.setCreatedAt(new Date().getTime());
        Consumer response = kongClient.getConsumerService().createConsumer(request);
    }
    
*consumer获取,参数可以是Consumer的名字或者ID*

    Consumer response = kongClient.getConsumerService().getConsumer("test");
    
*consumer修改,需要重新创建Consumer对象修改,修改时需要Consumer的ID参数*

    Consumer request = new Consumer();
    request.setCustomId("456");
    Consumer responseUpdate = kongClient.getConsumerService().updateConsumer(response.getId(), request);
    
*consumer删除,参数可以是Consumer名字或者ID*

    kongClient.getConsumerService().deleteConsumer(response.getUsername());
    
*查询所有consumer*

    // 列表参数依次对应id,customId,username,size,offset
    private static void getAllConsumers() {
        List<Consumer> consumers = new ArrayList<>();
        ConsumerList consumerList = kongClient.getConsumerService().listConsumers(null, null, null, 1L, null);
        consumers.addAll(consumerList.getData());
        while (consumerList.getOffset() != null) {
            consumerList = kongClient.getConsumerService().listConsumers(null, null, null, 1L, consumerList.getOffset());
            consumers.addAll(consumerList.getData());
        }
    }
    
#### Kong Plugin 操作
*Plugin创建,支持的name可以从Kong客户端UI界面中查到*

    Plugin request = new Plugin();
    request.setConsumerId("00a45088-2bfa-42e1-a734-f269f459e4f3");
    request.setApiId("e3b49b66-aa7a-4168-822e-70d26a7d1e78");
    request.setName("jwt");
    Plugin response = kongClient.getPluginService().addPlugin(request);
    
*Plugin获取,参数必须是Plugin的ID*

    Plugin response = kongClient.getPluginService().getPlugin("4eac3b0f-2f26-4eb5-bde1-d777fdce3ef6");
    
*Plugin修改,enabled设置插件是否生效*

    Plugin request = new Plugin();
    //request.setEnabled(true);
    request.setName("jwt");
    Consumer consumer = kongClient.getConsumerService().getConsumer("test");
    request.setConsumerId(consumer.getId());
    Plugin response = kongClient.getPluginService().updatePlugin("5a96141e-eb0e-445d-ae61-5eb86abeb97b", request);
    
*Plugin删除,参数是Plugin ID*
    
    kongClient.getPluginService().deletePlugin("4eac3b0f-2f26-4eb5-bde1-d777fdce3ef6");
    
*查询所有Plugin*

    private void getAllPlugin() {
        List<Plugin> plugins = new ArrayList<>();
        PluginList pluginList = kongClient.getPluginService().listPlugins(null, null, null, null, 1L, null);
        plugins.addAll(pluginList.getData());
        while (pluginList.getOffset() != null) {
            pluginList = kongClient.getPluginService().listPlugins(null, null, null, null, 1L, pluginList.getOffset());
            plugins.addAll(pluginList.getData());
        }
    }
    
#### JWT DEMO 步骤
(1)创建API 
(2)创建consumer
(3)创建Jwt插件
(4)创建Jwt服务消费者并授信

    // 创建Jwt服务消费者并授信
    private void addCredential() {
        Consumer consumer = kongClient.getConsumerService().getConsumer("jwt_test");
        JwtCredential credential = kongClient.getJwtService().addCredentials(consumer.getId(), new JwtCredential());
        // iss
        System.out.println(credential.getKey());
        // 签名串
        System.out.println(credential.getSecret());
    }
    // Jwt字符串
    private void createJwtString() {
        // 签名加密base64
        // byte[] apiKeySecretBytes = DatatypeConverter.parseBase64Binary("2GlcnILSQrvhyvSJd2D9OF8UDUznpjaT");
        // 签名不加密
        byte[] apiKeySecretBytes = "2GlcnILSQrvhyvSJd2D9OF8UDUznpjaT".getBytes();
        Key signingKey = new SecretKeySpec(apiKeySecretBytes, SignatureAlgorithm.HS256.getJcaName());
    
        JwtBuilder builder = Jwts.builder()
             .setHeaderParam("alg", "HS256")
             .setHeaderParam("typ", "JWT")
             .claim("iss", "Ge7Y2ieHLnuCAyZJGkVoALl2cFGZL9GI")
             .claim("name", "jwt_test")
             .claim("iat", 1516239022)
             .signWith(SignatureAlgorithm.HS256, signingKey);
        System.out.println(builder.compact());
    }

#### Kong Url 访问

    curl -i -X GET --url http://kong-proxy-yz2.apps.bogon.com/jwt_test --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJHZTdZMmllSExudUNBeVpKR2tWb0FMbDJjRkdaTDlHSSIsIm5hbWUiOiJqd3RfdGVzdCIsImlhdCI6MTUxNjIzOTAyMn0.gh5PIb_87hNHEJvzYGiK7zfg0JoYiGqBL1AFnkNpykc'

    http://kong-proxy-yz2.apps.bogon.com/jwt_test?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJHZTdZMmllSExudUNBeVpKR2tWb0FMbDJjRkdaTDlHSSIsIm5hbWUiOiJqd3RfdGVzdCIsImlhdCI6MTUxNjIzOTAyMn0.gh5PIb_87hNHEJvzYGiK7zfg0JoYiGqBL1AFnkNpykc