//
//  QYZJZhiFuVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJZhiFuVC.h"
#import "LLPassWordAlertView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
@interface QYZJZhiFuVC ()
@property (weak, nonatomic) IBOutlet UIButton *payBt;
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UIImageView *imgVT2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV3;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;
@property (weak, nonatomic) IBOutlet UIButton *bt1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTwo;
@property (weak, nonatomic) IBOutlet UIImageView *payImgVone;
@property (weak, nonatomic) IBOutlet UILabel *titleOneLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consThree;
@property (nonatomic,strong)NSDictionary *payDic;
@property(nonatomic,assign)NSInteger payType;

@end

@implementation QYZJZhiFuVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WWWWX:) name:@"WXPAY" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZFBPAY:) name:@"ZFBPAY" object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.payType = 0;
    
    if (self.model.is_need_wechat_pay) {
        self.consThree.constant = 0;
        self.consTwo.constant = 131.2;
        self.payImgVone.hidden = self.bt1.hidden = self.imgV1.hidden = self.titleOneLB.hidden = YES;
    }
    
}
- (IBAction)clickAction:(UIButton *)sender {
    
    if (sender.tag == 100) {
        self.imgV1.image = [UIImage imageNamed:@"xuanze_2"];
        self.imgVT2.image = [UIImage imageNamed:@"xuanze_1"];
        self.imgV3.image = [UIImage imageNamed:@"xuanze_1"];
        self.payType = sender.tag - 100;
    }else if (sender.tag == 101) {
        self.imgV1.image = [UIImage imageNamed:@"xuanze_1"];
        self.imgVT2.image = [UIImage imageNamed:@"xuanze_2"];
        self.imgV3.image = [UIImage imageNamed:@"xuanze_1"];
        self.payType = sender.tag - 100;
    }else if (sender.tag == 102){
        self.imgV1.image = [UIImage imageNamed:@"xuanze_1"];
        self.imgVT2.image = [UIImage imageNamed:@"xuanze_1"];
        self.imgV3.image = [UIImage imageNamed:@"xuanze_2"];
        self.payType = sender.tag - 100;
        
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
                //加测密码成功
                [self payAction];
            }else if (a==2){
                 [SVProgressHUD showErrorWithStatus:@"支付密码错误"];
            }
           
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

        
    }];
    
    
}

- (void)payAction {

    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pay_type"] = @"2";
    dict[@"pay_money"] = @(self.model.money);
    dict[@"answer_id"] = self.model.ID;
    dict[@"demand_id"] = self.model.ID;
    dict[@"media_id"] = self.model.ID;
    dict[@"is_second_pay"] = @0;
    dict[@"type"] = @(self.type);
    dict[@"id"] = self.ID;
    dict[@"turnover_type"] = @(self.type - 6);
    NSString * url = [QYZJURLDefineTool user_createBalanceOrderURL];
   
    if (self.payType == 1) {
        url = [QYZJURLDefineTool user_createWxOrderURL];
    }else if (self.payType == 2){
        url = [QYZJURLDefineTool user_createAlipayOrderURL];
    }
    
    if (self.model.is_need_wechat_pay) {
        url = [QYZJURLDefineTool user_createPayNewURL];
    }
    
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
      
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
      
        
    }];
    
    
}


//NSMutableDictionary * dict = @{}.mutableCopy;
//dict[@"demand_id"] = ID;
//dict[@"pay_money"] = @(money);
//[zkRequestTool networkingPOST:[QYZJURLDefineTool user_payDemandURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//
//    [SVProgressHUD dismiss];
//    if ([responseObject[@"key"] intValue]== 1) {
//       
//       
//        
//    }else {
//        [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
//    }
//    
//} failure:^(NSURLSessionDataTask *task, NSError *error) {
//    
// 
//    
//}];



#pragma mark -微信、支付宝支付
- (void)goWXpay {
    PayReq * req = [[PayReq alloc]init];
    req.partnerId = [NSString stringWithFormat:@"%@",self.payDic[@"partnerId"]];
    req.prepayId =  [NSString stringWithFormat:@"%@",self.payDic[@"prepayId"]];
    req.nonceStr =  [NSString stringWithFormat:@"%@",self.payDic[@"nonceStr"]];
    //注意此处是int 类型
    req.timeStamp = [self.payDic[@"timeStamp"] intValue];
    req.package =  [NSString stringWithFormat:@"%@",self.payDic[@"package"]];
    req.sign =  [NSString stringWithFormat:@"%@",self.payDic[@"sign"]];
    
    //发起支付
    [WXApi sendReq:req];
    
}

//微信支付结果处理
- (void)WWWWX:(NSNotification *)no {
    
    BaseResp * resp = no.object;
    if (resp.errCode==WXSuccess)
    {
        
        [SVProgressHUD showSuccessWithStatus:@"帖子置顶成功!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
    else if (resp.errCode==WXErrCodeUserCancel)
    {
        [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"支付失败"];
    }
    
}



//支付宝支付结果处理
- (void)goZFB{

    
    [[AlipaySDK defaultService] payOrder:self.payDic[@"prepayId"] fromScheme:@"com.houhuayuan.app" callback:^(NSDictionary *resultDic) {
        if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
            //用户取消支付
            [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
        } else if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
            
            [SVProgressHUD showSuccessWithStatus:@"帖子置顶成功!"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } else {
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
        }
    }];
}


//支付宝支付结果处理,此处是app 被杀死之后用的
- (void)ZFBPAY:(NSNotification *)notic {
    NSDictionary *resultDic = notic.object;
    if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
        //用户取消支付
        [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
        
    } else if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
        
        [SVProgressHUD showSuccessWithStatus:@"帖子置顶成功!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } else {
        [SVProgressHUD showErrorWithStatus:@"支付失败"];
    }

}



@end
