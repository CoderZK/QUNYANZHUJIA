
//
//  QYZJQuestionListDetailTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJQuestionListDetailTVC.h"
#import "QYZJQusetionListDetailCell.h"
#import "QYZJQuestionListDetailView.h"
@interface QYZJQuestionListDetailTVC ()
@property(nonatomic,strong)QYZJQuestionListDetailView *headV;
@property(nonatomic,strong)QYZJFindModel *dataModel;
@end



@implementation QYZJQuestionListDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    
    [self setheadV];
    [self.tableView registerClass:[QYZJQusetionListDetailCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
}

- (void)setheadV {
    self.headV = [[QYZJQuestionListDetailView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
}


- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_questionInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.dataModel = [QYZJFindModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.headV.dataModel = self.dataModel;
            self.headV.mj_h = self.headV.headHeight;
            self.tableView.tableHeaderView = self.headV;
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
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
    return self.dataModel.answer_list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJQusetionListDetailCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataModel.answer_list[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
