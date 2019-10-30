//
//  zkSignleTool.h
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/5.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkSignleTool : NSObject

+ (zkSignleTool *)shareTool;

@property(nonatomic,assign)BOOL isLogin;
@property(nonatomic,strong)NSString * session_token;
//用户ID
@property(nonatomic,strong)NSString * session_uid;
@property(nonatomic,strong)NSString * deviceToken;
-(void)uploadDeviceToken;
@end
