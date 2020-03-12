//
//  QYZJChangePayPasswordOneVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJChangePayPasswordOneVC.h"
#import "QYZJChangePayPasswordTwoVC.h"
@interface QYZJChangePayPasswordOneVC ()
@property (weak, nonatomic) IBOutlet UITextField *oldpassdTF;
@property (weak, nonatomic) IBOutlet UITextField *nPassdTF;
@property (weak, nonatomic) IBOutlet UITextField *nTwoPassdTF;
@end

@implementation QYZJChangePayPasswordOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改支付密码";
    
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 100) {
        QYZJChangePayPasswordTwoVC * vc =[[QYZJChangePayPasswordTwoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        
        [self registerAction];
        
    }
}

- (void)registerAction{

  
    
    if (self.oldpassdTF.text.length == 0 || self.oldpassdTF.text.length > 6) {
        [SVProgressHUD showErrorWithStatus:@"请输入6位旧支付密码"];
        return;
    }
    
    if (![self isNumberWithStr:self.oldpassdTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入6位数字密码"];
        return;
    }

       if (self.nPassdTF.text.length == 0 || self.nPassdTF.text.length > 6) {
           [SVProgressHUD showErrorWithStatus:@"请输入6位新支付密码"];
           return;
       }
       
       if (![self isNumberWithStr:self.nPassdTF.text]) {
           [SVProgressHUD showErrorWithStatus:@"请输入6位数字密码"];
           return;
       }
    
    if (![self.nPassdTF.text isEqualToString:self.nTwoPassdTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码不一样"];
        return;
    }
   
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pay_pass"] = [self.oldpassdTF.text base64EncodedString];
    dict[@"pay_pass_new"] = [self.nPassdTF.text base64EncodedString];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_checkPayPassURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"修改支付密码成功"];
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
