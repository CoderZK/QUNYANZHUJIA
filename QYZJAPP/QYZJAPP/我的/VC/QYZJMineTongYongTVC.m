//
//  QYZJMineTongYongTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineTongYongTVC.h"
#import "QYZJMineBaoXiuCellTableViewCell.h"
#import "QYZJMineOrderCell.h"
@interface QYZJMineTongYongTVC ()
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,assign)NSInteger page;
@end

@implementation QYZJMineTongYongTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.type == 1) {
        self.navigationItem.title = @"我的报修";
    }else {
        self.navigationItem.title = @"我的案例";
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineBaoXiuCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"QYZJMineBaoXiuCellTableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    
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
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_repairListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 1) {
        return 90;
    }
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 1) {
        QYZJMineBaoXiuCellTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineBaoXiuCellTableViewCell" forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }else if (self.type == 2) {
      
    }
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
