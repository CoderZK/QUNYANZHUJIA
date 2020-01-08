//
//  QYZJMineOrderInfoTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/2.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineOrderInfoTVC.h"
#import "QYZJMineOrderInfoAddreeCell.h"
#import "QYZJMineOrderInfoNumberCell.h"
#import "QYZJMineOrderCell.h"
#import "QYZJPingJiaTVC.h"
#import "QYZJZhiFuVC.h"
@interface QYZJMineOrderInfoTVC ()
@property(nonatomic,strong)NSDictionary *dataDict;

@end

@implementation QYZJMineOrderInfoTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineOrderCell" bundle:nil] forCellReuseIdentifier:@"QYZJMineOrderCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineOrderInfoAddreeCell" bundle:nil] forCellReuseIdentifier:@"QYZJMineOrderInfoAddreeCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineOrderInfoNumberCell" bundle:nil] forCellReuseIdentifier:@"QYZJMineOrderInfoNumberCell"];
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
;
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"osn"] = self.dataModel.osn;
    dict[@"id"] = self.dataModel.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_orderInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataDict = responseObject[@"result"];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataDict == nil) {
        return 0;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    }else if (indexPath.section == 1) {
        return 165;
    }
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 0.01;
    }
    return 10;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = RGB(245, 245, 245);
    }
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        QYZJMineOrderInfoAddreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineOrderInfoAddreeCell" forIndexPath:indexPath];
        if ([self.dataDict.allKeys containsObject:@"link_name"]) {
            cell.titleLB.text = self.dataDict[@"link_name"];
        }
        if ([self.dataDict.allKeys containsObject:@"address"]) {
            cell.addressLB.text = self.dataDict[@"address"];
        }
        if ([self.dataDict.allKeys containsObject:@"link_tel"]) {
            cell.phoneLB.text = self.dataDict[@"link_tel"];
            if ([NSString stringWithFormat:@"%@",self.dataDict[@"link_tel"]].length == 0 && [self.dataDict.allKeys containsObject:@"real_tel"]) {
                
                cell.phoneLB.text = self.dataDict[@"real_tel"];
                
            }
        }
        cell.addBt.hidden = YES;
        return cell;
    }else if (indexPath.section == 1) {
        QYZJMineOrderCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineOrderCell" forIndexPath:indexPath];
        self.dataModel.status = self.dataDict[@"status"];
        cell.model = self.dataModel;
        NSInteger  sta = [[NSString stringWithFormat:@"%@",self.dataDict[@"status"]] intValue];
           // 0是未付款1已付款待发货 2卖家已发货买家待确认 3:待评价 4：交易关闭
//         [cell.statusBt setTitleColor:OrangeColor forState:UIControlStateNormal];
//        cell.statusBt.layer.borderColor = OrangeColor.CGColor;
//        cell.statusBt.layer.borderWidth = 1;
        cell.statusBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        cell.titleRightLB.hidden = NO;
        
        if (sta == 0) {
            cell.titleRightLB.text = @"待付款";
//            [cell.statusBt setTitle:@"去付款" forState:UIControlStateNormal];
        }else if (sta == 1) {
               cell.titleRightLB.text = @"待发货";
//               [cell.statusBt setTitle:@"提醒发货" forState:UIControlStateNormal];
           }else if (sta == 2) {
               cell.titleRightLB.text = @"待收货货";
//               [cell.statusBt setTitle:@"确认收货" forState:UIControlStateNormal];
           }else if (sta == 3) {
               cell.titleRightLB.text = @"待评价";
//               [cell.statusBt setTitle:@"评价" forState:UIControlStateNormal];
           }else if (sta == 4) {
               cell.titleRightLB.text = @"交易关闭";
               [cell.statusBt setTitle:@"交易关闭" forState:UIControlStateNormal];
               [cell.statusBt setTitleColor:CharacterBlack112 forState:UIControlStateNormal];
               cell.statusBt.layer.borderColor = CharacterBlack112.CGColor;
               cell.statusBt.layer.borderWidth = 1;
           }
        
        
        [cell.statusBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
   
        
        return cell;
    }
    QYZJMineOrderInfoNumberCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineOrderInfoNumberCell" forIndexPath:indexPath];
    cell.orderNumberLB.text = [NSString stringWithFormat:@"订单编号: %@",self.dataModel.osn];
    cell.timelb.text = [NSString stringWithFormat:@"支付交易时间 %@",self.dataModel.time];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)clickAction:(UIButton *)button {
    
     NSInteger  sta = [[NSString stringWithFormat:@"%@",self.dataDict[@"status"]] intValue];
    // 0是未付款1已付款待发货 2卖家已发货买家待确认 3:待评价 4：交易关闭
    if (sta == 0) {
//        QYZJZhiFuVC* vc =[[QYZJZhiFuVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//
//        QYZJTongYongModel * mm = [[QYZJTongYongModel alloc] init];
//        mm.osn = self.dataModel.osn;
//        mm.money = [self.dataModel.goods_price floatValue];
//        vc.model = mm;
//        [self.navigationController pushViewController:vc animated:YES];
        
        [self wecharPayWithID:self.dataModel.ID money:[self.dataModel.goods_price floatValue]];
        
        
    }else if (sta == 1) {
        [self actionWithStatus:sta];
    }else if (sta == 2) {
        [self actionWithStatus:sta];
    }else if (sta ==3){
        QYZJPingJiaTVC * vc =[[QYZJPingJiaTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.model = self.dataModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)wecharPayWithID:(NSString *)ID money:(CGFloat )money{
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pay_money"]= @(money);
    dict[@"type"] = @(4);
    dict[@"id"] = ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_wechatPayURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            QYZJTongYongModel * mm = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
            QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.model = mm;
            vc.ID = self.dataModel.ID;
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



- (void)actionWithStatus:(NSInteger)status {
    NSString * url = @"";
    if (status == 1) {
           url = [QYZJURLDefineTool user_reminderURL];
           if (self.dataModel.isSale) {
               //卖家确认发货
              url = [QYZJURLDefineTool user_sendGoodsURL];
           }
       }else if (status == 2) {
           if (self.dataModel.isSale) {
               return;
           }
           //卖家确认收货
           url = [QYZJURLDefineTool user_submitGoodsURL];
           
       }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"osn"] = self.dataModel.osn;
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            if (status == 1) {
                
                if (self.dataModel.isSale) {
                    //卖家确认发货
                    [SVProgressHUD showSuccessWithStatus:@"发货成功"];
                     self.dataModel.status= @"2";
                }else {
                   [SVProgressHUD showSuccessWithStatus:@"提醒发货成功"];
                }
            }else if (status == 2) {
                //卖家确认收货
                [SVProgressHUD showSuccessWithStatus:@"收货成功"];
                self.dataModel.status= @"3";
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
