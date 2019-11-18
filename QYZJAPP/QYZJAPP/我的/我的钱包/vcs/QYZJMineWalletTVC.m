
//
//  QYZJMineWalletTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineWalletTVC.h"
#import "QYZJMineTongYongCell.h"
#import "QYZJMineTiXianVC.h"
#import "QYZJMineTiXianTVC.h"
@interface QYZJMineWalletTVC ()
@property(nonatomic,strong)UILabel *moneyLB;
@property(nonatomic,strong)NSArray *titelArr;
@property(nonatomic,strong)QYZJMoneyModel *dataModel;
@end

@implementation QYZJMineWalletTVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH+sstatusHeight);
    [self setHeadV];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineTongYongCell" bundle:nil] forCellReuseIdentifier:@"cell"];
  
    self.titelArr = @[@"提现",@"提现记录",@"消费记录",@"佣金返利明细",@"店铺收入",@"邀请赏金"];
    
    [self getData];
}




-(void)setHeadV {
    
    UIView * headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 280)];
    headV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 270)];
    imgV.image = [UIImage imageNamed:@"28"];
    [headV addSubview:imgV];
    
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(0, sstatusHeight + 40, ScreenW, 20)];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.text = @"支付余额";
    [headV addSubview:lb];
    lb.textColor = WhiteColor;
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, sstatusHeight + 2, 30, 40);
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headV addSubview:button];

    self.moneyLB = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lb.frame) + 5 , ScreenW, 20)];
    self.moneyLB.font = [UIFont systemFontOfSize:15 weight:0.2];
    self.moneyLB.textAlignment = NSTextAlignmentCenter;
    self.moneyLB.textColor = WhiteColor;
    [headV addSubview:self.moneyLB];
    
    self.tableView.tableHeaderView = headV;
    
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_myMoneyURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.dataModel = [QYZJMoneyModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.moneyLB.text =[NSString stringWithFormat:@"%0.2f",self.dataModel.money + self.dataModel.pay_money];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMineTongYongCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"qb_%ld",indexPath.row+1]];
    cell.leftLB.text = self.titelArr[indexPath.row];
    if (indexPath.row ==0) {
        cell.rightLB.text = [NSString stringWithFormat:@"%0.2f元",self.dataModel.money];
    }else if ( indexPath.row < 3) {
        cell.rightLB.text = @"";
    }else if (indexPath.row == 3) {
        cell.rightLB.text = [NSString stringWithFormat:@"%0.2f元",self.dataModel.yj_money];
    }else if (indexPath.row == 4) {
        cell.rightLB.text = [NSString stringWithFormat:@"%0.2f元",self.dataModel.sr_money];
    }else if (indexPath.row == 5) {
        cell.rightLB.text = [NSString stringWithFormat:@"%0.2f元",self.dataModel.yq_money];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        QYZJMineTiXianVC * vc =[[QYZJMineTiXianVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.dataModel = self.dataModel;
        [self.navigationController pushViewController:vc animated:YES];
    }else  {
        QYZJMineTiXianTVC * vc =[[QYZJMineTiXianTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = indexPath.row - 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}




@end
