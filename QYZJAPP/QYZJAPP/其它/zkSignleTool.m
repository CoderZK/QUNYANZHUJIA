//
//  zkSignleTool.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/5.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkSignleTool.h"
#import "zkRequestTool.h"
static zkSignleTool * tool = nil;


@implementation zkSignleTool

+ (zkSignleTool *)shareTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[zkSignleTool alloc] init];
    });
    return tool;
}

-(void)setIsLogin:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)isLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
}

- (void)setIsBindWebChat:(BOOL)isBindWebChat {
    [[NSUserDefaults standardUserDefaults] setBool:isBindWebChat forKey:@"isBindWebChat"];
     [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isBindWebChat {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isBindWebChat"];
}

-(void)setSession_token:(NSString *)session_token
{
    
    [[NSUserDefaults standardUserDefaults] setObject:session_token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)session_token
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}
- (void)setCityId:(NSString *)cityId {
    [[NSUserDefaults standardUserDefaults] setObject:cityId forKey:@"cityId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)cityId {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"cityId"] == nil ) {
        return @"0";
    }else {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"cityId"];
    }
}

-(void)setSession_uid:(NSString *)session_uid
{
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",session_uid] forKey:@"id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)session_uid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
}

- (void)setNick_name:(NSString *)nick_name {
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",nick_name] forKey:@"nick_name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)nick_name {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"nick_name"];
}

- (void)setOpenid_new:(NSString *)openid_new {
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",openid_new] forKey:@"openid_new"];
       [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)openid_new {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"openid_new"];
}

- (void)setTelphone:(NSString *)telphone {
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",telphone] forKey:@"telphone"];
          [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)telphone {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"telphone"];
}

- (void)setDataArray:(NSArray *)dataArray {
    [[NSUserDefaults standardUserDefaults]setObject:dataArray forKey:@"dataArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)dataArray {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"dataArray"];
}

-(void)uploadDeviceToken
{
    if (self.isLogin&&self.session_token&&self.deviceToken)
    {
        NSDictionary * dic = @{
                               @"token":self.session_token,
                               @"type":@1,
                               @"deviceToken":self.deviceToken
                               };
//        [zkRequestTool networkingPOST:[zkFMURL GETapi_user_upTokenURL] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//            
//            NSLog(@"上传友盟推送成功\n%@",responseObject);
//            
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"%@",error);
//        }];
    }
    
}

- (void)setRole:(NSInteger)role {
    [[NSUserDefaults standardUserDefaults] setInteger:role forKey:@"role"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)role {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"role"];
}

//- (void)setRole:(NSString *)role {
//    [[NSUserDefaults standardUserDefaults] setInteger:role forKey:@"role"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//- (NSString *)role {
//    return [[NSUserDefaults standardUserDefaults] integerForKey:@"role"];
//}

- (void)setQuestMoney:(NSString *)questMoney {
    [[NSUserDefaults standardUserDefaults] setObject:questMoney forKey:@"questMoney"];
       [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)questMoney {
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"questMoney"];
}

- (void)setMannerArr:(NSArray *)mannerArr {
    [[NSUserDefaults standardUserDefaults] setObject:mannerArr forKey:@"mannerArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)mannerArr  {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"mannerArr"];
}

- (void)setHouseModelArr:(NSArray *)houseModelArr {
    [[NSUserDefaults standardUserDefaults] setObject:houseModelArr forKey:@"houseModelArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)houseModelArr {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"houseModelArr"];
}

- (void)setRenvoationTimeArr:(NSArray *)renvoationTimeArr {
    [[NSUserDefaults standardUserDefaults] setObject:renvoationTimeArr forKey:@"renvoationTimeArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)renvoationTimeArr {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"renvoationTimeArr"];
}

- (void)setDeviceToken:(NSString *)deviceToken {
    
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (NSString *)deviceToken {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"] == nil) {
        return @"1";
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    
}
- (void)setUserModel:(QYZJUserModel *)userModel {
    if (userModel) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userModel];
        if (data) {
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userModel"];
        }
    }
}
- (QYZJUserModel *)userModel{
    //取出
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userModel"];
    if (data) {
        QYZJUserModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return model;
    }
    return nil;
    
}

@end
