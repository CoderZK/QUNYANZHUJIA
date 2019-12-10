//
//  QYZJFangDanOneTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFangDanOneTVC.h"
#import "QYZJFangDanTwoTVC.h"
@interface QYZJFangDanOneTVC ()<zkPickViewDelelgate,UITextFieldDelegate>
@property(nonatomic,strong)NSArray *leftTitleArray;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *cityArray;
@property(nonatomic,strong)NSString *str1,*str2,*str3;
@property(nonatomic,strong)NSString *proStr,*proId,*cityStr,*cityId,*aearStr,*aearId;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@end

@implementation QYZJFangDanOneTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.cityArray = @[].mutableCopy;
    self.dataArray = @[].mutableCopy;
    self.leftTitleArray = @[@"联系方式",@"地址",@"详细地址"];
    [self getCityData];
    [self addFootView];
    self.navigationItem.title = @"放单";
  
    
}

- (void)addFootView {
    
    UIView * footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    footV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIButton * nextBt = [[UIButton alloc] initWithFrame:CGRectMake(20, 40, ScreenW - 40, 45)];
    nextBt.layer.cornerRadius = 4;
    nextBt.clipsToBounds = YES;
    nextBt.titleLabel.font = kFont(15);
    [nextBt setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
    [nextBt setTitleColor:WhiteColor forState:UIControlStateNormal];
    @weakify(self);
    [[nextBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.tableView endEditing:YES];
//        [self CheckDemandAction];
        
        if (self.dataArray.count == 0) {
            QYZJFindModel * model = [[QYZJFindModel alloc] init];
                       model.telphone = self.str1;
                       model.pro_id = self.proId;
                       model.city_id = self.cityId;
                       model.area_id = self.aearId;
                       model.b_recomend_address = self.str3;
            [self.dataArray addObject:model];
        }else {
            QYZJFindModel * model = [self.dataArray lastObject];
            model.telphone = self.str1;
            model.pro_id = self.proId;
            model.city_id = self.cityId;
            model.area_id = self.aearId;
            model.b_recomend_address = self.str3;
        }
        QYZJFangDanTwoTVC * vc =[[QYZJFangDanTwoTVC alloc] init];
                  vc.hidesBottomBarWhenPushed = YES;
        vc.dataArray = self.dataArray;
        Weak(weakSelf);
        vc.addDemndBlock = ^(NSMutableArray<QYZJFindModel *> *arr) {
            weakSelf.dataArray = arr;
        };
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    [footV addSubview:nextBt];
    self.tableView.tableFooterView = footV;

}

- (void)CheckDemandAction {
    
    if (self.str1.length ==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入联系方式"];
        return;
    }
    if (self.str2.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择地址"];
        return;
    }
    if (self.str3.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入详细地址"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"b_recomend_phone"] = self.str1;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_checkDemandURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            if (self.dataArray.count == 0) {
                QYZJFindModel * model = [[QYZJFindModel alloc] init];
                           model.telphone = self.str1;
                           model.pro_id = self.proId;
                           model.city_id = self.cityId;
                           model.area_id = self.aearId;
                           model.b_recomend_address = self.str3;
                [self.dataArray addObject:model];
            }else {
                QYZJFindModel * model = [self.dataArray lastObject];
                model.telphone = self.str1;
                model.pro_id = self.proId;
                model.city_id = self.cityId;
                model.area_id = self.aearId;
                model.b_recomend_address = self.str3;
            }
            QYZJFangDanTwoTVC * vc =[[QYZJFangDanTwoTVC alloc] init];
                      vc.hidesBottomBarWhenPushed = YES;
            vc.dataArray = self.dataArray;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.leftTitleArray[indexPath.row];
    cell.moreImgV.hidden = YES;
    cell.TF.userInteractionEnabled = YES;
    cell.TF.delegate = self;
    if (indexPath.row == 0) {
        cell.TF.text = self.str1;
    }else if (indexPath.row == 1) {
        cell.TF.text = self.str2;
        cell.moreImgV.hidden = NO;
        cell.TF.userInteractionEnabled = NO;
    }else {
        cell.TF.text = self.str3;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView endEditing:YES];
    if (indexPath.row == 1) {
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        picker.arrayType = AreaArray;
        picker.array = self.cityArray;
        picker.selectLb.text = @"请选择地址";
        [picker show];
    }
}

#pragma mark ------- 点击筛选 ------
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex{
    
    NSLog(@"%ld---%ld----%ld",(long)leftIndex,centerIndex,rightIndex);

    
    self.proStr = self.cityArray[leftIndex].pname;
     self.proId= self.cityArray[leftIndex].pid;
    
         self.cityStr = self.cityArray[leftIndex].cityList[centerIndex].cname;
         self.cityId = self.cityArray[leftIndex].cityList[centerIndex].cid;
         if (rightIndex == 0) {
             self.aearStr =  @"";
             self.aearId = @"0";
         }else {
             self.aearStr = self.cityArray[leftIndex].cityList[centerIndex].areaList[rightIndex-1].name;
             self.aearId = self.cityArray[leftIndex].cityList[centerIndex].areaList[rightIndex-1].ID;
         }
         
     
    self.str2 = [NSString stringWithFormat:@"%@%@%@",self.proStr,self.cityStr,self.aearStr];
    [self.tableView reloadData];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    TongYongTwoCell * cell = (TongYongTwoCell *)textField.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 0) {
        self.str1 = textField.text;
    }else if (indexPath.row ==2) {
        self.str3 =  textField.text;
    }
    
}


@end
