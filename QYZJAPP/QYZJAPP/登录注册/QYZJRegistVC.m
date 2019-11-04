//
//  QYZJRegistVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJRegistVC.h"

@interface QYZJRegistVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTwoTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;
@property (weak, nonatomic) IBOutlet UIButton *confrimBt;

@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;

@end

@implementation QYZJRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.phoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    NSMutableDictionary * dataDict = @{@"phone":self.phoneTF.text,@"type":@"1"}.mutableCopy;
    dataDict[@"deviceId"] = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
//    [zkRequestTool networkingPOST:[HHYURLDefineTool sendValidCodeURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
//        if ([responseObject[@"code"] intValue]== 0) {
//            [self timeAction];
//        }else {
//            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
//        }
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        
//        
//    }];
    
}

- (void)registerAction{
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
        return;
    }
    
    if (self.passWordTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    NSMutableDictionary * dataDict = @{@"phone":self.phoneTF.text}.mutableCopy;
    dataDict[@"code"] = self.codeTF.text;
    dataDict[@"password"] = [NSString stringToMD5:self.passWordTF.text];
//    [zkRequestTool networkingPOST:[HHYURLDefineTool validCodeURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
//        if ([responseObject[@"code"] intValue]== 0) {
//            if (self.isTherd) {
//                [self bindOrRegist];
//            }else {
//                HHYAddZiLiaoTVC * vc =[[HHYAddZiLiaoTVC alloc] init];
//                vc.passdWord = self.passWordTF.text;
//                vc.phoneStr = self.phoneTF.text;
//                vc.yaoQingStr = self.yaoQingCodeTF.text;
//                vc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//        }else {
//            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
//        }
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        
//        
//    }];
    
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
