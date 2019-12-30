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
#import "QYZJMineYuHuiQuanTVC.h"
#import "QYZJChangePayPasswordTwoVC.h"
@interface QYZJZhiFuVC ()
@property (weak, nonatomic) IBOutlet UIButton *payBt;
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UIImageView *imgVT2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;
@property (weak, nonatomic) IBOutlet UIButton *bt1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTwo;
@property (weak, nonatomic) IBOutlet UIImageView *payImgVone;
@property (weak, nonatomic) IBOutlet UILabel *titleOneLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consThree;
@property (nonatomic,strong)NSDictionary *payDic;
@property(nonatomic,assign)NSInteger payType;
@property (weak, nonatomic) IBOutlet UIView *youHuiV;
@property(nonatomic,strong)NSString *youHuiID;

@property(nonatomic,assign)BOOL isSetPayPassWord;

@end

@implementation QYZJZhiFuVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WWWWX:) name:@"WXPAY" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZFBPAY:) name:@"ZFBPAY" object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付";
    self.payType = 0;
    
    if (self.model.is_need_wechat_pay) {
        self.consThree.constant = 0;
        self.consTwo.constant = 131.2;
        self.payImgVone.hidden = self.bt1.hidden = self.imgV1.hidden = self.titleOneLB.hidden = YES;
        
        self.imgV1.image = [UIImage imageNamed:@"xuanze_1"];
        self.imgVT2.image = [UIImage imageNamed:@"xuanze_2"];
        self.imgV3.image = [UIImage imageNamed:@"xuanze_1"];
        self.payType = 1;
        
        
    }
    
    self.youHuiV.hidden = YES;
    
    if (self.type == 5|| self.type == 6) {
        [self chackYouHuiJuanAction];
    }
    
    [self checkPayPasswordWith:@"0" withisCheack:YES];
    
}

//检测是否有优惠券
- (void)chackYouHuiJuanAction {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_payCouponListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            NSArray * arr = responseObject[@"result"];
            if (arr.count == 0) {
                self.youHuiV.hidden = YES;
            }else {
                
                
                NSDictionary * dictData = [arr firstObject];
                NSInteger numberQ = [[NSString stringWithFormat:@"%@",dictData[@"free_question_num"]] integerValue];
                NSInteger numberA = [[NSString stringWithFormat:@"%@",dictData[@"free_appoint_num"]] integerValue];
                if (self.type == 5) {
                    //预约
                    if (numberA < self.numer) {
                        self.youHuiV.hidden = YES;
                    }else {
                        self.youHuiV.hidden = NO;
                    }
                }else {
                    //提问
                    if (numberQ < self.numer) {
                        self.youHuiV.hidden = YES;
                    }else {
                        self.youHuiV.hidden = NO;
                    }
                    
                }
            }
            
            
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
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
        
    }else if (sender.tag == 104){
        self.imgV1.image = [UIImage imageNamed:@"xuanze_1"];
        self.imgVT2.image = [UIImage imageNamed:@"xuanze_1"];
        self.imgV3.image = [UIImage imageNamed:@"xuanze_1"];
        
        QYZJMineYuHuiQuanTVC * vc =[[QYZJMineYuHuiQuanTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        Weak(weakSelf);
        vc.youHuiQuanBlock = ^(NSString * _Nonnull ID) {
            weakSelf.img4.image = [UIImage imageNamed:@"xuanze_2"];
            weakSelf.youHuiID = ID;
        };
        vc.isChoose = self.type - 4;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (sender.tag == 103){
        
        if (self.payType == 0) {
            
            if (self.isSetPayPassWord) {
                [LLPassWordAlertView showWithTitle:@"支付密码" desStr:[NSString stringWithFormat:@"支付金额:%0.2f元",self.model.money] finish:^(NSString *pwStr) {
                    [self checkPayPasswordWith:pwStr withisCheack:NO];
                    
                }];
            }else {
                
                UIAlertController  * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",@"您还没有设置支付密码, 请去设置"] preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                
                    QYZJChangePayPasswordTwoVC * vc =[[QYZJChangePayPasswordTwoVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                }];
                
                [alertVC addAction:action1];
                [alertVC addAction:action2];
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
                
                
            }
            
            
        }else {
            [self payAction];
        }
        
        
    }
}

//检测密码
- (void)checkPayPasswordWith:(NSString *)password withisCheack:(BOOL)isCheack{
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pay_pass"] = [password base64EncodedString];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_checkPayPassURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            NSInteger a  = [[NSString stringWithFormat:@"%@",responseObject[@"result"]] intValue];
            
            if (isCheack) {
                  if (a==0) {
                      self.isSetPayPassWord = NO;
                  }else {
                      self.isSetPayPassWord = YES;
                  }
                
            }else {
                
                if (a == 1) {
                    
                    [self payAction];
                    
                }else if (a == 2) {
                    [SVProgressHUD showErrorWithStatus:@"支付密码错误"];
                    
                }
              
                
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
    dict[@"ip"] = @"222.188.249.142";
    dict[@"osn"] = self.model.osn;
    NSString * url = [QYZJURLDefineTool user_createBalanceOrderURL];
    
    if (self.payType == 1) {
        url = [QYZJURLDefineTool user_createWxOrderURL];
        
    }else if (self.payType == 2){
        url = [QYZJURLDefineTool user_createAlipayOrderURL];
    }
    
    
    
    if (self.model.is_need_wechat_pay) {
        if (self.type != 11) {
            url = [QYZJURLDefineTool user_createPayNewURL];
        }
        if (self.payType == 1) {
            dict[@"is_wechat_pay"] = @"1";
        }else {
            dict[@"is_wechat_pay"] = @"0";
        }
        dict[@"pay_money"] = @(self.model.wechat_money);
    }
    
    if (self.youHuiID.length > 0) {
        url = [QYZJURLDefineTool user_createCouponOrderURL];
        dict[@"coupon_id"] = self.youHuiID;
        dict[@"num"] = @(self.numer);
    }
    
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            
            if (self.payType == 1) {
                self.payDic = responseObject[@"result"];
                [self goWXpay];
            }else if (self.payType == 2){
                self.payDic = responseObject;
                [self goZFB];
            }else {
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
}


//微信支付结果处理
- (void)WXPAY:(NSNotification *)no {
    
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



#pragma mark -微信、支付宝支付
- (void)goWXpay {
    PayReq * req = [[PayReq alloc]init];
    req.partnerId = [NSString stringWithFormat:@"%@",self.payDic[@"partnerid"]];
    req.prepayId =  [NSString stringWithFormat:@"%@",self.payDic[@"prepayid"]];
    req.nonceStr =  [NSString stringWithFormat:@"%@",self.payDic[@"noncestr"]];
    //注意此处是int 类型
    req.timeStamp = [self.payDic[@"timestamp"] intValue];
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
    
    
    [[AlipaySDK defaultService] payOrder:self.payDic[@"result"] fromScheme:@"com.qyzj.app" callback:^(NSDictionary *resultDic) {
        if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
            //用户取消支付
            [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
        } else if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
            
            [SVProgressHUD showSuccessWithStatus:@"支付成功"];
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
        
        [SVProgressHUD showSuccessWithStatus:@"支付成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } else {
        [SVProgressHUD showErrorWithStatus:@"支付失败"];
    }
    
}



@end
