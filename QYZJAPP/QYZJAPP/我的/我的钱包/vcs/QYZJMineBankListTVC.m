//
//  QYZJMineBankListTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/16.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineBankListTVC.h"
#import "QYZJBankListCell.h"
#import "QYZJAddBankTVC.h"
@interface QYZJMineBankListTVC ()
@property(nonatomic,strong)NSMutableArray<QYZJMoneyModel *> *dataArray;
@property(nonatomic,assign)NSInteger page;
@end

@implementation QYZJMineBankListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"银行卡";
    [self setFootV];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJBankListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
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




- (void)setFootV {

    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }

    UIView * footV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - sstatusHeight - 44 - 60, ScreenW, 60)];
    footV.backgroundColor = WhiteColor;
    footV.layer.shadowColor = [UIColor blackColor].CGColor;
      // 设置阴影偏移量
      footV.layer.shadowOffset = CGSizeMake(0,-3);
      // 设置阴影透明度
      footV.layer.shadowOpacity = 0.1;
      // 设置阴影半径
      footV.layer.shadowRadius = 5;
      footV.clipsToBounds = NO;
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 10, ScreenW - 40, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
    [button setTitle:@"添加银行卡" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:WhiteColor forState:UIControlStateNormal];
    button.layer.cornerRadius = 3;
    button.clipsToBounds = YES;
    [footV addSubview:button];
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:footV];
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_bankListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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


//点击发布案例
- (void)clickAction:(UIButton *)button {
    QYZJAddBankTVC * vc =[[QYZJAddBankTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES]; 
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJBankListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
