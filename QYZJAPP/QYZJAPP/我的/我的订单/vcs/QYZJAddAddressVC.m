//
//  QYZJAddAddressVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/2.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJAddAddressVC.h"

@interface QYZJAddAddressVC ()<zkPickViewDelelgate>
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressCityTF;
@property (weak, nonatomic) IBOutlet UITextField *addreddTF;
@property (weak, nonatomic) IBOutlet UIButton *comfirmBt;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *cityArray;
@property(nonatomic,strong)NSString *proStr,*proId,*cityStr,*cityId,*aearStr,*aearId;
@end

@implementation QYZJAddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.comfirmBt.layer.cornerRadius = 5;
    self.comfirmBt.clipsToBounds = YES;
    
    self.cityArray = @[].mutableCopy;
    
    self.navigationItem.title = @"新增地址";
    [self getCityData];
    
    
}
- (IBAction)action:(UIButton *)sender {
    
    if (sender.tag == 100) {
        //点击城市
        
        if (self.cityArray.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"获取地址失败,请返回在重新进入"];
            return;
        }
        
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        picker.arrayType = ArerArrayNormal;
        picker.array = self.cityArray;
        picker.selectLb.text = @"请选择地址";
        [picker show];
        
    }else {
        
        if (self.nameTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入联系人"];
            return;
        }
        if (self.phoneTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入联系电话"];
            return;
        }
        if (self.proStr.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请选择地址"];
            return;
        }
        if (self.addreddTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入详细地址"];
            return;
        }
        [self addAction];
            
 
    }
    
    
    
    
    
}


- (void)addAction {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"link_tel"] = self.phoneTF.text;
    dict[@"link_name"] = self.nameTF.text;
    dict[@"pro_id"] = self.proId;
    dict[@"city_id"] = self.cityId;
    dict[@"area_id"] = self.aearId;
    dict[@"address_pca"] = self.addressCityTF.text;
    dict[@"address"] = self.addreddTF.text;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_addAddressURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"添加地址成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
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

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex{
    
    NSLog(@"%d---%d----%d",leftIndex,centerIndex,rightIndex);
    
    
    self.proStr = self.cityArray[leftIndex].pname;
    self.proId= self.cityArray[leftIndex].pid;
    
    self.cityStr = self.cityArray[leftIndex].cityList[centerIndex].cname;
    self.cityId = self.cityArray[leftIndex].cityList[centerIndex].cid;
    
    
    self.aearStr = self.cityArray[leftIndex].cityList[centerIndex].areaList[rightIndex].name;
    self.aearId = self.cityArray[leftIndex].cityList[centerIndex].areaList[rightIndex].ID;
    
    self.addressCityTF.text = [NSString stringWithFormat:@"%@%@%@",self.proStr,self.cityStr,self.aearStr];
    
    
}



@end
