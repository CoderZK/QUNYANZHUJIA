//
//  QYZJBuyOrderDetailTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/2.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJBuyOrderDetailTVC.h"
#import "QYZJMineOrderInfoAddreeCell.h"
#import "QYZJMineOrderCell.h"
#import "QYZJAddAddressVC.h"
#import "QYZJMineAddressTVC.h"
@interface QYZJBuyOrderDetailTVC ()
@property(nonatomic,strong)UILabel *moneyLB;
@property(nonatomic,strong)UIButton *payBt;
@end

@implementation QYZJBuyOrderDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineOrderCell" bundle:nil] forCellReuseIdentifier:@"QYZJMineOrderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineOrderInfoAddreeCell" bundle:nil] forCellReuseIdentifier:@"QYZJMineOrderInfoAddreeCell"];
    [self setFootv];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    }else if (indexPath.section == 1) {
        return 105;
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
        [cell.addBt addTarget:self action:@selector(addAddressAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else   {
        QYZJMineOrderCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineOrderCell" forIndexPath:indexPath];
        cell.model = self.dataModel;
        cell.clipsToBounds = YES;
        return cell;
    }
    
    
}

//添加地址
- (void)addAddressAction:(UIButton *)button {
    
    QYZJMineAddressTVC * vc =[[QYZJMineAddressTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)setFootv {
    
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    
    UIView * footV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - sstatusHeight - 44 - 60, ScreenW, 60)];
    if (sstatusHeight > 20) {
        footV.frame = CGRectMake(0, ScreenH - sstatusHeight - 44 - 60 - 34, ScreenW, 60);
    }
    footV.backgroundColor = WhiteColor;
    footV.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影偏移量
    footV.layer.shadowOffset = CGSizeMake(0,-3);
    // 设置阴影透明度
    footV.layer.shadowOpacity = 0.1;
    // 设置阴影半径
    footV.layer.shadowRadius = 5;
    footV.clipsToBounds = NO;
    
    self.moneyLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW*2/3, 60)];
    self.moneyLB.font = kFont(14);
    self.moneyLB.textAlignment = NSTextAlignmentCenter;
    [footV addSubview:self.moneyLB];
    
    self.payBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW*2/3.0, 0, ScreenW/3.0,60)];
    [self.payBt setTitle:@"去支付" forState:UIControlStateNormal];
    [self.payBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
    [self.payBt addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [footV addSubview:self.payBt];
    [self.view addSubview:footV];
    
    
    
    
}

//点击支付
- (void)payAction:(UIButton *)button {
    
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
