//
//  QYZJFangDanTwoTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFangDanTwoTVC.h"

@interface QYZJFangDanTwoTVC ()<zkPickViewDelelgate>
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *quDaoArr;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *LeiXingArr;
@property(nonatomic,strong)NSArray *leftArr,*placeholdArr,*chooseArr;
@end

@implementation QYZJFangDanTwoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"放单";
    self.leftArr = @[@"小区名称",@"推荐渠道",@"需求类型",@"风格",@"户型",@"装修时间",@"建筑面积",@"预算",@"描述"];
    self.placeholdArr = @[@"请输入小区名称",@"请选择分类(可多选)",@"请选择需求类型",@"请选择风格",@"请选择户型",@"请选择装修时间",@"请输入建筑面积",@"请输入预算",@"请输入描述"];
    self.chooseArr = @[@(1),@(0),@0,@0,@0,@0,@1,@1,@1];
    self.quDaoArr = [NSMutableArray mutableCopy];
    self.LeiXingArr = [NSMutableArray mutableCopy];
    
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];

    [self getQuDaoArrList];
    [self getLeiXingArrList];
    
}

- (void)getQuDaoArrList {
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_labelListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.quDaoArr = [zkPickModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)getLeiXingArrList {
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_demandTypeListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.LeiXingArr = [zkPickModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.leftArr[indexPath.row];
    cell.TF.placeholder = self.placeholdArr[indexPath.row];
    cell.moreImgV.hidden = cell.TF.userInteractionEnabled = [self.chooseArr[indexPath.row] integerValue];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        
        //        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        //        picker.delegate = self ;
        //        picker.arrayType = AreaArray;
        //        picker.array = self.quDaoArr;
        //        picker.selectLb.text = @"";
        //        [picker show];
        
    }else if (indexPath.row == 2) {
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        picker.arrayType = NormalArray
        ;
        picker.array = self.LeiXingArr;
        picker.selectLb.text = @"";
        [picker show];
        
        
    }else if (indexPath.row == 3) {
        
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        picker.arrayType = titleArray;
        picker.array = @[@"简约",@"中式",@"欧式",@"美式",@"田园",@"地中海",@"其它"].mutableCopy;
        picker.selectLb.text = @"";
        [picker show];
        
    }else if (indexPath.row == 4) {
        
    }
    
    
    
}


#pragma mark ------- 点击筛选 ------
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex{
    
    NSLog(@"%d---%d----%d",leftIndex,centerIndex,rightIndex);
    
    
}

@end
