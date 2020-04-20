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
#import "QYZJBindPhoneVC.h"
#import "QYZJSettingTVC.h"
@interface QYZhuJiaLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property(nonatomic,strong)UMSocialUserInfoResponse *resp;
@property (weak, nonatomic) IBOutlet UIButton *wechatBt;
@property (weak, nonatomic) IBOutlet UILabel *wechatLb;
@property(nonatomic,assign)BOOL isBind;
@end

@implementation QYZhuJiaLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wechatBt.hidden = self.wechatLb.hidden = isUPUPUP;
    
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
        //        if (self.passWordTF.text.length > 15 || self.passWordTF.text.length < 8) {
        //                   [SVProgressHUD showErrorWithStatus:@"请输入8~15位密码"];
        //                   return;
        //        }
        //        if (![NSString checkStingContainLetterAndNumberWithString:self.passWordTF.text]) {
        //            [SVProgressHUD showErrorWithStatus:@"密码至少包含一个数字和英文字母的混合"];
        //        }
        
        NSMutableDictionary * dict = @{}.mutableCopy;
        dict[@"mobile"] = self.phoneTF.text;
        dict[@"password"] = [self.passWordTF.text base64EncodedString];
        dict[@"type"] = @"0";
        [zkRequestTool networkingPOST:[QYZJURLDefineTool app_loginURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
                QYZJUserModel * userModel = [QYZJUserModel mj_objectWithKeyValues:responseObject[@"result"]];
                [zkSignleTool shareTool].session_token = userModel.token;
                [zkSignleTool shareTool].session_uid = userModel.ID;
                [zkSignleTool shareTool].nick_name = userModel.nick_name;;
                [zkSignleTool shareTool].telphone = userModel.telphone;
                [zkSignleTool shareTool].isLogin = YES;
                [zkSignleTool shareTool].isOpenSm = userModel.isOpenSm;
                
                [[zkSignleTool shareTool] uploadDeviceToken];
                
                if (userModel.app_openid.length > 0) {
                    [zkSignleTool shareTool].isBindWebChat = YES;
                }
                [self dismissViewControllerAnimated:YES completion:nil];
                
                if (userModel.nick_name.length == 0 || [userModel.nick_name isEqualToString:userModel.telphone]) {
                    
                    UIAlertController  * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",@"为保护您的隐私安全,请您尽快修改昵称"] preferredStyle:(UIAlertControllerStyleAlert)];
                    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入昵称" preferredStyle:UIAlertControllerStyleAlert];
                        
                        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                        
                        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            
                            UITextField*userNameTF = alertController.textFields.firstObject;
                            [self editUserInfoWithDict:@{@"nick_name":userNameTF.text}];
                            
                            
                        }]];
                        
                        [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
                            
                            textField.placeholder=@"请输入昵称";
                            
                            
                            
                        }];
                        
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];

                    }];
                    
                    [alertVC addAction:action1];
                    [alertVC addAction:action2];
                    
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
                    
                }
                
                
                
                
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

- (void)editUserInfoWithDict:(NSDictionary*)dict {
    
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_editInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"修改昵称成功"];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}



- (IBAction)webChatLogin:(id)sender {
    [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
}

- (void)showWebchatView {
    
    
    //验收
    UIAlertController  * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前手机号未绑定微信,请尽快绑定,以确保及时收到推送信息" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"以后再说" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"立即绑定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        self.isBind = YES;
        [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
        
    }];
    
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    
    
}


- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"授权失败"];
        }else {
            UMSocialUserInfoResponse *resp = result;
            NSLog(@"\n\n%@\n\n%@\n\n%@",resp.openid,resp.accessToken,resp.refreshToken);
            
            self.resp= resp;
            if (self.isBind) {
                [self bindWebChatWithOpenid:resp.openid];
            }else {
                [self loginWhitWebXinwithOpenId:resp.openid];
                
            }
            
        }
        
        
    }];
}

- (void)bindWebChatWithOpenid:(NSString *)openId {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"openId"] = openId;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_bindOpenIdURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"微信绑定成功"];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}
- (void)loginWhitWebXinwithOpenId:(NSString *)opendId{
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"appOpenid"] = opendId;
    
    NSLog(@"\n\n---%@",dict);
    
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_appweixin_loginURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"\n\n\n\====%@",responseObject);
        if ([responseObject[@"key"] intValue]== 1) {
            //绑定已经绑定
            
            QYZJUserModel * userModel = [QYZJUserModel mj_objectWithKeyValues:responseObject[@"result"]];
            [zkSignleTool shareTool].session_token = userModel.token;
            [zkSignleTool shareTool].session_uid = userModel.ID;
            [zkSignleTool shareTool].nick_name = userModel.nick_name;;
            [zkSignleTool shareTool].telphone = userModel.telphone;
            [zkSignleTool shareTool].isOpenSm = userModel.isOpenSm;
            [zkSignleTool shareTool].isLogin = YES;
            [zkSignleTool shareTool].isBindWebChat = YES;
            
            [[zkSignleTool shareTool] uploadDeviceToken];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
        }else if ([responseObject[@"key"] intValue]== 10001){
            //没有绑定
            
            QYZJBindPhoneVC * vc =[[QYZJBindPhoneVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = responseObject[@"result"];
            Weak(weakSelf);
            vc.dissBlock = ^(BOOL isShowHome) {
                if (isShowHome){
                    [weakSelf dismissViewControllerAnimated:NO completion:nil];
                }
            };
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
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
