﻿using System.Collections.Generic;
using PayPal.Api;

public static class Configuration
{
    private static Setting setting
    {
        get
        {
            return CacheCus.setting != null ? CacheCus.setting : CacheCus.GetSetting(new LinqDataContext());
        }
    }
    static Configuration()
    {
        var config = GetConfig();
    }

    // Create the configuration map that contains mode and other optional configuration details.
    public static Dictionary<string, string> GetConfig()
    {
        Dictionary<string, string> sdkConfig = new Dictionary<string, string>();
        sdkConfig.Add("mode", "sandbox");
        sdkConfig.Add("connectionTimeout", "360000");
        sdkConfig.Add("requestRetries", "1");
        sdkConfig.Add("clientId", setting.clientId);
        sdkConfig.Add("clientSecret", setting.clientSecret);
        return sdkConfig;
        //return ConfigManager.Instance.GetProperties();
    }

    // Create accessToken
    private static string GetAccessToken()
    {
        // ###AccessToken
        // Retrieve the access token from
        // OAuthTokenCredential by passing in
        // ClientID and ClientSecret
        // It is not mandatory to generate Access Token on a per call basis.
        // Typically the access token can be generated once and
        // reused within the expiry window                
        //string accessToken = new OAuthTokenCredential(ClientId, ClientSecret, GetConfig()).GetAccessToken();
        string accessToken = new OAuthTokenCredential(GetConfig()).GetAccessToken();
        return accessToken;
    }

    // Returns APIContext object
    public static APIContext GetAPIContext(string accessToken = "")
    {
        // ### Api Context
        // Pass in a `APIContext` object to authenticate 
        // the call and to send a unique request id 
        // (that ensures idempotency). The SDK generates
        // a request id if you do not pass one explicitly. 
        var apiContext = new APIContext(string.IsNullOrEmpty(accessToken) ? GetAccessToken() : accessToken);
        apiContext.Config = GetConfig();

        // Use this variant if you want to pass in a request id  
        // that is meaningful in your application, ideally 
        // a order id.
        // String requestId = Long.toString(System.nanoTime();
        // APIContext apiContext = new APIContext(GetAccessToken(), requestId ));

        return apiContext;
    }

}