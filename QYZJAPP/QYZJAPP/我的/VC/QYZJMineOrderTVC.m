//
//  QYZJMineOrderTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineOrderTVC.h"
#import "QYZJMineOrderCell.h"
#import "QYZJMineOrderHeadView.h"
@interface QYZJMineOrderTVC ()
@property(nonatomic,assign)NSInteger type; // 0
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@end

@implementation QYZJMineOrderTVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationItem.title = @"我的订单";
    self.dataArray = @[].mutableCopy;
    self.type = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineOrderCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.frame = CGRectMake(0, 45, ScreenW, ScreenH  - 45);
    QYZJMineOrderHeadView * headV = [[QYZJMineOrderHeadView alloc] initWithFrame:CGRectMake(0,0, ScreenW, 45)];

    [self.view addSubview:headV];
    headV.delegateSignal = [[RACSubject alloc] init];
    [headV.delegateSignal subscribeNext:^(NSNumber*  x) {
        self.page = 1;
        self.type = [x integerValue];
        [self getDataWithType:self.type];
    }];
    self.page = 1;
    [self getDataWithType:self.type];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getDataWithType:self.type];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
         self.page++;
        [self getDataWithType:self.type];
    }];
    

}


- (void)getDataWithType:(NSInteger )type {
    [SVProgressHUD show];
    NSString * urlStr = [QYZJURLDefineTool user_orderListURL];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"type"] = @(self.type);
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    self.tableView.userInteractionEnabled = NO;
    [zkRequestTool networkingPOST:urlStr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        self.tableView.userInteractionEnabled = YES;
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
        self.tableView.userInteractionEnabled = YES;
    }];
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 165;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMineOrderCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
