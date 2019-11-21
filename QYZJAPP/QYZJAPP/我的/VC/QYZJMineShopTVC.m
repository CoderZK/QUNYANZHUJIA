//
//  QYZJMineShopTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineShopTVC.h"
#import "QYZJMineShopHeadView.h"
#import "QYZJMineShopCell.h"
@interface QYZJMineShopTVC ()
@property(nonatomic,strong)QYZJMineShopHeadView *headV;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger type;//1已上架 0 待审核 3 已下架
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@end

@implementation QYZJMineShopTVC
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //    self.navigationController.navigationBar.hidden = YES;;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = self.page = 1;
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH + sstatusHeight);
    self.headV = [[QYZJMineShopHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    self.headV.mj_h = self.headV.headHeight;
    self.headV.dataModel = self.dataModel;
    self.tableView.tableHeaderView = self.headV;
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineShopCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataArray = @[].mutableCopy;;
    Weak(weakSelf);
    self.headV.clickShopHeadBlock = ^(NSInteger index) {
        
        if (index == 0) {
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else if (index == 1) {
            //分享
            
        }else if (index == 2) {
            //头像
            
        }else if (index == 3) {
            //编辑
            
        } else if (index == 4) {
            weakSelf.type = 1;
        }else if (index == 5) {
            weakSelf.type = 0;
        }else if (index == 6){
            weakSelf.type = 3;
        }
        weakSelf.page = 1;
        [weakSelf getData];
    };
    [self getData];
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
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_goodsListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count / 2 + self.dataArray.count % 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat hh = (ScreenW - 30) / 2 * 3 / 4;
    return hh + 40 + 20 + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMineShopCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row * 2 + 2 <= self.dataArray.count) {
        cell.dataArray = [self.dataArray subarrayWithRange:NSMakeRange(indexPath.row * 2 , 2)];
    }else {
        cell.dataArray = [self.dataArray subarrayWithRange:NSMakeRange(indexPath.row * 2 , 1)];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
