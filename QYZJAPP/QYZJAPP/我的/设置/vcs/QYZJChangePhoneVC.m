//
//  QYZJChangePhoneVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJChangePhoneVC.h"

@interface QYZJChangePhoneVC ()
@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;
@end

@implementation QYZJChangePhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"换绑手机";
}

- (IBAction)action:(UIButton *)button {
    
    if (button.tag == 100) {
        //发送验证码
        [self sendCode];
    }else if (button.tag == 101) {
        [self registerAction];
    }
}

- (void)sendCode {
    
    if (self.oldTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.oldTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    NSMutableDictionary * dataDict = @{@"phone":self.oldTF.text,@"type":@"1"}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_sendmobileURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
            [self timeAction];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}

- (void)timeAction {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStar) userInfo:nil repeats:YES];
    self.codeBt.userInteractionEnabled = NO;
    self.number = 60;
    
    
}

- (void)timerStar {
    _number = _number -1;
    if (self.number > 0) {
        [self.codeBt setTitle:[NSString stringWithFormat:@"%lds后重发",_number] forState:UIControlStateNormal];
    }else {
        [self.codeBt setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        self.codeBt.userInteractionEnabled = YES;
    }
    
    
}


- (void)registerAction{
    if (self.oldTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入原手机号"];
        return;
    }
    if (self.oldTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    
    if (self.codeTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }

    if (self.nPhoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入新手机号"];
        return;
    }
    if (self.nPhoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"old_phone"] = self.oldTF.text;
    dict[@"code"] = self.codeTF.text;
    dict[@"new_phone"] = self.nPhoneTF.text;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_editPhoneURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"换绑手机号成功"];
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
