//
//  QYZJMineCaiPanTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineCaiPanTVC.h"
#import "QYZJMineCaiPanCell.h"
#import "QYZJMineCaiPanTwoCell.h"
@interface QYZJMineCaiPanTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@end

@implementation QYZJMineCaiPanTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的裁判";
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
    
    [self.tableView registerClass:[QYZJMineCaiPanCell class] forCellReuseIdentifier:@"QYZJMineCaiPanCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineCaiPanTwoCell" bundle:nil] forCellReuseIdentifier:@"QYZJMineCaiPanTwoCell"];
   
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_caipanListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray[section].apponitUsers.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return self.dataArray[indexPath.section].cellHeight;
    }
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        QYZJMineCaiPanCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineCaiPanCell" forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.section];
        cell.clipsToBounds = YES;
        return cell;
    }
    QYZJMineCaiPanTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineCaiPanTwoCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.section].apponitUsers[indexPath.row -1];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
