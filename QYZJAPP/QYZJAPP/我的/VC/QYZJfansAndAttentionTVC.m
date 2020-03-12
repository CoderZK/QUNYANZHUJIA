//
//  QYZJfansAndAttentionTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJfansAndAttentionTVC.h"
#import "QYZJHomeFiveCell.h"
@interface QYZJfansAndAttentionTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@end

@implementation QYZJfansAndAttentionTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 1) {
        self.navigationItem.title = @"我的关注";
    }else {
        self.navigationItem.title = @"我的粉丝";
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeFiveCell" bundle:nil] forCellReuseIdentifier:@"cell"];
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
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
}

- (void)getData {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"type"] = @(self.type - 1);
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_followListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJHomeFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (![self.dataArray[indexPath.row].role isEqualToString:@"1"]) {
        [SVProgressHUD showErrorWithStatus:@"对方不是服务方,不可以看对方主页"];
        return;
    }
    QYZJMineZhuYeTVC * vc =[[QYZJMineZhuYeTVC alloc] init];
    
    vc.hidesBottomBarWhenPushed = YES;
    vc.ID = self.dataArray[indexPath.row].ID;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
