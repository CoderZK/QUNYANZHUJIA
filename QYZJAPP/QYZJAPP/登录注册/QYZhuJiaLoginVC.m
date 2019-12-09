//
//  QYZhuJiaLoginVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZhuJiaLoginVC.h"
#import "QYZJFindPasswordVC.h"
#import "QYZJRegistVC.h"
@interface QYZhuJiaLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@end

@implementation QYZhuJiaLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"注册" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 0;
    button.clipsToBounds = YES;
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        QYZJRegistVC * vc =[[QYZJRegistVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIButton * button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 50, 30);
    [button1 setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.layer.cornerRadius = 0;
    button1.clipsToBounds = YES;
    [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];
    

}
- (IBAction)clickAction:(UIButton *)sender {
    if (sender.tag == 100) {
     
        if (self.phoneTF.text.length != 11){
            [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
            return;
        }
        if (self.passWordTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        if (self.passWordTF.text.length > 15 || self.passWordTF.text.length < 8) {
                   [SVProgressHUD showErrorWithStatus:@"请输入8~15位密码"];
                   return;
        }
        if (![NSString checkStingContainLetterAndNumberWithString:self.passWordTF.text]) {
            [SVProgressHUD showErrorWithStatus:@"密码至少包含一个数字和英文字母的混合"];
        }
        
        NSMutableDictionary * dict = @{}.mutableCopy;
        dict[@"mobile"] = self.phoneTF.text;
        dict[@"password"] = [self.passWordTF.text base64EncodedString];
        dict[@"type"] = @"0";
        [zkRequestTool networkingPOST:[QYZJURLDefineTool app_loginURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
                QYZJUserModel * userModel = [QYZJUserModel mj_objectWithKeyValues:responseObject[@"result"]];
                [zkSignleTool shareTool].session_token = responseObject[@"result"][@"token"];
                [zkSignleTool shareTool].session_uid = responseObject[@"result"][@"id"];
                [zkSignleTool shareTool].nick_name = responseObject[@"result"][@"nick_name"];
                [zkSignleTool shareTool].telphone = responseObject[@"result"][@"telphone"];
                [zkSignleTool shareTool].isLogin = YES;
                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
            }
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
            
            
        }];
        
        
        
    }else {
        QYZJFindPasswordVC * vc =[[QYZJFindPasswordVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
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
