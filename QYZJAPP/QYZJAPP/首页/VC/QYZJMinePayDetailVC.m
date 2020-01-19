//
//  QYZJMinePayDetailVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMinePayDetailVC.h"
#import "QYZJHomePayCell.h"
#import "QYZJHomePayDetailOneCell.h"
#import "QYZJTongYongHeadFootView.h"
#import "QYZJPicShowCell.h"
#import "QYZJHomePayDetailTwoCell.h"
#import "QYZJConstructionCell.h"
#import "QYZJConstructionListCell.h"
#import "QYZJChangeConstructionOneCell.h"
#import "QYZJConstructionProgressCell.h"
#import "QYZJChangeDetailedListTVC.h"
#import "QYZJMineBaoXiuDetailTVC.h"
#import "QYZJQingDanPingJiaVC.h"
#import "QYZJCreateShiGongQingDanTVC.h"
#import "QYZJSetBaoXiuTVC.h"
@interface QYZJMinePayDetailVC ()<QYZJChangeConstructionOneCellDelegate,QYZJConstructionListCellDelegate>
@property(nonatomic,strong)NSArray *headTitleArr;
@property(nonatomic,strong)QYZJWorkModel *dataModel;
@property(nonatomic,strong)QYZJFindModel *titleModel;
@end

@implementation QYZJMinePayDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
    
//    [self.navigationItem setHidesBackButton:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//   [self.navigationItem setHidesBackButton:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomePayCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomePayCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomePayDetailOneCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomePayDetailOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomePayDetailTwoCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomePayDetailTwoCell"];
    [self.tableView registerClass:[QYZJPicShowCell class] forCellReuseIdentifier:@"QYZJPicShowCell"];
    [self.tableView registerClass:[QYZJConstructionCell class] forCellReuseIdentifier:@"QYZJConstructionCell"];
    [self.tableView registerClass:[QYZJConstructionListCell class] forCellReuseIdentifier:@"QYZJConstructionListCell"];
    [self.tableView registerClass:[QYZJChangeConstructionOneCell class] forCellReuseIdentifier:@"QYZJChangeConstructionOneCell"];
    [self.tableView registerClass:[QYZJConstructionProgressCell class] forCellReuseIdentifier:@"QYZJConstructionProgressCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //分为如下区,如果存在则展示,不存在则隐藏
    self.headTitleArr = @[@"",@"支付",@"合同",@"预算",@"图纸",@"变更相册",@"整体进度",@"施工",@"变更清单",@"实际施工阶段列表",@"变更施工阶段列表"];
    //    self.headTitleArr = @[@"",@"支付",@"合同",@"预算",@"图纸",@"变更相册",@"整体进度",@"施工",@"变更清单",@"实际施工阶段列表",@"变更施工阶段列表"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    
   UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
   [button setImage:[UIImage imageNamed:@"ico_back"] forState:(UIControlStateNormal)];
   [button setImage:[UIImage imageNamed:@"ico_back"] forState:(UIControlStateHighlighted)];

   CGRect frame = CGRectMake(0, 0, 25, 25);
   button.frame = frame;
   button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
   button.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
   
   [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
   [button setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
   [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:button]];;
    
    
    self.navigationItem.title = @"详情";
    
}

- (void)back {
    
    if (self.navigationController.childViewControllers.count >= 4 && self.isRob) {
        [self.navigationController popToViewController:self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 4] animated:NO];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


//0   // 1 创建施工清单 2 //等待客户 确认 3 //待支付 5 //待支付尾款 7 设置保修时间
- (void)setFootVWithStatus:(NSInteger)status {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60 - sstatusHeight - 44);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34 - sstatusHeight - 44);
    }
    
    KKKKFootView * view2 = (KKKKFootView *)[self.view viewWithTag:666];
    if (view2 != nil) {
        [view2 removeFromSuperview];
    }
    
    if (!((!self.dataModel.demand.is_service && (status == 1||status == 7)) ||( self.dataModel.demand.is_service && (status == 2 || status == 3 || status == 6)))){
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 44);
        return;
    }
    
       NSString * str = @"";
         if (status ==1) {
            str = @"创建施工清单";
         }else if (status == 2) {
             str = @"确认交付";
         }else if (status == 3) {
             str = @"支付首款";
         }else if (status == 6) {
             str = @"支付尾款";
         }else if (status == 7) {
             str = @"设置保修时间";
         }
        KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:str andImgaeName:@""];
        view.tag = 666;
        Weak(weakSelf);
        view.footViewClickBlock = ^(UIButton *button) {
            [weakSelf bottomClickAction:status];
        };
        [self.view addSubview:view];
    
}

- (void)bottomClickAction:(NSInteger)status {
    NSString * url = @"";
    if (status == 1) {
        //创建清单
        QYZJCreateShiGongQingDanTVC * vc =[[QYZJCreateShiGongQingDanTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = self.dataModel.turnover.ID;
        vc.IDTwo = self.ID;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }else if (status == 2) {
        //确认支付
        url = [QYZJURLDefineTool user_turnoverCheckURL];
        
    }else if (status == 3) {
        //支付首款
         url = [QYZJURLDefineTool user_turnoverCheckURL];
    }else if (status == 6) {
        //支付尾款
         url = [QYZJURLDefineTool user_turnoverFinalPayURL];
    }else if (status == 7) {
        //设置保修时间
        QYZJSetBaoXiuTVC * vc =[[QYZJSetBaoXiuTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        NSMutableArray<QYZJWorkModel * > * arr = self.dataModel.constructionStage.mutableCopy;
        [arr addObjectsFromArray:self.dataModel.changeConstructionStage];
        vc.dataArray =arr;
        vc.ID = self.ID;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.ID;
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            QYZJTongYongModel * mm = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
            QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
            vc.ID = self.dataModel.turnoverList.ID;
            vc.hidesBottomBarWhenPushed = YES;
            
            if (status == 2 || status == 3) {
                vc.type = 7;
            }else {
                vc.type = 8;
            }
            vc.model = mm;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_turnoverDetailsURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.dataModel = [QYZJWorkModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.titleModel = [QYZJFindModel mj_objectWithKeyValues:responseObject[@"result"][@"demand"]];
            self.titleModel.allPrice = self.dataModel.turnoverList.allPrice;
            [self setFootVWithStatus:[self.dataModel.turnover.status intValue]];
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
    // 1区订单, 2区 首款和尾款的问题 3-6区 相册部分 7区 整体施工进度  8 正常施工 9去变更清单 10区 施工阶段 11 区变更施工阶段
    if (self.dataModel == nil) {
        return 0;
    }
    return self.headTitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isUPUPUP && !(section>=2 && section <=6)) {
        return 0;
    }
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 2;
    }else if (section<=5) {
        return 1;
    }else if (section <= 8) {
        return 1;
    } else if (section == 9) {
        return self.dataModel.constructionStage.count;
    }else if (section == 10) {
        return self.dataModel.changeConstructionStage.count;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 125;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (self.dataModel.turnoverListOrderFirst == nil) {
                return 0;
            }
            return self.dataModel.turnoverListOrderFirst.cellHeight;
        }else {
            if (self.dataModel.turnoverListOrderFinal == nil) {
                return 0;
            }else {
                if ([self.dataModel.turnoverListOrderFinal.status isEqualToString:@"0"]) {
                    return 50;
                }
                return self.dataModel.turnoverListOrderFinal.cellHeight;
            }
            
        }
        return 110;
    }else if (indexPath.section == 2){
        return self.dataModel.demand.contract_url.length > 0 ? (ScreenW - 60)/3 + 25 : 0;
    }else if (indexPath.section == 3){
        return self.dataModel.demand.budget_url.length > 0 ? (ScreenW - 60)/3 + 25 : 0;
    }else if (indexPath.section == 4){
        return self.dataModel.demand.drawing_url.length > 0 ? (ScreenW - 60)/3 + 25 : 0;
    }else if (indexPath.section == 5){
        return self.dataModel.demand.change_table_url.length > 0 ? (ScreenW - 60)/3 + 25 : 0;
    }else if (indexPath.section == 6) {
        return self.dataModel.turnoverLists.count > 0? 80:0;
    }else if (indexPath.section == 7) {
        return self.dataModel.turnoverList.cellHeight;
    }else if (indexPath.section == 8) {
        if (self.dataModel.changeTurnoverLists.count == 0) {
            return 0;
        }
        return 20 + self.dataModel.changeTurnoverLists.count * 41 + 42;
    }else if (indexPath.section == 9) {
        return self.dataModel.constructionStage[indexPath.row].cellHeight;
    }else if (indexPath.section == 10) {
        return self.dataModel.changeConstructionStage[indexPath.row].cellHeight;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (isUPUPUP && !(section>=2 && section <=6)) {
        return 0.01;
    }
    
    if (section == 0) {
        return 10;
    }else if (section == 1) {
        if (self.dataModel.turnoverListOrderFirst == nil) {
            return 0.01;
        }else {
            return 10;
        }
    } else if (section ==2) {
        return self.dataModel.demand.contract_url.length > 0 ? 10:0.01;
    }else if (section ==3) {
        return self.dataModel.demand.budget_url.length > 0 ? 10:0.01;
    }else if (section ==4) {
        return self.dataModel.demand.drawing_url.length > 0 ? 10:0.01;
    }else if (section ==5) {
        return self.dataModel.demand.change_table_url.length > 0 ? 10:0.01;
    }else if (section == 6 ||  section == 7 ) {
        return self.dataModel.turnoverLists.count > 0 ? 10:0.01;
    }else if (section == 8 ) {
        return  10;
    }else if (section == 9) {
        if (!self.dataModel.demand.is_service ) {
            return self.dataModel.constructionStage.count > 0 ? 60:240;
        }else {
            return self.dataModel.constructionStage.count > 0 ? 10:210;
        }
        
    }else if (section == 10) {
        if (!self.dataModel.demand.is_service ) {
            return self.dataModel.changeConstructionStage.count > 0 ? 60:240;
        }else {
            return self.dataModel.changeConstructionStage.count > 0 ? 10:210;
        }
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (isUPUPUP && !(section>=2 && section <=6)) {
        return 0.01;
    }
    
    if (section == 0) {
        return 0.01;
    }else if (section==1) {
        if (self.dataModel.turnoverListOrderFirst == nil) {
            return 0.01;
        }else {
            return 40;
        }
    } else if (section ==2) {
        return self.dataModel.demand.contract_url.length > 0 ? 40:0.01;
    }else if (section ==3) {
        return self.dataModel.demand.budget_url.length > 0 ? 40:0.01;
    }else if (section ==4) {
        return self.dataModel.demand.drawing_url.length > 0 ? 40:0.01;
    }else if (section ==5) {
        return self.dataModel.demand.change_table_url.length > 0 ? 40:0.01;
    }else if (section == 6 ||  section == 7 ) {
        return self.dataModel.turnoverLists.count > 0 ? 40:0.01;
    }else if (section == 8 ) {
        return  40;
    }else if (section == 10 || section == 9) {
        return 40;
    }
    return 0.01;
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = RGB(245, 245, 245);
        UIView * whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 270)];
        whiteV.backgroundColor = [UIColor whiteColor];
        whiteV.tag = 100;
        [view addSubview:whiteV];
        
        UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW/2-60, 30, 120, 120)];
        imgV.image =[UIImage imageNamed:@"nodata"];
        imgV.tag = 103;
        [whiteV addSubview:imgV];
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 160 , ScreenW - 20, 20)];
        lb.textColor = CharacterColor180;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = kFont(13);
        lb.tag = 101;
        [whiteV addSubview:lb];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW / 2 - 50, 190, 100, 30)];
        [button setTitle:@"创建阶段" forState:UIControlStateNormal];
        button.titleLabel.font = kFont(13);
        [button setTitleColor:OrangeColor forState:UIControlStateNormal];
        button.layer.cornerRadius = 3;
        button.layer.borderColor = OrangeColor.CGColor;
        button.layer.borderWidth = 1.0;
        button.clipsToBounds = YES;
        button.tag = 102;
        [view addSubview:button];
        [button setImage:[UIImage imageNamed:@"35"] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    }
    
    UIView * whiteV = [view viewWithTag:100];
    UILabel * lb = (UILabel *)[whiteV viewWithTag:101];
    UIButton * bt = (UIButton *)[view viewWithTag:102];
    UIImageView * imgV = (UIImageView *)[whiteV viewWithTag:103];
  
    @weakify(self);
    [[bt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
    
        NSInteger ddd = [self getturnoverIDWithSection:section];
        if (section == 9) {
            if (ddd == 0 ) {
                [SVProgressHUD showErrorWithStatus:@"请先完成上一个阶段才能添加"];
                return ;
            }else if (ddd == 1) {
                QYZJWorkModel * model = self.dataModel.turnoverLists[self.dataModel.constructionStage.count];
                QYZJAddWorkMomentTVC * vc =[[QYZJAddWorkMomentTVC alloc] init];
                vc.ID = self.dataModel.turnoverList.ID;
                vc.price = model.price;
                vc.changeType = 1;
                vc.titleStr = model.stageName;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else {
                [SVProgressHUD showErrorWithStatus:@"实际阶段已经全部操作完,请添加变更阶段"];
                return ;
                
            }

        }else {
            
            if (ddd == 0 ) {
                [SVProgressHUD showErrorWithStatus:@"请先完成上一个阶段才能添加"];
                return ;
            }else if (ddd == 1) {
                QYZJWorkModel * model = self.dataModel.changeTurnoverLists[self.dataModel.changeConstructionStage.count];
                QYZJAddWorkMomentTVC * vc =[[QYZJAddWorkMomentTVC alloc] init];
                vc.ID = self.dataModel.turnoverList.ID;
                vc.price = model.price;
                vc.changeType = 2;
                vc.titleStr = model.stageName;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else {
                [SVProgressHUD showErrorWithStatus:@"请添加变更阶段"];
                return ;
                
            }
            
        }
    }];
    
    
    if (section == 9) {
        lb.text = @"还没有开工";
    }else {
        lb.text = @"暂无变更阶段";
    }
    if (section < 9) {
        whiteV.hidden = YES;
        view.mj_h = 10;
        bt.hidden = YES;
    }else {
        whiteV.hidden = NO;
        bt.hidden = NO;
        if (!self.dataModel.demand.is_service) {
            //服务方
            
            if ([self.dataModel.turnover.status intValue] <= 3 || [self.dataModel.turnover.status intValue]  >=8 || (self.dataModel.turnoverLists.count == self.dataModel.constructionStage.count && section == 9)) {
                  bt.hidden = YES;
              }else {
                  bt.hidden = NO;
              }
            
            if ((section == 9 && self.dataModel.constructionStage.count > 0) || (section == 10 && self.dataModel.changeConstructionStage.count > 0)) {
                whiteV.mj_h = 50;
                view.mj_h = 60;
                bt.mj_y = 10;
                imgV.hidden = lb.hidden = YES;
            }else {
                view.mj_h = 240;
                whiteV.mj_h = 230;
                bt.mj_y = 190;
            }
        }else {
            
            if ((section == 9 && self.dataModel.constructionStage.count > 0) || (section == 10 && self.dataModel.changeConstructionStage.count > 0)) {
                bt.hidden = YES;
                whiteV.hidden = YES;
                view.mj_h = 10;
                
            }else {
                whiteV.mj_h = 200;
                view.mj_h = 210;
                bt.hidden = YES;
            }
        }
    }
    
    
    return view;
}

// 0 上面有未完成的阶段 1 正常 2 所有阶段都已完成
- (NSInteger )getturnoverIDWithSection:(NSInteger)section {
    if (section == 9) {
        if (self.dataModel.constructionStage.count < self.dataModel.turnoverLists.count) {
            for (QYZJWorkModel * model  in self.dataModel.constructionStage) {
                if (!([model.status isEqualToString:@"4"] || [model.status isEqualToString:@"6"] || [model.status isEqualToString:@"7"])) {
                    return 0;
                }
            }
            return 1;
        }else {
            return 2;
        }
    }else {
       if (self.dataModel.changeConstructionStage.count < self.dataModel.changeTurnoverLists.count) {
            for (QYZJWorkModel * model  in self.dataModel.changeConstructionStage) {
                if (!([model.status isEqualToString:@"4"] || [model.status isEqualToString:@"6"] || [model.status isEqualToString:@"7"])) {
                    return 0;
                }
            }
            return 1;
       }else {
           return 2;
       }
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    QYZJTongYongHeadFootView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (view == nil) {
        view = [[QYZJTongYongHeadFootView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    }
    view.leftLB.text = self.headTitleArr[section];
    view.rightBt.hidden  = YES;
    if (section == 7) {
        view.leftLB.text = [NSString stringWithFormat:@"施工(总工期:%@天)",self.dataModel.turnoverList.allDays];
        if (([self.dataModel.turnover.status intValue] > 3 ) && !self.dataModel.demand.is_service){
            view.rightBt.hidden = NO;
            [view.rightBt setTitle:@"增加变更单" forState:UIControlStateNormal];
            [view.rightBt setTitleColor:OrangeColor forState:UIControlStateNormal];
            view.rightBt.layer.cornerRadius = 4;
            view.rightBt.layer.borderColor = OrangeColor.CGColor;
            view.rightBt.layer.borderWidth = 1;
            view.rightBt.clipsToBounds = YES;
            [view.rightBt addTarget:self action:@selector(addChangeTurnonerAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        if ([self.dataModel.turnover.status intValue] == 8) {
            view.rightBt.hidden = YES;
        }

    }
    
    view.backgroundColor = WhiteColor;
    view.contentView.backgroundColor = WhiteColor;
    view.clipsToBounds = YES;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QYZJHomePayCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomePayCell" forIndexPath:indexPath];
        cell.type = 1;
        cell.model = self.titleModel;
        cell.lineV.hidden = YES;
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            QYZJHomePayDetailOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomePayDetailOneCell" forIndexPath:indexPath];
            cell.clipsToBounds = YES;
            cell.model = self.dataModel.turnoverListOrderFirst;
            cell.clipsToBounds = YES;
            return cell;
        }else {
            if ( [self.dataModel.turnoverListOrderFinal.status intValue] == 0) {
                QYZJHomePayDetailTwoCell * cellTwo =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomePayDetailTwoCell" forIndexPath:indexPath];
                cellTwo.clipsToBounds = YES;
                cellTwo.clipsToBounds = YES;
                cellTwo.moneyLB.text = [NSString stringWithFormat:@"￥%0.2f",self.dataModel.turnoverListOrderFinal.payMoney];
                cellTwo.clipsToBounds = YES;
                return cellTwo;
            }else {
                QYZJHomePayDetailOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomePayDetailOneCell" forIndexPath:indexPath];
                cell.clipsToBounds = YES;
                cell.model = self.dataModel.turnoverListOrderFinal;
                cell.clipsToBounds = YES;
                return cell;
            }
        }
        
    }else if (indexPath.section <=5) {
        QYZJPicShowCell* cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJPicShowCell" forIndexPath:indexPath];
        if (indexPath.section == 2){
            cell.picsArr = [self.dataModel.demand.contract_url componentsSeparatedByString:@","];
        }else if (indexPath.section == 3){
            cell.picsArr = [self.dataModel.demand.budget_url componentsSeparatedByString:@","];
        }else if (indexPath.section == 4){
            cell.picsArr = [self.dataModel.demand.drawing_url componentsSeparatedByString:@","];
        }else if (indexPath.section == 5){
            cell.picsArr = [self.dataModel.demand.change_table_url componentsSeparatedByString:@","];
        }
        cell.clipsToBounds = YES;
        return cell;
    }else if (indexPath.section == 6) {
        QYZJConstructionProgressCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJConstructionProgressCell" forIndexPath:indexPath];
        cell.number = self.dataModel.constructionStage.count;
        cell.dataArray = self.dataModel.turnoverLists;
        cell.clipsToBounds = YES;
        return cell;
    }else if (indexPath.section == 7) {
        QYZJConstructionCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJConstructionCell" forIndexPath:indexPath];
        cell.dataArray = self.dataModel.turnoverLists;
        cell.model = self.dataModel.turnoverList;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
        return cell;
    }else if (indexPath.section == 8) {
        QYZJChangeConstructionOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJChangeConstructionOneCell" forIndexPath:indexPath];
        cell.is_service = self.dataModel.demand.is_service;
        cell.dataArray = self.dataModel.changeTurnoverLists;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 9) {
        
        QYZJConstructionListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJConstructionListCell" forIndexPath:indexPath];
        cell.is_service = self.dataModel.demand.is_service;
//        self.dataModel.constructionStage[indexPath.row].price = self.dataModel.turnoverLists.count > indexPath.row ? self.dataModel.turnoverLists[indexPath.row].price:0;
        cell.model = self.dataModel.constructionStage[indexPath.row];
        cell.delegate = self;
        cell.clipsToBounds = YES;
        return cell;
        
    }else if (indexPath.section == 10) {
        QYZJConstructionListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJConstructionListCell" forIndexPath:indexPath];
        cell.is_service = self.dataModel.demand.is_service;
        cell.model = self.dataModel.changeConstructionStage[indexPath.row];
        cell.clipsToBounds = YES;
        cell.delegate = self;
        return cell;
    }
    QYZJHomePayDetailOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomePayDetailOneCell" forIndexPath:indexPath];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QYZJWorkModel * model = nil;
    
    
    
    if (indexPath.section == 9) {
        model = self.dataModel.constructionStage[indexPath.row];
    }else if (indexPath.section == 10){
        model = self.dataModel.changeConstructionStage[indexPath.row];
    }
    if (model == nil) {
        return;
    }
    QYZJFindModel * modelNei = [[QYZJFindModel alloc] init];
    modelNei.nickName = model.stageName;
    modelNei.content = model.des;
    modelNei.time = model.time;
    modelNei.pictures = model.pics.mutableCopy;
    modelNei.videos = model.videos.mutableCopy;
    modelNei.price = model.price;
    modelNei.isOverRepairTime = model.isOverRepairTime;
    modelNei.isRepair = model.isRepair;
    modelNei.is_service = self.dataModel.demand.is_service;
    modelNei.status = model.status;
    modelNei.evaluateLevel = model.evaluateLevel;
    modelNei.evaluateCon = model.evaluateCon;
    modelNei.ID = model.ID;
    modelNei.turnoverListId = model.turnoverListId;
    modelNei.constructionStageId = model.ID;
    modelNei.selfId = model.ID;
    
    if (model.picUrl.length > 0) {
       modelNei.pictures = [model.picUrl componentsSeparatedByString:@","].mutableCopy;
    }
    
    modelNei.type = [NSString stringWithFormat:@"%d",indexPath.section - 8];
    QYZJMineBaoXiuDetailTVC * vc =[[QYZJMineBaoXiuDetailTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.type = 1;
    if ([self.dataModel.turnover.status intValue] == 8) {
        modelNei.selfId = @"0";
    }
    vc.staus = [self.dataModel.turnover.status intValue];
    vc.model = modelNei;
    [self.navigationController pushViewController:vc animated:YES];
}


//添加变更清单
- (void)addChangeTurnonerAction:(UIButton *)button {
    
    QYZJChangeDetailedListTVC * vc =[[QYZJChangeDetailedListTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.picsArr = self.dataModel.demand.change_table_urls.mutableCopy;
    vc.ID = self.ID;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark ---- 点击 提交验收 和修改 ---
- (void)didclickQYZJConstructionListCell:(QYZJConstructionListCell *)cell withIndex:(NSInteger)index isNeiClick:(BOOL)isNei NeiRow:(NSInteger)row isClickNeiCell:(BOOL)isClickNeiCell{
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QYZJWorkModel * model = nil;
    QYZJWorkModel * modelTwo = nil;
    
    if (isClickNeiCell) {
        //点击的是内容部cell
        if (indexPath.section == 9) {
                model = self.dataModel.constructionStage[indexPath.row].selfStage[row];
                modelTwo = self.dataModel.constructionStage[indexPath.row];
            }else {
                model = self.dataModel.changeConstructionStage[indexPath.row].selfStage[row];
                modelTwo = self.dataModel.changeConstructionStage[indexPath.row];
            }
  
          QYZJFindModel * modelNei = [[QYZJFindModel alloc] init];
          modelNei.nickName = model.stageName;
          modelNei.content = model.des;
          modelNei.time = model.time;
        if (model.picUrl.length > 0) {
           modelNei.pictures = [model.picUrl componentsSeparatedByString:@","].mutableCopy;
        }
          modelNei.videos = model.videos.mutableCopy;
          modelNei.price = model.price;
          modelNei.isOverRepairTime = model.isOverRepairTime;
          modelNei.isRepair = model.isRepair;
          modelNei.is_service = self.dataModel.demand.is_service;
          modelNei.status = model.status;
          modelNei.evaluateLevel = model.evaluateLevel;
          modelNei.evaluateCon = model.evaluateCon;
          modelNei.ID = model.ID;
          modelNei.turnoverListId = model.turnoverListId;
          modelNei.constructionStageId = model.ID;
          modelNei.selfId = modelTwo.ID;
          modelNei.type = [NSString stringWithFormat:@"%d",indexPath.section - 8];
          QYZJMineBaoXiuDetailTVC * vc =[[QYZJMineBaoXiuDetailTVC alloc] init];
          vc.staus = [self.dataModel.turnover.status intValue];
          vc.hidesBottomBarWhenPushed = YES;
          vc.type = 1;
          vc.isNoShow = YES;
        
             if ([self.dataModel.turnover.status intValue] == 8) {
                 modelNei.selfId = @"0";
             }
        
          vc.model = modelNei;
        
          
        
          [self.navigationController pushViewController:vc animated:YES];
        
        
    }else {
        
        if (isNei) {
            
            if (indexPath.section == 9) {
                model = self.dataModel.constructionStage[indexPath.row].selfStage[row];
                modelTwo = self.dataModel.constructionStage[indexPath.row];
            }else {
                model = self.dataModel.changeConstructionStage[indexPath.row].selfStage[row];
                modelTwo = self.dataModel.changeConstructionStage[indexPath.row];
            }
        }else {
            
            if (indexPath.section == 9) {
                model = self.dataModel.constructionStage[indexPath.row];
                modelTwo = self.dataModel.constructionStage[indexPath.row];
            }else {
                model = self.dataModel.changeConstructionStage[indexPath.row];
                modelTwo = self.dataModel.changeConstructionStage[indexPath.row];
            }
        }
        
        
        if (index == 0) {
            //点击修改
            QYZJAddWorkMomentTVC * vc =[[QYZJAddWorkMomentTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = model.ID;
            vc.picsArrTwo = model.pics.mutableCopy;
            vc.videoUrl = model.videos.count > 0 ? [model.videos firstObject] : @"";
            vc.titleStr = model.stageName;
            vc.contentStr = model.des;
            vc.type = 4;
            vc.changeType = indexPath.section - 8;
            vc.IDTwo = self.dataModel.turnoverList.ID;
            vc.constructionStageId = model.constructionStageId;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
              //点击验收或者提交验收
              if (self.dataModel.demand.is_service) {
                  
                  if ([model.status isEqualToString:@"7"]) {
                      QYZJQingDanPingJiaVC * vc =[[QYZJQingDanPingJiaVC alloc] init];
                      vc.hidesBottomBarWhenPushed = YES;
                      vc.ID = modelTwo.ID;
                      [self.navigationController pushViewController:vc animated:YES];
                      return;
                  }
                  
                  
                //验收
                UIAlertController  * alertVC = [UIAlertController alertControllerWithTitle:@"变更审核" message:@"请选择审核状态" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"不通过" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self yanShouOrTiaoJiaoWithUrl:[QYZJURLDefineTool user_turnoverStageNotPassURL] andID:model.ID isYanShou:YES];
                    
                }];
                UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"通过" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self yanShouOrTiaoJiaoWithUrl:[QYZJURLDefineTool user_turnoverStagePassURL] andID:model.ID isYanShou:YES];
                    
                }];
                
               
                [alertVC addAction:action2];
                [alertVC addAction:action3];
                [alertVC addAction:action1];
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
                
            }else {
                //提交验收
                [self yanShouOrTiaoJiaoWithUrl:[QYZJURLDefineTool user_turnoverStageConfirmURL] andID:model.ID isYanShou:NO];
            }
            
            
        }
        
    }
    
    
    
    
    
}

- (void)yanShouOrTiaoJiaoWithUrl:(NSString *)url andID:(NSString *)ID isYanShou:(BOOL)isYanShou{
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = ID;
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            if (isYanShou) {
                
                [SVProgressHUD showSuccessWithStatus:@"审核状态成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [self getData];
                });
                
            }else {
                [SVProgressHUD showSuccessWithStatus:@"提交阶段验收成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [self getData];
                });
            }
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


#pragma mark ---- 点击变更清单的内容 ----

- (void)didClickQYZJChangeConstructionOneCell:(QYZJChangeConstructionOneCell*)cell withIndex:(NSInteger)index {
    QYZJWorkModel * model = self.dataModel.changeTurnoverLists[index];
    
    if ([model.status integerValue] == 1) {
        
        UIAlertController  * alertVC = [UIAlertController alertControllerWithTitle:@"变更审核" message:@"请选择审核状态" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }];
        
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"不通过" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            [self changeTurnoverCheckWithStatus:0 withType:1 WithID:model.ID withIsNOPush:NO];
            
        }];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"通过" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            [self changeTurnoverCheckWithStatus:1 withType:1 WithID:model.ID withIsNOPush:NO];
            
        }];
        
        
        [alertVC addAction:action2];
        [alertVC addAction:action3];
        [alertVC addAction:action1];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        
    }else {
        
        UIAlertController  * alertVC = [UIAlertController alertControllerWithTitle:@"支付" message:@"请选择付款方式" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }];
        
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"线上" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            [self changeTurnoverCheckWithStatus:1 withType:2 WithID:model.ID withIsNOPush:NO];
            
        }];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"线下" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

             [self changeTurnoverCheckWithStatus:1 withType:2 WithID:model.ID withIsNOPush:YES];
            UIAlertController  * alertVCTwo = [UIAlertController alertControllerWithTitle:@"提示" message:@"请联系客服,并提供相应付款证明完成支付操作" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction * action1Two = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
                
                
            }];
            [alertVCTwo addAction:action1Two];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVCTwo animated:YES completion:nil];
        }];
        
        
        [alertVC addAction:action2];
        [alertVC addAction:action3];
        [alertVC addAction:action1];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        
    }
}
//审核 type 1  2 支付
- (void)changeTurnoverCheckWithStatus:(NSInteger)isSure withType:(NSInteger)type WithID:(NSString *)ID withIsNOPush:(BOOL)isNOPush{
    NSString * url = @"";
    if (type == 1) {
        url = [QYZJURLDefineTool user_changeTurnoverCheckURL];
    }else {
        url = [QYZJURLDefineTool user_changeTurnoverChecksURL];
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = ID;
    dict[@"isSure"] = @(isSure);
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            if (type == 1) {
                [self getData];
            }else {
                
                if (isNOPush) {
                   
                }else {
                    QYZJTongYongModel *mm = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
                    QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.type = 9;
                    vc.ID = ID;
                    vc.model = mm;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

@end
