//
//  QYZJYanShouOrBaoXiuTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJYanShouOrBaoXiuTVC.h"
#import "QYZJYanShouOrBaoXiuCell.h"
#import "QYZJMinePayDetailVC.h"
#import "QYZJMessageYanShouCell.h"
#import "QYZJMineBaoXiuListTVC.h"
@interface QYZJYanShouOrBaoXiuTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJMoneyModel *> *dataArray;
@end

@implementation QYZJYanShouOrBaoXiuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 2) {
        self.navigationItem.title = @"验收列表";
    }else {
        self.navigationItem.title = @"报修列表";
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJYanShouOrBaoXiuCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMessageYanShouCell" bundle:nil] forCellReuseIdentifier:@"QYZJMessageYanShouCell"];
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
    
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    NSString * str = [QYZJURLDefineTool user_turnoverStageNewListURL];
    if (self.type == 3) {
        str = [QYZJURLDefineTool user_turnoverRepairNewListURL];
    }
    [zkRequestTool networkingPOST:str parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<QYZJMoneyModel *>*arr = [QYZJMoneyModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
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
    if (self.type == 3) {
        return 78;
    }
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 3) {
        QYZJMessageYanShouCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMessageYanShouCell" forIndexPath:indexPath];
        cell.titleLB.text = self.dataArray[indexPath.row].stage_name;
        cell.contentLB.text = self.dataArray[indexPath.row].con;
        return cell;
    }
    QYZJYanShouOrBaoXiuCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.type == 2) {
        QYZJMinePayDetailVC * vc =[[QYZJMinePayDetailVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
           vc.hidesBottomBarWhenPushed = YES;
        vc.ID = self.dataArray[indexPath.row].ID;
           [self.navigationController pushViewController:vc animated:YES];
    }else {
          QYZJMineBaoXiuListTVC * vc =[[QYZJMineBaoXiuListTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
           vc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:vc animated:YES];
    }
    
   
    
}



@end
