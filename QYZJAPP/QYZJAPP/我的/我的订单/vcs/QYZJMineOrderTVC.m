//
//  QYZJMineOrderTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineOrderTVC.h"
#import "QYZJMineOrderCell.h"
#import "QYZJMineOrderHeadView.h"
#import "QYZJMineOrderInfoTVC.h"
#import "QYZJZhiFuVC.h"
#import "QYZJPingJiaTVC.h"
@interface QYZJMineOrderTVC ()
@property(nonatomic,assign)NSInteger type; // 0
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@end

@implementation QYZJMineOrderTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的订单";
    self.dataArray = @[].mutableCopy;
    self.type = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineOrderCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.frame = CGRectMake(0, 45, ScreenW, ScreenH  - 45);
    QYZJMineOrderHeadView * headV = [[QYZJMineOrderHeadView alloc] initWithFrame:CGRectMake(0,0, ScreenW, 45)];
    
    [self.view addSubview:headV];
    headV.delegateSignal = [[RACSubject alloc] init];
    [headV.delegateSignal subscribeNext:^(NSNumber*  x) {
        self.page = 1;
        self.type = [x integerValue];
        [self getDataWithType:self.type];
    }];
    self.page = 1;
    [self getDataWithType:self.type];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getDataWithType:self.type];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getDataWithType:self.type];
    }];
    
    
}


- (void)getDataWithType:(NSInteger )type {
    [SVProgressHUD show];
    NSString * urlStr = [QYZJURLDefineTool user_orderListURL];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"type"] = @(self.type);
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    self.tableView.userInteractionEnabled = NO;
    [zkRequestTool networkingPOST:urlStr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        self.tableView.userInteractionEnabled = YES;
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
        self.tableView.userInteractionEnabled = YES;
    }];
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 165;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMineOrderCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    cell.statusBt.tag = indexPath.row;
    //    cell.statusBt.userInteractionEnabled = NO;
    cell.tag = indexPath.row;
    [cell.statusBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QYZJMineOrderInfoTVC * vc =[[QYZJMineOrderInfoTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.dataModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)clickAction:(UIButton *)button {
    
    QYZJFindModel * model = self.dataArray[button.tag];
    
    if ([model.status intValue]== 1 || [model.status intValue]== 2) {
        [self actionWithStatus:[model.status intValue]withModel:model withIndex:button.tag];
    }else if ([model.status intValue] == 0) {
  
        [self wecharPayWithID:model.ID money:[model.goods_pic floatValue]];
        
    }else if ([model.status intValue] ==3) {
        QYZJPingJiaTVC * vc =[[QYZJPingJiaTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
}

- (void)wecharPayWithID:(NSString *)ID money:(CGFloat )money{
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pay_money"]= @(money);
    dict[@"type"] = @(3);
    dict[@"id"] = ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_wechatPayURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            QYZJTongYongModel * mm = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
            QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.model = mm;
            vc.ID = ID;
            vc.type = 10;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}




- (void)actionWithStatus:(NSInteger)status withModel:(QYZJFindModel *)model withIndex:(NSInteger )index{
    NSString * url = @"";
    if (status == 1) {
        url = [QYZJURLDefineTool user_reminderURL];
        if (model.isSale) {
            //卖家确认发货
            url = [QYZJURLDefineTool user_sendGoodsURL];
        }
    }else if (status == 2) {
        if (model.isSale) {
            return;
        }
        //卖家确认收货
        url = [QYZJURLDefineTool user_submitGoodsURL];
        
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"osn"] = model.osn;
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            if (status == 1) {
                
                if (model.isSale) {
                    //卖家确认发货
                    [SVProgressHUD showSuccessWithStatus:@"发货成功"];
                    self.dataArray[index].status= @"2";
              
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"提醒发货成功"];
                }
            }else if (status == 2) {
                //买家确认收货
                [SVProgressHUD showSuccessWithStatus:@"收货成功"];
                self.dataArray[index].status = @"3";
                
            }
       
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}




@end
