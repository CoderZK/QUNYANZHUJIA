//
//  AppDelegate.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "AppDelegate.h"
#import "UMessage.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UserNotifications/UserNotifications.h>
#import <WXApi.h>
#import "TabBarController.h"
#import "LYGuideViewController.h"

#define UMKey @"5dd20ecd570df37fe800001c"
//友盟安全密钥//r6xbw5gy0zenei6x56xtm9wmkrrz653y

//新浪
#define SinaAppKey @"3386016286"
#define SinaAppSecret @"081a4efee947710f9082ab3f0a7b8de8"

//微信
#define WXAppID @"wxd9cbb4de3c914a74"
#define WXAppSecret @"eec2baba2df1bc7875ee259ca3b04e28"

//QQ
#define QQAppID @"1110158578"
#define QQAppKey @"6EwJ1flChWzz6zPO"



@interface AppDelegate ()<WXApiDelegate,UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [self instantiateRootVC];
    [self.window makeKeyAndVisible];
    
    self.window.backgroundColor = WhiteColor;
    
     [zkSignleTool shareTool].isUp = YES;
    
    //汉字
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMKey];

    [self configUSharePlatforms];

    [self confitUShareSettings];

    [self initUment:launchOptions];
    
    // 发送崩溃日志
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dataPath = [path stringByAppendingPathComponent:@"Exception.txt"];
    
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    
    if (data != nil) {
        
//        [self sendExceptionLogWithData:data path:dataPath];
        
    }
    
    return YES;
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppID appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];

    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppID/*设置QQ平台的appID*/  appSecret:QQAppKey redirectURL:@"http://mobile.umeng.com/social"];

    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey  appSecret:SinaAppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];


}

- (void)initUment:(NSDictionary *)launchOptions{
    //友盟适配https
    [UMessage startWithAppkey:UMKey launchOptions:launchOptions httpsEnable:YES];
    //    [UMessage startWithAppkey:UMKey launchOptions:launchOptions];
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}


//在用户接受推送通知后系统会调用
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{

        [UMessage registerDeviceToken:deviceToken];
    
       NSString * token = @"";
    
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13) {
               if (![deviceToken isKindOfClass:[NSData class]]) {
                   //记录获取token失败的描述
                   return;
               }
               const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
               token = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                                     ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                                     ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                                     ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
               NSLog(@"deviceToken1:%@", token);
           } else {
              token = [NSString
                              stringWithFormat:@"%@",deviceToken];
               token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
               token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
               token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
            
           }
          [zkSignleTool shareTool].deviceToken = token;
          [[zkSignleTool shareTool] uploadDeviceToken];
    
    
//        //2.获取到deviceToken
//        NSString *token2 = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
//        //将deviceToken给后台
//        NSLog(@"send_token:%@",token2);
//        [zkSignleTool shareTool].deviceToken = token;
//        [[zkSignleTool shareTool] uploadDeviceToken];
   
    
}


//设置根视图控制器
- (UIViewController *)instantiateRootVC{
    
    //没有引导页
    TabBarController * tabVc = [[TabBarController alloc] init];
    return tabVc;
//    //获取app运行的版本号
//    NSString *currentVersion =[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
//    //取出本地缓存的版本号
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *localVersion = [defaults objectForKey:@"appversion"];
//    if ([currentVersion isEqualToString:localVersion]) {
//        TabBarController *BarVC=[[TabBarController alloc] init];
//        return BarVC;
//        //        TabBarController * tabVc = [[TabBarController alloc] init];
//        //        return tabVc;
//
//    }else{
//        LYGuideViewController *guideVc = [[LYGuideViewController alloc] init];
//        return guideVc;
//    }
}
//跳转主页
- (void)showHomeVC{
    TabBarController  *BarVC=[[TabBarController alloc] init];
    self.window.rootViewController = BarVC;
    
    //更新本地储存的版本号
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"appversion"];
    //同步到物理文件存储
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark -支付宝 微信支付
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wxd9cbb4de3c914a74://pay"] ) {
        //微信
        [WXApi handleOpenURL:url delegate:self];
        
    }else {//友盟
        [[UMSocialManager defaultManager] handleOpenURL:url];
    }
    return YES;
    
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知,告诉支付界面要做什么
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wxd9cbb4de3c914a74://pay"] ) {
        
        [WXApi handleOpenURL:url delegate:self];
        
        
    }else {
        [[UMSocialManager defaultManager] handleOpenURL:url];
    }
    
    return YES;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wxd9cbb4de3c914a74://pay"] ) {
        [WXApi handleOpenURL:url delegate:self];
        
    }else {
        [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    }
    return YES;
}
//微信支付结果
- (void)onResp:(BaseResp *)resp {
    //发送一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPAY" object:resp];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
