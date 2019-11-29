//
//  QYZJMineQuestTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/14.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineQuestTVC.h"
#import "QYZJMineQuestCell.h"
@interface QYZJMineQuestTVC ()
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,assign)NSInteger page;
@end

@implementation QYZJMineQuestTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    self.navigationItem.title = @"我的提问";
    [self.tableView registerClass:[QYZJMineQuestCell class] forCellReuseIdentifier:@"cell"];

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


- (void)getData{
    
    NSString * urlStr = [QYZJURLDefineTool user_questionListURL];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    [zkRequestTool networkingPOST:urlStr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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
    CGFloat aa = self.dataArray[indexPath.row].cellHeight;
    NSLog(@"\n%@=====%f",indexPath,aa);

    return self.dataArray[indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMineQuestCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ([zkSignleTool shareTool].role == 1) {
        cell.isServer = YES;
    }else {
        cell.isServer = NO;
    }
    cell.waiModel = self.dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
