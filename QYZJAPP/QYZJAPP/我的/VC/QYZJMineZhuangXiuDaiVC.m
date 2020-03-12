//
//  QYZJMineZhuangXiuDaiVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineZhuangXiuDaiVC.h"

@interface QYZJMineZhuangXiuDaiVC ()
@property (weak, nonatomic) IBOutlet UITextView *TV;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;

@end

@implementation QYZJMineZhuangXiuDaiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"装修贷";
    self.TV.layer.borderWidth = 0.6f;
    self.TV.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (IBAction)action:(id)sender {
    
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        return;
    }
    
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入电话"];
        return;
    }
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"real_name"] = self.nameTF.text;
    dict[@"mobile"] = self.phoneTF.text;
    dict[@"context"] = self.TV.text;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_addZhuangxiuURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"申请提交成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
    
}

@end
