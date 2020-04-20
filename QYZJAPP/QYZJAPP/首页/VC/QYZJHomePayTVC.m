//
//  QYZJHomePayTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJHomePayTVC.h"
#import "QYZJHomePayCell.h"
#import "QYZJMinePayDetailVC.h"
#import "QYZJAddWorkMomentTVC.h"
#import "QYZJChangeDetailedListTVC.h"
#import "QYZJJiaoFuListTVC.h"
#import "QYZJCreateShiGongQingDanTVC.h"
@interface QYZJHomePayTVC ()
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,assign)NSInteger page;
@end

@implementation QYZJHomePayTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的交付";
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
       button.frame = CGRectMake(0, 0, 65, 30);
       [button setTitle:@"发起交付" forState:UIControlStateNormal];
       button.titleLabel.font = [UIFont systemFontOfSize:14];
       [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       button.layer.cornerRadius = 0;
       button.clipsToBounds = YES;
       [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
           
//           QYZJCreateShiGongQingDanTVC * vc =[[QYZJCreateShiGongQingDanTVC alloc] init];
//           vc.hidesBottomBarWhenPushed = YES;
//           [self.navigationController pushViewController:vc animated:YES];
           
           QYZJJiaoFuListTVC * vc =[[QYZJJiaoFuListTVC alloc] init];
           vc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:vc animated:YES];
           
//           //更改施工阶段
//           QYZJChangeDetailedListTVC * vc =[[QYZJChangeDetailedListTVC alloc] init];
//           vc.hidesBottomBarWhenPushed = YES;
//           [self.navigationController pushViewController:vc animated:YES];
//
//           //创建新的施工阶段
//           QYZJAddWorkMomentTVC * vc =[[QYZJAddWorkMomentTVC alloc] init];
//           vc.hidesBottomBarWhenPushed = YES;
//           [self.navigationController pushViewController:vc animated:YES];
           
       }];
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomePayCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataArray = @[].mutableCopy;;
    self.page = 1;
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
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_turnoverListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJHomePayCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.moneyLB.hidden = YES;
    cell.model = self.dataArray[indexPath.row];
    cell.titleLB.text = self.dataArray[indexPath.row].b_recomend_name;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QYZJFindModel * model = self.dataArray[indexPath.row];
    if ((model.is_service && [model.user_status intValue] == 1) || (!model.is_service && [model.user_status intValue] == 3)) {
        QYZJCreateShiGongQingDanTVC * vc =[[QYZJCreateShiGongQingDanTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        QYZJMinePayDetailVC * vc =[[QYZJMinePayDetailVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
         vc.hidesBottomBarWhenPushed = YES;
         vc.ID  = model.ID;
         [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
