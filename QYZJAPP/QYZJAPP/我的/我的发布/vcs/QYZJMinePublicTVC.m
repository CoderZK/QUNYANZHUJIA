//
//  QYZJMinePublicTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMinePublicTVC.h"
#import "QYZJFindCell.h"
#import "QYZJFindGuangChangDetailTVC.h"
@interface QYZJMinePublicTVC ()<QYZJFindCellDelegate>
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)NSInteger page;
@end

@implementation QYZJMinePublicTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的发布";
    
    self.page = 1;
    self.dataArray = [NSMutableArray array];
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getData];
    }];
    
    
    [self.tableView registerClass:[QYZJFindCell class] forCellReuseIdentifier:@"QYZJFindCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 1;
    
}

- (void)getData{
    
    [SVProgressHUD show];
    NSString * urlStr = [QYZJURLDefineTool app_articleListURL];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"isMy"] = @"1";
    [zkRequestTool networkingPOST:urlStr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJFindCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJFindCell" forIndexPath:indexPath];
    cell.type = 2;
    cell.model = self.dataArray[indexPath.row];
    cell.delegate = self;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QYZJFindGuangChangDetailTVC * vc =[[QYZJFindGuangChangDetailTVC alloc] init];
    vc.ID = self.dataArray[indexPath.row].ID;
    vc.hidesBottomBarWhenPushed = YES;
    Weak(weakSelf);
    vc.sendGuanChangModelBlock = ^(QYZJFindModel * _Nonnull model) {
        weakSelf.dataArray[indexPath.row].isGood = model.isGood;
        weakSelf.dataArray[indexPath.row].isCollect = model.isCollect;
        weakSelf.dataArray[indexPath.row].ok_num = model.ok_num;
        weakSelf.dataArray[indexPath.row].goodNum = model.goodNum;
        weakSelf.dataArray[indexPath.row].collectNum = model.collectNum;
        weakSelf.dataArray[indexPath.row].commentNum = model.commentNum;
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)didClickFindCell:(QYZJFindCell *)cell index:(NSInteger)index {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (index == 5) {
        
        [self deletaPostWithIndexPath:indexPath];
        
    }
    
}



- (void)deletaPostWithIndexPath:(NSIndexPath *)indexPath {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.dataArray[indexPath.row].ID;
    zkRequestTongYongTool * tool = [[zkRequestTongYongTool alloc] init];
    tool.subject = [[RACSubject alloc] init];
    [tool requestWithUrl:[QYZJURLDefineTool app_articleDelURL] andDict:dict];
    @weakify(self);
    [tool.subject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x !=nil && [x[@"key"] intValue] == 1) {
            [self.dataArray removeObjectAtIndex:indexPath.row];
            [SVProgressHUD showSuccessWithStatus:@"删除动态成功"];
            [self.tableView reloadData];
        }else {
            [SVProgressHUD dismiss];
        }
    }];
}


@end
