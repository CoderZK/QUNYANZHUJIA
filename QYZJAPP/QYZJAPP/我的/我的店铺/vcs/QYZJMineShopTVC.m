//
//  QYZJMineShopTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineShopTVC.h"
#import "QYZJMineShopHeadView.h"
#import "QYZJMineShopCell.h"
#import "QYZJShopDetailTVC.h"
#import "QYZJAddGoodsOrEditGoodsTVC.h"
#import "QYZJEditShopNameVC.h"
@interface QYZJMineShopTVC ()<QYZJMineShopCellDelegate>
@property(nonatomic,strong)QYZJMineShopHeadView *headV;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger type;//1已上架 0 待审核 3 已下架
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,strong)UIButton *faBuBt;
@end

@implementation QYZJMineShopTVC
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //    self.navigationController.navigationBar.hidden = YES;;
    self.page = 1;
    [self getData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = self.page = 1;
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH + sstatusHeight);
    self.headV = [[QYZJMineShopHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    self.headV.mj_h = self.headV.headHeight;
    
    self.tableView.tableHeaderView = self.headV;
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineShopCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataArray = @[].mutableCopy;;
    Weak(weakSelf);
    self.headV.clickShopHeadBlock = ^(NSInteger index) {
        
        if (index == 0) {
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else if (index == 1) {
            //分享
            
        }else if (index == 2) {
            //头像
            
        }else if (index == 3) {
            //编辑
            
            QYZJEditShopNameVC * vc =[[QYZJEditShopNameVC alloc] init];
            vc.sendShopNameBlock = ^(NSString * _Nonnull name) {
                weakSelf.dataModel.name = name;
                weakSelf.headV.dataModel = weakSelf.dataModel;
            };
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        } else if (index == 4) {
            weakSelf.type = 1;
        }else if (index == 5) {
            weakSelf.type = 0;
        }else if (index == 6){
            weakSelf.type = 3;
        }
        weakSelf.page = 1;
        [weakSelf getData];
    };
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getData];
    }];
    
    [self getShopInfo];
    [self addFaTieView];
}


- (void)getShopInfo {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_shopInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.dataModel = [QYZJUserModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.headV.dataModel = self.dataModel;
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}

- (void)addFaTieView {
     self.faBuBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 100, ScreenH - 150, 60, 60)];
     [self.faBuBt setImage:[UIImage imageNamed:@"qy36"] forState:UIControlStateNormal];
    self.faBuBt.backgroundColor = [UIColor whiteColor];
    self.faBuBt.layer.shadowColor = [UIColor blackColor].CGColor;
    self.faBuBt.layer.shadowRadius = 5;
    self.faBuBt.layer.cornerRadius = 30;
    self.faBuBt.layer.shadowOpacity = 0.3;
    self.faBuBt.layer.shadowOffset = CGSizeMake(0, 0);
    [[self.faBuBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       //发不商品
        QYZJAddGoodsOrEditGoodsTVC * vc =[[QYZJAddGoodsOrEditGoodsTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.shopId = self.dataModel.ID;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
     [self.view addSubview:self.faBuBt];
}


- (void)getData {

    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"type"] = @(self.type);
    dict[@"other_user_id"] = self.user_id;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_goodsListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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
    return self.dataArray.count / 2 + self.dataArray.count % 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat hh = (ScreenW - 30) / 2 * 3 / 4;
    return hh + 40 + 20 + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMineShopCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.type == 0) {
        cell.isShenHe = YES;;
    }else {
        cell.isShenHe = NO;
    }
    if (indexPath.row * 2 + 2 <= self.dataArray.count) {
        cell.dataArray = [self.dataArray subarrayWithRange:NSMakeRange(indexPath.row * 2 , 2)];
    }else {
        cell.dataArray = [self.dataArray subarrayWithRange:NSMakeRange(indexPath.row * 2 , 1)];
    }
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark ----- 点击 ----
- (void)didClickQYZJMineShopCell:(QYZJMineShopCell*)cell index:(NSInteger)index isEdit:(BOOL)isEdit
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (isEdit) {
        
        QYZJAddGoodsOrEditGoodsTVC * vc =[[QYZJAddGoodsOrEditGoodsTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.goodsId = self.dataArray[indexPath.row * 2+index].ID;
        vc.type = 1;
        if (self.type == 3) {
            vc.type = 2;
        }
        vc.shopId = self.dataModel.ID;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        QYZJFindModel * model = self.dataArray[indexPath.row * 2+index];
        QYZJShopDetailTVC * vc =[[QYZJShopDetailTVC alloc] init];
        vc.ID = model.ID;
        vc.isMine = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
    
}


@end
