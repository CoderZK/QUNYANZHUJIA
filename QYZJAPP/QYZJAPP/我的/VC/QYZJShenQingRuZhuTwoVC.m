//
//  QYZJShenQingRuZhuTwoVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJShenQingRuZhuTwoVC.h"
#import "QYZJRuZhuThreeVC.h"
@interface QYZJShenQingRuZhuTwoVC ()<zkPickViewDelelgate>
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *cNameTF;
@property (weak, nonatomic) IBOutlet UITextField *labelsTF;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *cityArray;
@property(nonatomic,strong)NSMutableArray<QYZJTongYongModel *> *leiXingArr;
@property(nonatomic,strong)QYZJMoreChooseView *moreChooseV;
@property(nonatomic,strong)NSString *labelsID,*labelsStr;
@property(nonatomic,strong)NSString *proStr,*proId,*cityStr,*cityId,*aearStr,*aearId;

@end

@implementation QYZJShenQingRuZhuTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cityArray = @[].mutableCopy;
    self.leiXingArr = @[].mutableCopy;
    
    [self getCityData];
    [self getLeiXingData];
    self.moreChooseV = [[QYZJMoreChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.navigationItem.title = @"申请入住";
    self.confirmBt.layer.cornerRadius = 5;
    self.confirmBt.clipsToBounds = YES;
    
    
}
- (IBAction)clickAction:(UIButton *)sender {
    if (sender.tag == 0) {
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
        
    }else if (sender.tag == 1) {
        [self.view endEditing:YES];
        [self showView];
        
    }else {
        //提交审核
        [self updateInfo];
        
    }
    
    
}

- (void)updateInfo {
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
        return;
    }
    if (self.numberTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入身份证号"];
        return;
    }
    if (self.addressTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择服务地址"];
        return;
    }
    if (self.labelsTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择擅长标签"];
    }
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"role_id"] = self.typeID;
    dict[@"user_name"] = self.nameTF.text;
    dict[@"id_card"] = self.numberTF.text;
    dict[@"company_name"] = self.cNameTF.text;
    dict[@"license_code"] = self.codeTF.text;
    dict[@"pro_id"] = self.proId;
    dict[@"city_id"] = self.cityId;
    dict[@"area_id"] = self.aearId;
    dict[@"label"] = self.proId;
    
    QYZJRuZhuThreeVC * vc =[[QYZJRuZhuThreeVC alloc] init];
    vc.dataDict = dict;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    //    [self CardCheck];
    
    
}

//验证身份证
- (void)CardCheck {
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"cardNo"] = self.numberTF.text;
    dict[@"name"] = self.nameTF.text;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_idCardCheckURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"key"] intValue]== 1) {
            
            NSMutableDictionary * dict = @{}.mutableCopy;
            dict[@"role_id"] = self.typeID;
            dict[@"user_name"] = self.nameTF.text;
            dict[@"id_card"] = self.numberTF.text;
            dict[@"company_name"] = self.cNameTF.text;
            dict[@"license_code"] = self.codeTF.text;
            dict[@"pro_id"] = self.proId;
            dict[@"city_id"] = self.cityId;
            dict[@"area_id"] = self.aearId;
            dict[@"label"] = self.proId;
            
            QYZJRuZhuThreeVC * vc =[[QYZJRuZhuThreeVC alloc] init];
            vc.dataDict = dict;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
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

- (void)getLeiXingData {
    
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_findLabelByTypeListURL] parameters:@{@"role_id":self.typeID} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            
            self.leiXingArr = [QYZJTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)showView  {
    
    self.moreChooseV.dataArray = self.leiXingArr;
    Weak(weakSelf);
    self.moreChooseV.chooseViewMoreBlockFinsh = ^{
        NSMutableArray * idsArr = @[].mutableCopy;
        NSMutableArray * titlesArr = @[].mutableCopy;
        for (QYZJTongYongModel * mm  in weakSelf.leiXingArr) {
            if (mm.isSelect) {
                [idsArr addObject:mm.ID];
                [titlesArr addObject:mm.name];
            }
        }
        weakSelf.labelsID = [idsArr componentsJoinedByString:@","];
        weakSelf.labelsStr = [titlesArr componentsJoinedByString:@","];
        weakSelf.labelsTF.text = weakSelf.labelsStr;
    };
    [self.moreChooseV show];
    
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
            self.aearStr = self.cityArray[leftIndex].cityList[centerIndex-1].areaList[rightIndex].name;
            self.aearId = self.cityArray[leftIndex].cityList[centerIndex-1].areaList[rightIndex].ID;
        }
        
    }
    self.addressTF.text = [NSString stringWithFormat:@"%@%@%@",self.proStr,self.cityStr,self.aearStr];
    
}


@end
