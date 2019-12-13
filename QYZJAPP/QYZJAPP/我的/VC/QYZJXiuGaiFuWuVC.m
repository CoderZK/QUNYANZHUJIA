//
//  QYZJXiuGaiFuWuVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJXiuGaiFuWuVC.h"

@interface QYZJXiuGaiFuWuVC ()<zkPickViewDelelgate>
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *questMoneyTF;
@property (weak, nonatomic) IBOutlet UITextField *yuYueMoneyTF;
@property (weak, nonatomic) IBOutlet UITextField *pangTingMoneyTF;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;
@property (weak, nonatomic) IBOutlet UIButton *cancelBt;
@property (weak, nonatomic) IBOutlet UISwitch *quSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *yuyueSwitch;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *cityArray;

@end

@implementation QYZJXiuGaiFuWuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cityArray = @[].mutableCopy;
    self.navigationItem.title = @"服务方修改";
    [self getCityData];
    [self getData];
    self.addressTF.text =  [NSString stringWithFormat:@"%@%@%@",self.proStr,self.cityStr,self.aearStr];
}

- (IBAction)clickAction:(UIButton *)sender {
    if (sender.tag == 100) {
        if (self.cityArray.count == 0) {
            return;
        }
        [self.view endEditing:YES];
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        picker.arrayType = AreaArrayTwo;
        picker.array = self.cityArray;
        picker.selectLb.text = @"请选择地址";
        [picker show];
    }else if (sender.tag == 101) {
        [SVProgressHUD showSuccessWithStatus:@"用户向您提问时需要支付的费用"];
    }else if (sender.tag == 102) {
        [SVProgressHUD showSuccessWithStatus:@"用户向您预约时需要支付的费用"];
    }else if (sender.tag == 103) {
        [SVProgressHUD showSuccessWithStatus:@"用户向您旁听时需要支付的费用"];
    }else if (sender.tag == 104) {
        [self amendAction];
    }else if (sender.tag == 105) {
        [SVProgressHUD show];
        NSMutableDictionary * dict = @{}.mutableCopy;
        [zkRequestTool networkingPOST:[QYZJURLDefineTool user_cancelApplicationURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

            [SVProgressHUD dismiss];
            if ([responseObject[@"key"] intValue]== 1) {
                
                [SVProgressHUD showSuccessWithStatus:@"取消服务方身份成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            

            
        }];
        
    }
    
    
    
}


- (void)amendAction {
    
    [SVProgressHUD show];
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    dict[@"question_price"] = self.questMoneyTF.text;
    dict[@"apponit_price"] = self.yuYueMoneyTF.text;
    dict[@"sit_price"] = self.pangTingMoneyTF.text;
    dict[@"pro_id"] = self.proId;
    dict[@"city_id"] = self.cityId;
    dict[@"area_id"] = self.aearId;
    dict[@"is_question"] = @(self.quSwitch.on);
    dict[@"is_appoint"] = @(self.yuyueSwitch.on);
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_editAppointAndQuestionURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"信息修改成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_getUserInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.questMoneyTF.text = [NSString stringWithFormat:@"%0.2f",[[NSString stringWithFormat:@"%@",responseObject[@"result"][@"question_price"]] floatValue]];
            self.yuYueMoneyTF.text = [NSString stringWithFormat:@"%0.2f",[[NSString stringWithFormat:@"%@",responseObject[@"result"][@"appoint_price"]] floatValue]];
            self.pangTingMoneyTF.text = [NSString stringWithFormat:@"%0.2f",[[NSString stringWithFormat:@"%@",responseObject[@"result"][@"sit_price"]] floatValue]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

        
    }];
}


- (void)getCityData {
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_addressURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.cityArray = [zkPickModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex {
    
    self.proStr = self.cityArray[leftIndex].pname;
    self.proId= self.cityArray[leftIndex].pid;
    if (centerIndex == 0) {
        self.cityStr = @"";
        self.cityId = @"0";
        self.aearStr =  @"";;
        self.aearId = @"0";
    }else {
        self.cityStr = self.cityArray[leftIndex].cityList[centerIndex-1].cname;
        self.cityId = self.cityArray[leftIndex].cityList[centerIndex-1].cid;
        if (rightIndex == 0) {
            self.aearStr =  @"";
            self.aearId = @"0";
        }else {
            self.aearStr = self.cityArray[leftIndex].cityList[centerIndex-1].areaList[rightIndex-1].name;
            self.aearId = self.cityArray[leftIndex].cityList[centerIndex-1].areaList[rightIndex-1].ID;
        }
        
    }
    self.addressTF.text = [NSString stringWithFormat:@"%@%@%@",self.proStr,self.cityStr,self.aearStr];
    
}

@end
