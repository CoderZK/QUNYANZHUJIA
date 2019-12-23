//
//  QYZJZengZhiFuWuTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJZengZhiFuWuTVC.h"
#import "QYZJZengZhiFWCell.h"
#import "QYZJZengZhiOneCell.h"
#import "QYZJZhiFuVC.h"
@interface QYZJZengZhiFuWuTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJMoneyModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray<QYZJMoneyModel *> *dataArrayTwo;
@property(nonatomic,strong)NSArray *headTitleArr;
@property(nonatomic,strong)UIView *footV;

@end

@implementation QYZJZengZhiFuWuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"增值服务";
    [self.tableView registerClass:[QYZJZengZhiFWCell class] forCellReuseIdentifier:@"QYZJZengZhiFWCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJZengZhiOneCell" bundle:nil] forCellReuseIdentifier:@"QYZJZengZhiOneCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    self.dataArrayTwo = @[].mutableCopy;
    
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    
    self.headTitleArr = @[@"",@"保证金套餐",@"充值套餐"];
    [self setfootv];
 
    
}

- (void)setfootv {
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 80)];
     self.tableView.tableFooterView = self.footV;
     
     UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(30, 20, ScreenW- 60, 45)];
     button.layer.cornerRadius = 3;
     button.titleLabel.font = kFont(15);
     [button setTitle:@"确认充值" forState:UIControlStateNormal];
     button.clipsToBounds = YES;
     [button setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
     @weakify(self);
     [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self);
         
         [self VipAction];
         
     }];
     [self.footV addSubview:button];
}

- (void)VipAction {
    
    NSMutableArray * arr = @[].mutableCopy;
    CGFloat money = 0;
    for (QYZJMoneyModel * model  in self.dataArray) {
        if (model.isSelect) {
            [arr addObject:model.ID];
            money = money + model.realMoney;
        }
    }
    for (QYZJMoneyModel * model  in self.dataArrayTwo) {
           if (model.isSelect) {
               [arr addObject:model.ID];
               money = money + model.realMoney;
           }
       }
    
    if (arr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"至少选择一个套餐!"];
        return;
    }
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"package_id"] = [arr componentsJoinedByString:@","];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_setVipURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            QYZJTongYongModel * model = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
            model.is_need_wechat_pay = YES;
            QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.model = model;
            vc.type = 11;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    
    }];
}


- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(30);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_vipPackageListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            self.dataArray= [QYZJMoneyModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"bondList"]];
            self.dataArrayTwo= [QYZJMoneyModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"vipList"]];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }else {
        return 50;
        
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    QYZJTongYongHeadFootView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (view == nil) {
        view = [[QYZJTongYongHeadFootView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 49.4, ScreenW, 0.6)];
        backV.backgroundColor = lineBackColor;
        [view addSubview:backV];
        

    }
    view.rightBt.hidden = view.lineV.hidden = YES;
    view.leftLB.text = self.headTitleArr[section];
    view.backgroundColor = WhiteColor;
    
    view.contentView.backgroundColor = WhiteColor;
    view.clipsToBounds = YES;
    return view;
}


- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = RGB(245, 245, 245);
    }
    return view;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CGFloat space = 15;
    CGFloat ww = (ScreenW - 4*space)/3;
    CGFloat hh = ww*4/3;
    
    
    if (indexPath.section == 1) {
        NSInteger  lines = self.dataArray.count /3 + (self.dataArray.count % 3 > 0?1:0);
        return lines * (hh + space) + space;
    }else if (indexPath.section == 2) {
        NSInteger  lines = self.dataArrayTwo.count /3 + (self.dataArrayTwo.count % 3 > 0?1:0);
        return lines * (hh + space) + space;
    }
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        QYZJZengZhiOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJZengZhiOneCell" forIndexPath:indexPath];
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:self.headImg]] placeholderImage:[UIImage imageNamed:@"789"] options:SDWebImageRetryFailed];
        cell.nameLB.text = self.nameStr;
        return cell;
    }else {
        
        QYZJZengZhiFWCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJZengZhiFWCell" forIndexPath:indexPath];
           if (indexPath.section == 1) {
               cell.dataArray = self.dataArray;
               cell.is_bond = self.is_bond;
           }else if(indexPath.section == 2) {
               cell.dataArray = self.dataArrayTwo;;
           }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




@end
