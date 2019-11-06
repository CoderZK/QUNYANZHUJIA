//
//  QYZJFangDanOneTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFangDanOneTVC.h"
#import "QYZJFangDanTwoTVC.h"
@interface QYZJFangDanOneTVC ()<zkPickViewDelelgate>
@property(nonatomic,strong)NSArray *leftTitleArray;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *cityArray;
@property(nonatomic,strong)NSString *str1,*str2,*str3;
@end

@implementation QYZJFangDanOneTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.cityArray = @[].mutableCopy;
    self.leftTitleArray = @[@"联系方式",@"地址",@"详细地址"];
    [self getCityData];
    [self addFootView];
  
    
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
    [[nextBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
      
        QYZJFangDanTwoTVC * vc =[[QYZJFangDanTwoTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    [footV addSubview:nextBt];
    self.tableView.tableFooterView = footV;

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
    if (indexPath.row == 1) {
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        picker.arrayType = AreaArray;
        picker.array = self.cityArray;
        picker.selectLb.text = @"请选择地址";
        [picker show];
    }
}

#pragma marke ------- 点击筛选 ------
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex{
    
    NSLog(@"%d---%d----%d",leftIndex,centerIndex,rightIndex);

    
}
@end
