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
@interface QYZJMinePayDetailVC ()<QYZJChangeConstructionOneCellDelegate>
@property(nonatomic,strong)NSArray *headTitleArr;
@property(nonatomic,strong)QYZJWorkModel *dataModel;
@property(nonatomic,strong)QYZJFindModel *titleModel;
@end

@implementation QYZJMinePayDetailVC

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
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    
    self.navigationItem.title = @"详情";
    
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
    return self.headTitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
            }
            return self.dataModel.turnoverListOrderFinal.cellHeight;
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
        return 80;
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
        return self.dataModel.changeTurnoverLists.count > 0 ? 10:0.01;
    }else if (section == 9) {
        return self.dataModel.constructionStage.count > 0 ? 10:0.01;
    }else if (section == 10) {
        return self.dataModel.changeConstructionStage.count > 0 ? 10:0.01;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
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
    }else if (section == 6 ||  section == 7 || section == 9) {
        return self.dataModel.turnoverLists.count > 0 ? 40:0.01;
    }else if (section == 8 ) {
        return self.dataModel.changeTurnoverLists.count > 0 ? 40:0.01;
    }else if (section == 10) {
        return self.dataModel.changeConstructionStage.count > 0 ? 40:0.01;
    }
    return 0.01;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    QYZJTongYongHeadFootView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (view == nil) {
        view = [[QYZJTongYongHeadFootView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    }
    view.leftLB.text = self.headTitleArr[section];
    view.rightBt.hidden  = YES;
    if (section == 7) {
        view.leftLB.text = [NSString stringWithFormat:@"施工(总工期:%@天)",self.dataModel.turnoverList.allDays];
        if (([self.dataModel.turnover.status intValue] == 2 || [self.dataModel.turnover.status intValue] == 3) && !self.dataModel.demand.is_service){
            view.rightBt.hidden = NO;
            [view.rightBt setTitle:@"增加变更单" forState:UIControlStateNormal];
            [view.rightBt setTitleColor:OrangeColor forState:UIControlStateNormal];
            view.rightBt.layer.cornerRadius = 4;
            view.rightBt.layer.borderColor = OrangeColor.CGColor;
            view.rightBt.layer.borderWidth = 1;
            view.rightBt.clipsToBounds = YES;
            [view.rightBt addTarget:self action:@selector(addChangeTurnonerAction:) forControlEvents:UIControlEventTouchUpInside];
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
        cell.clipsToBounds = YES;
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
        cell.dataArray = self.dataModel.turnoverLists;
        cell.clipsToBounds = YES;
        return cell;
    }else if (indexPath.section == 7) {
        QYZJConstructionCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJConstructionCell" forIndexPath:indexPath];
        cell.dataArray = self.dataModel.turnoverLists;
        cell.model = self.dataModel.turnoverList;
        cell.clipsToBounds = YES;
        return cell;
    }else if (indexPath.section == 8) {
        QYZJChangeConstructionOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJChangeConstructionOneCell" forIndexPath:indexPath];
        cell.is_service = self.dataModel.demand.is_service;
        cell.dataArray = self.dataModel.changeTurnoverLists;
        cell.clipsToBounds = YES;
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 9) {
        
        QYZJConstructionListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJConstructionListCell" forIndexPath:indexPath];
        cell.model = self.dataModel.constructionStage[indexPath.row];
        cell.clipsToBounds = YES;
        return cell;
        
    }else if (indexPath.section == 10) {
        QYZJConstructionListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJConstructionListCell" forIndexPath:indexPath];
        cell.model = self.dataModel.changeConstructionStage[indexPath.row];
        cell.clipsToBounds = YES;
        return cell;
    }
    QYZJHomePayDetailOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomePayDetailOneCell" forIndexPath:indexPath];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


//添加变更清单
- (void)addChangeTurnonerAction:(UIButton *)button {
    
    QYZJChangeDetailedListTVC * vc =[[QYZJChangeDetailedListTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.picsArr = self.dataModel.demand.change_table_urls.mutableCopy;
    vc.ID = self.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark ---- 点击变更清单的内容 ----

- (void)didClickQYZJChangeConstructionOneCell:(QYZJChangeConstructionOneCell*)cell withIndex:(NSInteger)index {
    QYZJWorkModel * model = self.dataModel.changeTurnoverLists[index];
    
    if ([model.status integerValue] == 1) {
        
        UIAlertController  * alertVC = [UIAlertController alertControllerWithTitle:@"变更审核" message:@"请选择审核状态" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }];
        
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"不通过" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            [self changeTurnoverCheckWithStatus:0 withType:1 WithID:model.ID];
            
        }];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"通过" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            [self changeTurnoverCheckWithStatus:1 withType:1 WithID:model.ID];
            
        }];
        
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [alertVC addAction:action3];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        
    }else {
        
        UIAlertController  * alertVC = [UIAlertController alertControllerWithTitle:@"支付" message:@"请选择付款方式" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }];
        
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"线上" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            [self changeTurnoverCheckWithStatus:1 withType:2 WithID:model.ID];
            
        }];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"线下" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            
            UIAlertController  * alertVCTwo = [UIAlertController alertControllerWithTitle:@"提示" message:@"请联系客服,并提供相应付款证明完成支付操作" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction * action1Two = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
                
                
            }];
            [alertVCTwo addAction:action1Two];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVCTwo animated:YES completion:nil];
        }];
        
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [alertVC addAction:action3];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        
    }
}
//审核 type 1装填改变 2 支付
- (void)changeTurnoverCheckWithStatus:(NSInteger)isSure withType:(NSInteger)type WithID:(NSString *)ID{
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
                QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
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
