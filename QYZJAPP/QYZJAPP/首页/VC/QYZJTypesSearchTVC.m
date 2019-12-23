//
//  QYZJTypesSearchTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJTypesSearchTVC.h"
#import "FindHeadView.h"
#import "QYZJSearchView.h"
#import "QYZJSearchLabelView.h"
#import "QYZJHomeFourCell.h"
#import "QYZJHomeFiveCell.h"
#import "QYZJSearchListTVC.h"
@interface QYZJTypesSearchTVC ()
@property(nonatomic,strong)FindHeadView *navigaV;
@property(nonatomic,strong)NSMutableDictionary *dataDict;
@property(nonatomic,strong)NSMutableArray *titleArr;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)QYZJSearchView *serachV;
@property(nonatomic,strong)QYZJSearchLabelView *LabelV;
@property(nonatomic,assign)NSInteger typeIndex;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)BOOL isTongChong;
//裁判时用
@property(nonatomic,assign)NSInteger sort_type;
@property(nonatomic,assign)NSInteger searchIndex,lableIndex;


@end

@implementation QYZJTypesSearchTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sort_type = 2;
    self.isTongChong = NO;
    self.navigationItem.title = self.titleStr;
    self.titleArr = @[].mutableCopy;
    self.dataDict = @{}.mutableCopy;
    [self setheadV];
    if (self.type == 1) {
        [self getLeiXingData];
    }else {
        self.serachV.dataArray = @[@"同城",@"评分从高到低",@"筛选"].mutableCopy;
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeFourCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeFourCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeFiveCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeFiveCell"];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;


    self.dataArray = @[].mutableCopy;
    self.page = 1;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
     
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getData];
    }];
    
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"type"] = @(self.type);
    dict[@"sort_type"] = @"0";
    dict[@"search_type"] = @(self.type);
    dict[@"roleId"] = self.role_id;
    if (self.type == 2) {
        dict[@"search_end_type"] = @1;
        dict[@"sort_type"] = @(self.sort_type);
    }
    if (self.isTongChong) {
        dict[@"city_id"] = self.cityID;
    }
    if (self.dataDict != nil && self.dataDict.allKeys.count > 0 ) {
         NSArray * arr = self.dataDict[self.titleArr[self.searchIndex]];
        if ( arr.count > self.lableIndex ) {
            QYZJTongYongModel * mm =  self.dataDict[self.titleArr[self.searchIndex]][self.lableIndex];
                   dict[@"labelId"] = mm.ID;
        }
       
    }
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_searchURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<QYZJFindModel *>*arr = [QYZJFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            if (self.dataArray.count == 0) {
                [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
            }
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}

- (void)setheadV {

    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 120)];
    self.headV.clipsToBounds = YES;    
    self.navigaV = [[FindHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
    self.navigaV.clipsToBounds = YES;
    self.navigaV.isPresentVC = YES;
    self.navigaV.delegateSignal = [RACSubject subject];
    [self.navigaV.delegateSignal subscribeNext:^(id  _Nullable x) {

           NSDictionary * dict = x;
           if ([[NSString stringWithFormat:@"%@",dict[@"key"]] isEqualToString:@"search"]) {
               //点击搜索
               QYZJSearchListTVC * vc =[[QYZJSearchListTVC alloc] init];
               vc.hidesBottomBarWhenPushed = YES;
               vc.cityID = self.cityID;
               vc.type = self.type;
               [self.navigationController pushViewController:vc animated:YES];
           }
       }];

       [self.headV addSubview:self.navigaV];
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 60, ScreenW, 10)];
    backV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.headV addSubview:backV];

    self.serachV = [[QYZJSearchView alloc] initWithFrame:CGRectMake(0, 70, ScreenW, 49.4)];
    [self.headV addSubview:self.serachV];
    self.serachV.isCanChange = self.type -1;
    Weak(weakSelf);
    self.serachV.clickHeadBlock = ^(NSInteger index,BOOL isYou) {
        //点击了标题
        weakSelf.lableIndex = 0;
        if (self.type == 1) {
            weakSelf.LabelV.dataArray = weakSelf.dataDict[weakSelf.titleArr[index]];;
            weakSelf.headV.mj_h = CGRectGetMaxY(weakSelf.LabelV.frame);
            weakSelf.tableView.tableHeaderView = weakSelf.headV;
        }else if (weakSelf.type == 2) {
            if (index == 0) {
                weakSelf.isTongChong = isYou;
            }else if (index == 1) {
                if (isYou) {
                    weakSelf.sort_type = 1;
                }else {
                    weakSelf.sort_type = 2;
                }
            }
        }
        weakSelf.searchIndex = index;
        weakSelf.page = 1;
        [weakSelf getData];
        
        
    };
    
    
    UIView * backV1 =[[UIView alloc] initWithFrame:CGRectMake(0, 119.4, ScreenW, 0.6)];
    backV1.backgroundColor = lineBackColor;
    [self.headV addSubview:backV1];
    

    
    
    
    self.LabelV = [[QYZJSearchLabelView alloc] initWithFrame:CGRectMake(0, 120, ScreenW, 0)];
    [self.headV addSubview:self.LabelV];
    self.LabelV.clickLabelBlock = ^(NSInteger index) {
        NSLog(@"=====\n%ld",index);
        weakSelf.lableIndex = index;
        weakSelf.page = 1;
        [weakSelf getData];
    };
    self.tableView.tableHeaderView = self.headV;

}



- (void)getLeiXingData {

    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_findLabelByTypeListURL] parameters:@{@"role_id":self.role_id} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {

            NSMutableArray * arr = [QYZJTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            self.dataDict =  [self getDataDictWithArr:arr];
            [self setViewData];
          
            [self getData];

        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];

}

- (void)setViewData {
    NSArray * arr = [self.dataDict allKeys];
    self.serachV.dataArray = self.titleArr;
    if (arr.count>0) {
        self.LabelV.dataArray = self.dataDict[self.titleArr[0]];
        self.headV.mj_h = CGRectGetMaxY(self.LabelV.frame);
        self.tableView.tableHeaderView = self.headV;
    }else {

    }
}
- (NSMutableDictionary *)getDataDictWithArr:(NSMutableArray<QYZJTongYongModel *>*)dataArr {
    NSMutableDictionary * dict = @{}.mutableCopy;
    for (QYZJTongYongModel *   model in dataArr) {
        if ([self.titleArr containsObject:model.typeName]) {
            
            NSMutableArray * arr = dict[model.typeName];;
            [arr addObject:model];
            dict[model.typeName] = arr;
            
        }else {
            [self.titleArr addObject:model.typeName];
            NSMutableArray * arr = @[].mutableCopy;
            [arr addObject:model];
            dict[model.typeName] = arr;
        
        }
        
    }
    return dict;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count +1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        QYZJHomeFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFourCell" forIndexPath:indexPath];
        return cell;
    }else {
        QYZJHomeFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFiveCell" forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.row - 1];
        cell.headBt.tag = indexPath.row - 1;
        [cell.headBt addTarget:self action:@selector(gotoZhuYeAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"------%@",indexPath);
    
    if (indexPath.row == 0) {
        QYZJXiaoYanZiVC * vc =[[QYZJXiaoYanZiVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        QYZJMineZhuYeTVC * vc =[[QYZJMineZhuYeTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = self.dataArray[indexPath.row].ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    

}

#pragma mark ------- 取他人的主页 ------
- (void)gotoZhuYeAction:(UIButton *)button {
    
    QYZJMineZhuYeTVC * vc =[[QYZJMineZhuYeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.ID = self.dataArray[button.tag].ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
