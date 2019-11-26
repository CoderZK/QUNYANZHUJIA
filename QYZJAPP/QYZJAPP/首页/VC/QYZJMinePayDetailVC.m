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
@interface QYZJMinePayDetailVC ()
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
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = @"78";
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
    }else if (section == 9) {
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
        return 20 + self.dataModel.changeConstructionStage.count * 41 + 42;
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
    if (section == 7) {
        view.leftLB.text = [NSString stringWithFormat:@"施工(总工期:%@天)",self.dataModel.turnoverList.allDays];
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
        return cell;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            QYZJHomePayDetailOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomePayDetailOneCell" forIndexPath:indexPath];
            cell.clipsToBounds = YES;
            cell.model = self.dataModel.turnoverListOrderFirst;
            return cell;
        }else {
            if ( [self.dataModel.turnoverListOrderFinal.status intValue] == 0) {
                QYZJHomePayDetailTwoCell * cellTwo =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomePayDetailTwoCell" forIndexPath:indexPath];
                cellTwo.clipsToBounds = YES;
                cellTwo.clipsToBounds = YES;
                cellTwo.moneyLB.text = [NSString stringWithFormat:@"￥%0.2f",self.dataModel.turnoverListOrderFinal.payMoney];
                return cellTwo;
            }else {
                QYZJHomePayDetailOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomePayDetailOneCell" forIndexPath:indexPath];
                cell.clipsToBounds = YES;
                cell.model = self.dataModel.turnoverListOrderFinal;
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
        return cell;
    }else if (indexPath.section == 7) {
        QYZJConstructionCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJConstructionCell" forIndexPath:indexPath];
        cell.dataArray = self.dataModel.turnoverLists;
        cell.model = self.dataModel.turnoverList;
        return cell;
    }else if (indexPath.section == 8) {
        QYZJChangeConstructionOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJChangeConstructionOneCell" forIndexPath:indexPath];
        cell.dataArray = self.dataModel.changeConstructionStage;
        return cell;
    }else if (indexPath.section == 9) {
        
        QYZJConstructionListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJConstructionListCell" forIndexPath:indexPath];
        cell.model = self.dataModel.constructionStage[indexPath.row];
        return cell;
        
    }else if (indexPath.section == 10) {
        QYZJConstructionListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJConstructionListCell" forIndexPath:indexPath];
        cell.model = self.dataModel.changeConstructionStage[indexPath.row];
        return cell;
    }
    QYZJHomePayDetailOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomePayDetailOneCell" forIndexPath:indexPath];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
