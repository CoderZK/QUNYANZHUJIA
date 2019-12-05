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
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJMoneyModel *> *dataArray;
@end

@implementation QYZJBuyOrderDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineOrderCell" bundle:nil] forCellReuseIdentifier:@"QYZJMineOrderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineOrderInfoAddreeCell" bundle:nil] forCellReuseIdentifier:@"QYZJMineOrderInfoAddreeCell"];
    [self setFootv];
    
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
        if (self.dataArray.count>0) {
            [cell.addBt setTitle:@"" forState:UIControlStateNormal];
            [cell.addBt setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            cell.dizhiImgV.hidden = cell.titleLB.hidden = cell.dizhiImgV.hidden = cell.addressLB.hidden = cell.phoneLB.hidden = NO;
            QYZJMoneyModel * model = self.dataArray[0];
            cell.titleLB.text = model.address;
            cell.addressLB.text = model.addressPca;
            cell.phoneLB.text = model.linkTel;
        }else {
            [cell.addBt setImage:[UIImage imageNamed:@"18"] forState:UIControlStateNormal];
            [cell.addBt setTitle:@"新增地址" forState:UIControlStateNormal];
            cell.dizhiImgV.hidden = cell.titleLB.hidden = cell.dizhiImgV.hidden = cell.addressLB.hidden = cell.phoneLB.hidden = YES;
        }
        return cell;
    }else   {
        QYZJMineOrderCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineOrderCell" forIndexPath:indexPath];
        cell.model = self.dataModel;
        cell.clipsToBounds = YES;
        return cell;
    }
    
    
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(1);
    dict[@"pageSize"] = @(10);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_bankListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            self.dataArray = [QYZJMoneyModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}


//添加地址
- (void)addAddressAction:(UIButton *)button {
    
    QYZJMineAddressTVC * vc =[[QYZJMineAddressTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    Weak(weakSelf);
    vc.chooseAddressBlock = ^(QYZJMoneyModel * _Nonnull model) {
        [weakSelf.dataArray insertObject:model atIndex:0];
        [weakSelf.tableView reloadData];
    };
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
