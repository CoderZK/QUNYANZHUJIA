//
//  QYZJRuZhuThreeVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJRuZhuThreeVC.h"

@interface QYZJRuZhuThreeVC ()<zkPickViewDelelgate>
@property (weak, nonatomic) IBOutlet UITextField *typeTF;
@property (weak, nonatomic) IBOutlet UITextField *questMoneyTF;
@property (weak, nonatomic) IBOutlet UITextField *yuYueMoneyTF;
@property (weak, nonatomic) IBOutlet UITextField *pangTingMoneyTF;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;
@property(nonatomic,assign)NSInteger type;
@end

@implementation QYZJRuZhuThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请入住";
    self.confirmBt.layer.cornerRadius = 5;
    self.confirmBt.clipsToBounds = YES;
    self.type = -1;
}


- (IBAction)clickAction:(UIButton *)sender {
    if (sender.tag == 100) {
          zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
              picker.delegate = self ;
              picker.arrayType = titleArray;
              picker.array = @[@"教练",@"裁判"].mutableCopy;
              picker.selectLb.text = @"";
              [picker show];
    }else if (sender.tag == 101) {
        [SVProgressHUD showSuccessWithStatus:@"用户向您提问时需要支付的费用"];
    }else if (sender.tag == 102) {
        [SVProgressHUD showSuccessWithStatus:@"用户向您预约时需要支付的费用"];
    }else if (sender.tag == 103) {
        [SVProgressHUD showSuccessWithStatus:@"用户向您旁听时需要支付的费用"];
    }else if (sender.tag == 104) {
        
        if(self.type == -1) {
            [SVProgressHUD showErrorWithStatus:@"请选择身份"];
            return;
        }
        if (self.questMoneyTF.text.length == 0 || [self.questMoneyTF.text floatValue] <=0) {
            [SVProgressHUD showInfoWithStatus:@"请输入大于0的提问价格"];
            return;
        }
        if (self.yuYueMoneyTF.text.length == 0 || [self.yuYueMoneyTF.text floatValue] <=0) {
            [SVProgressHUD showErrorWithStatus:@"请输入大于0的预约价格"];
           
            return;
        }
        if (self.pangTingMoneyTF.text.length == 0 || [self.yuYueMoneyTF.text floatValue] <=0) {
            [SVProgressHUD showErrorWithStatus:@"请输入大于0的旁听价格"];
           
            return;
        }
        
        [self ruZHu];
        
    }
    
    
    
}


- (void)ruZHu {
    
    [SVProgressHUD show];
    
    self.dataDict[@"type"] = @(self.type);
    self.dataDict[@"question_price"] = self.questMoneyTF.text;
    self.dataDict[@"appoint_price"] = self.yuYueMoneyTF.text;
    self.dataDict[@"sit_price"] = self.pangTingMoneyTF.text;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_addApplicationURL] parameters:self.dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"申请入住申请提交成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex {
    self.type = leftIndex;
    self.typeTF.text = [@[@"教练",@"裁判"] objectAtIndex:leftIndex];
}

@end
