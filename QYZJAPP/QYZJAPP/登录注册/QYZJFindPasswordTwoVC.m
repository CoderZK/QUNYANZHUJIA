//
//  QYZJFindPasswordTwoVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFindPasswordTwoVC.h"

@interface QYZJFindPasswordTwoVC ()
@property (weak, nonatomic) IBOutlet UITextField *passWordTwoTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@end

@implementation QYZJFindPasswordTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"找回密码";
}

- (IBAction)action:(id)sender {
    
    if (self.passWordTF.text.length < 8 || self.passWordTF.text.length > 16) {
        [SVProgressHUD showErrorWithStatus:@"请输入8~16的包含字符和数字新密码"];
        return;
    }
    
    if (![NSString checkStingContainLetterAndNumberWithString:self.passWordTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入8~16的包含字符和数字新密码"];
        return;
    }
    if (![self.passWordTwoTF.text isEqualToString:self.passWordTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码不一样"];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"mobile"] = self.phoneStr;
    dict[@"type"] = @"1";
    dict[@"password"] = [self.passWordTF.text base64EncodedString];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_findPasswordURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

        
    }];
    
}


@end
