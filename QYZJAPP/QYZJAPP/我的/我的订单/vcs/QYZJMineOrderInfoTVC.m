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
@interface QYZJMineOrderInfoTVC ()
@property(nonatomic,strong)NSDictionary *dataDict;

@end

@implementation QYZJMineOrderInfoTVC

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
        }
        return cell;
    }else if (indexPath.section == 1) {
        QYZJMineOrderCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineOrderCell" forIndexPath:indexPath];
        cell.model = self.dataModel;
        NSInteger  sta = [[NSString stringWithFormat:@"%@",self.dataDict[@"status"]] intValue];
           // 0是未付款1已付款待发货 2卖家已发货买家待确认 3:待评价 4：交易关闭
         [cell.statusBt setTitleColor:CharacterBlack112 forState:UIControlStateNormal];
                   cell.statusBt.layer.borderColor = CharacterBlack112.CGColor;
                   cell.statusBt.layer.borderWidth = 1;
        if (sta == 0) {
            cell.titleRightLB.text = @"待付款";
            [cell.statusBt setTitle:@"去付款" forState:UIControlStateNormal];
        }else if (sta == 1) {
               cell.titleRightLB.text = @"待发货";
               [cell.statusBt setTitle:@"提醒发货" forState:UIControlStateNormal];
           }else if (sta == 2) {
               cell.titleRightLB.text = @"待收货货";
               [cell.statusBt setTitle:@"确认收货" forState:UIControlStateNormal];
           }else if (sta == 3) {
               cell.titleRightLB.text = @"待评价";
               [cell.statusBt setTitle:@"评价" forState:UIControlStateNormal];
           }else if (sta == 4) {
               cell.titleRightLB.text = @"交易关闭";
               [cell.statusBt setTitle:@"交易关闭" forState:UIControlStateNormal];
           }
        
        
        [cell.statusBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
   
        
        return cell;
    }
    QYZJMineOrderInfoNumberCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineOrderInfoNumberCell" forIndexPath:indexPath];
    cell.orderNumberLB.text = [NSString stringWithFormat:@"订单编号: %@",self.dataModel.osn];
    cell.timelb.text = [NSString stringWithFormat:@"支付交易时间 %@",self.dataDict[@"pay_time"]];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)clickAction:(UIButton *)button {
    
    
    QYZJPingJiaTVC * vc =[[QYZJPingJiaTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = self.dataModel;
    [self.navigationController pushViewController:vc animated:YES];
    
    NSInteger  sta = [[NSString stringWithFormat:@"%@",self.dataDict[@"status"]] intValue];
    
    // 0是未付款1已付款待发货 2卖家已发货买家待确认 3:待评价 4：交易关闭
    
    if (sta == 0) {
        
    }else if (sta == 1) {
        
    }else if (sta == 2) {
        
    }else if (sta ==3){
        
    }else if (sta == 4) {
        
    }
    
}


@end
