//
//  QYZJZhiFuVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJZhiFuVC.h"
#import "LLPassWordAlertView.h"
@interface QYZJZhiFuVC ()
@property (weak, nonatomic) IBOutlet UIButton *payBt;
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UIImageView *imgVT2;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;

@end

@implementation QYZJZhiFuVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
}
- (IBAction)clickAction:(UIButton *)sender {
    if (sender.tag == 100) {
        self.imgV1.image = [UIImage imageNamed:@"xuanze_2"];
        self.imgVT2.image = [UIImage imageNamed:@"xuanze_1"];
    }else if (sender.tag == 101) {
        self.imgV1.image = [UIImage imageNamed:@"xuanze_1"];
        self.imgVT2.image = [UIImage imageNamed:@"xuanze_2"];
    }else {
        
        [LLPassWordAlertView showWithTitle:@"支付密码" desStr:@"请输入支付密码" finish:^(NSString *pwStr) {
            
            [self checkPayPasswordWith:pwStr];
            
        }];
    }
}

//检测密码
- (void)checkPayPasswordWith:(NSString *)password {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pay_pass"] = [password base64EncodedString];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_checkPayPassURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            NSInteger a  = [[NSString stringWithFormat:@"%@",responseObject[@"result"]] intValue];
            if (a==0) {
                [SVProgressHUD showErrorWithStatus:@"支付密码为空"];
            }else if (a==1) {
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                               [self.navigationController popToRootViewControllerAnimated:YES];
                           });
            }else if (a==2){
                 [SVProgressHUD showErrorWithStatus:@"支付密码错误"];
            }
           
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

        
    }];
    
    
}

@end
