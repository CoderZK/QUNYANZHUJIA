//
//  zkRequestTongYongTool.m
//  QYZJAPP
//
//  Created by zk on 2019/11/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "zkRequestTongYongTool.h"


@implementation zkRequestTongYongTool

//通用的请求
- (void)requestWithUrl:(NSString *)url andDict:(NSMutableDictionary *)dict{
    
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            [SVProgressHUD dismiss];
            if (self.subject != nil) {
                [self.subject sendNext:responseObject];
            }
        }else {
            if (self.subject != nil) {
                [self.subject sendNext:nil];
            }
            [[UIApplication sharedApplication].keyWindow.rootViewController showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
         if (self.subject != nil) {
             [self.subject sendNext:nil];
         }
        
    }];
    
}
@end
