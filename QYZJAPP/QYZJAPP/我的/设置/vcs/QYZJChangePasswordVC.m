//
//  QYZJChangePasswordVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJChangePasswordVC.h"
#import "TabBarController.h"
@interface QYZJChangePasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *oldpassdTF;
@property (weak, nonatomic) IBOutlet UITextField *nPassdTF;
@property (weak, nonatomic) IBOutlet UITextField *nTwoPassdTF;
@end

@implementation QYZJChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    
}

- (IBAction)confirmAction:(id)sender {
    
//    if (![NSString checkStingContainLetterAndNumberWithString:self.oldpassdTF.text] || self.oldpassdTF.text.length < 8 || self.oldpassdTF.text.length > 16) {
//        [SVProgressHUD showErrorWithStatus:@"请输入8~16的包含字符和数字"];
//        return;
//    }
    
    if (self.oldpassdTF.text.length ==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入旧密码"];
        return;
    }
    
    if (![NSString checkStingContainLetterAndNumberWithString:self.nPassdTF.text] || self.nPassdTF.text.length < 8 || self.nPassdTF.text.length > 16) {
        [SVProgressHUD showErrorWithStatus:@"请输入8~16的包含字符和数字新密码"];
        return;
    }
    
    if (self.nTwoPassdTF.text != self.nPassdTF.text) {
        [SVProgressHUD showErrorWithStatus:@"两次密码不一样"];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"old_pass"] = [self.oldpassdTF.text base64EncodedString];
    dict[@"new_pass"] = [self.nPassdTF.text base64EncodedString];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_editPasswordURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [zkSignleTool shareTool].session_token = nil;
                [zkSignleTool shareTool].isLogin = NO;
                [self.navigationController popToRootViewControllerAnimated:NO];
                TabBarController * tab = (TabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                
                 BaseNavigationController * navc = [[BaseNavigationController alloc] initWithRootViewController:[[QYZhuJiaLoginVC alloc] init]];
                [tab presentViewController:navc animated:YES completion:nil];
                
                tab.selectedIndex = 0;
            });
        }else if ([responseObject[@"key"] intValue]== 6){
            [SVProgressHUD showErrorWithStatus:@"旧密码错误"];
        }else {
             [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
  
        
    }];
    
    
}


@end
