//
//  zkSignleTool.h
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/5.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QYZJUserModel.h"
@interface zkSignleTool : NSObject

+ (zkSignleTool *)shareTool;

@property(nonatomic,assign)BOOL isLogin;
@property(nonatomic,assign)BOOL isBindWebChat;
@property(nonatomic,strong)NSString * session_token;
//用户ID
@property(nonatomic,strong)NSString * session_uid;
@property(nonatomic,strong)NSString * openid_new;
@property(nonatomic,strong)NSString * telphone;
@property(nonatomic,strong)NSString * cityId;

@property(nonatomic,strong)NSString *nick_name;
@property(nonatomic,strong)NSString *isSame;
@property(nonatomic,strong)NSString * deviceToken;
@property(nonatomic,strong)QYZJUserModel *userModel;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,assign)NSInteger role;

@property(nonatomic,strong)NSString *questMoney;
@property(nonatomic,strong)NSArray *mannerArr;
@property(nonatomic,strong)NSArray *houseModelArr;
@property(nonatomic,strong)NSArray *renvoationTimeArr;


-(void)uploadDeviceToken;
@end
