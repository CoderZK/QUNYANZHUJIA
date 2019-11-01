//
//  QYZJHomeVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/1.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJHomeVC.h"
#import "QYZJNoDataView.h"
@interface QYZJHomeVC ()

@end

@implementation QYZJHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_loginURL] parameters:@{@"mobile":@"15295509430",@"password":@"YTEyMzQ1Njc="} success:^(NSURLSessionDataTask *task, id responseObject) {
           
           NSLog(@"---\n%@",responseObject);
           
           
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           
           NSLog(@"+++++\n%@",error);
           
           
       }];
       
    
    NSString * str = [NSString MD5ForUpper16Bate:@"a1234567"];
    NSString * str1 = [NSString MD5ForUpper32Bate:@"a1234567"];
    NSString * str2 = [@"a1234567" base64EncodedString];
    NSLog(@"%@",str);

    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
   
    
    
}

@end
