//
//  QYZJChangePayPasswordTwoVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJChangePayPasswordTwoVC.h"

@interface QYZJChangePayPasswordTwoVC ()
@property (weak, nonatomic) IBOutlet UITextField *oldTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *nPhoneTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;
@property (weak, nonatomic) IBOutlet UIButton *confrimBt;
@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;
@end

@implementation QYZJChangePayPasswordTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置支付密码";
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

    NSMutableDictionary * dataDict = @{@"phone":[zkSignleTool shareTool].telphone,@"type":@"1"}.mutableCopy;
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

    if (self.codeTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    if (self.oldTF.text.length == 0 || self.oldTF.text.length > 6) {
        [SVProgressHUD showErrorWithStatus:@"请输入6位支付密码"];
        return;
    }
    
    if (![self isNumberWithStr:self.oldTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入6位数字密码"];
        return;
    }
    if (![self.oldTF.text isEqualToString:self.nPhoneTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码不一样"];
        return;
    }
   
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"mobile_verify"] = self.codeTF.text;
    dict[@"pay_pass"] = [self.oldTF.text base64EncodedString];
    dict[@"pay_pass_new"] = [self.oldTF.text base64EncodedString];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_setPayPassURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"设置支付密码成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });

        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
   
        
    }];
    
}

- (BOOL)isNumberWithStr:(NSString *)str {
    NSArray * arr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    for (int i = 0 ; i<str.length; i++) {
        NSString * ss   = [str substringWithRange:NSMakeRange(i, 1)];
        if (![arr containsObject:ss]) {
            return NO;
        }
    }
    return YES;
    
}


@end
