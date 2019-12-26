//
//  QYZJFindPasswordVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFindPasswordVC.h"
#import "QYZJFindPasswordTwoVC.h"
@interface QYZJFindPasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;

@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;

@end

@implementation QYZJFindPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"找回密码";
}
- (IBAction)confirm:(UIButton *)button {
    if (button.tag == 100) {
        //发送验证码
        [self sendCode];
    }else {
        
        if (self.phoneTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
            return;
        }
        if (self.phoneTF.text.length != 11) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
            return;
        }
        
        if (self.codeTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        }
        
        [SVProgressHUD show];
        NSMutableDictionary * dict = @{}.mutableCopy;
        dict[@"mobile"] = self.phoneTF.text;
        dict[@"mobile_verify"] = self.codeTF.text;
        [zkRequestTool networkingPOST:[QYZJURLDefineTool app_checkSendCodeURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [SVProgressHUD dismiss];
            if ([responseObject[@"key"] intValue]== 1) {
                
                QYZJFindPasswordTwoVC * vc =[[QYZJFindPasswordTwoVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.phoneStr = self.phoneTF.text;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
            
        }];
        
        
    }
    
}


- (void)sendCode {
    
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.phoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    NSMutableDictionary * dataDict = @{@"phone":self.phoneTF.text,@"type":@"1"}.mutableCopy;
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
