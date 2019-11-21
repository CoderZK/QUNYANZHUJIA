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
            
        }];
        
//        [LLPassWordAlertView showWithTitle:@"支付密码" desStr:@"请输入支付密码" finish:^(NSString *pwStr) {
//            NSLog(@"输入密码完成:%@",pwStr);
//        } canelBtnOnClick:^(){
//            //取消显示按钮被点击
//            NSLog(@"取消按钮被点击");
//        }];
        
    }
}



@end
