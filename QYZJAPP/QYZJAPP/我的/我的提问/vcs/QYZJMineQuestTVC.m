//
//  QYZJMineQuestTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/14.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineQuestTVC.h"
#import "QYZJMineQuestCell.h"
#import "QYZJMineQuestTwoTVC.h"
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
    dict[@"pageSize"] = @(20);
    [zkRequestTool networkingPOST:urlStr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            
            NSArray<QYZJFindModel *>*arr = [QYZJFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            
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
    
    QYZJFindModel * model = self.dataArray[indexPath.row];
    if (model.is_answer == 2) {
        cell.isServer = YES;
    }else {
        cell.isServer = NO;
    }
    
    
    cell.waiModel = model;
    Weak(weakSelf);
    cell.cellClickBlock = ^(QYZJMineQuestCell *cell) {
        NSIndexPath * iPath = [self.tableView indexPathForCell:cell];
        
         QYZJFindModel * model = self.dataArray[iPath.row];
           
           //未付款
           
           QYZJMineQuestTwoTVC * vc =[[QYZJMineQuestTwoTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
           vc.hidesBottomBarWhenPushed = YES;
           vc.model = model;
           if ([model.status isEqualToString:@"0"]) {
               vc.isPay = NO;
           }else {
               vc.isPay = YES;
           }
           
           [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (isUPUPUP) {
        return;
    }
    QYZJFindModel * model = self.dataArray[indexPath.row];
    //未付款
    QYZJMineQuestTwoTVC * vc =[[QYZJMineQuestTwoTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = model;
    if ([model.status isEqualToString:@"0"]) {
        vc.isPay = NO;
    }else {
        vc.isPay = YES;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}


@end
