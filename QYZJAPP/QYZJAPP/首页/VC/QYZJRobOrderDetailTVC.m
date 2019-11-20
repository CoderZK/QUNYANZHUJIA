//
//  QYZJRobOrderDetailTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/20.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJRobOrderDetailTVC.h"
#import "QYZJRobOrderDetailCell.h"
#import "QYZJPicShowCell.h"
@interface QYZJRobOrderDetailTVC ()
@property(nonatomic,strong)QYZJWorkModel *dataModel;
@property(nonatomic,strong)NSArray *headTitleArr;
@property(nonatomic,strong)NSArray *leftTitleArr;
@end

@implementation QYZJRobOrderDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJRobOrderDetailCell" bundle:nil] forCellReuseIdentifier:@"QYZJRobOrderDetailCell"];
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"TongYongTwoCell"];
    [self.tableView registerClass:[QYZJPicShowCell class] forCellReuseIdentifier:@"QYZJPicShowCell"];
    self.headTitleArr = @[@"",@"",@"合同",@"预算",@"图纸",@"变更相册",@""];
    self.leftTitleArr = @[@"订单号",@"地址",@"小区名称",@"风格",@"户型",@"装修时间",@"需求类型",@"预算",@"建筑面积",@"需求描述",@"联系电话",@"反馈内容",@"客服回复",@"申诉状态",@"申诉内容"];
    
    [self setFootV];
    
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    UIView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"查看交付" andImgaeName:@""];
    Weak(weakSelf);
    [PublicFuntionTool shareTool].finshClickBlock = ^(UIButton * _Nonnull button) {
        NSLog(@"\n\n%@",@"完成");
    };
    [self.view addSubview:view];
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_demandInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataModel = [QYZJWorkModel mj_objectWithKeyValues:responseObject[@"result"]];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}





- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1 || section == 6) {
        return 0.01;
    }else if (section ==2) {
        return self.dataModel.contract_url.length > 0 ? 40:0.01;
    }else if (section ==3) {
        return self.dataModel.budget_url.length > 0 ? 40:0.01;
    }else if (section ==4) {
        return self.dataModel.drawing_url.length > 0 ? 40:0.01;
    }else if (section ==5) {
        return self.dataModel.change_table_url.length > 0 ? 40:0.01;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section ==2) {
        return self.dataModel.contract_url.length > 0 ? 10:0.01;
    }else if (section ==3) {
        return self.dataModel.budget_url.length > 0 ? 10:0.01;
    }else if (section ==4) {
        return self.dataModel.drawing_url.length > 0 ? 10:0.01;
    }else if (section ==5) {
        return self.dataModel.change_table_url.length > 0 ? 10:0.01;
    }
    return 10;
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = RGB(245, 245, 245);
    }
    view.clipsToBounds = YES;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    QYZJTongYongHeadFootView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (view == nil) {
        view = [[QYZJTongYongHeadFootView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    }
    view.leftLB.text = self.headTitleArr[section];
    view.backgroundColor = WhiteColor;
    view.contentView.backgroundColor = WhiteColor;
    view.clipsToBounds = YES;
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataModel.media_url.count;
    }else if (section == 1) {
        return 15;
    }else if (section < 6) {
        return 1;
    }else {
        return 2;
    }
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 85;
    }else if (indexPath.section ==1) {
        return  [self cellHeightWithIndexPath:indexPath];
    } else if (indexPath.section == 6) {
        return 50;
    }else if (indexPath.section == 2){
        
        return self.dataModel.contract_url.length > 0 ? (ScreenW - 60)/3 + 25 : 0;
    }else if (indexPath.section == 3){
        
        return self.dataModel.budget_url.length > 0 ? (ScreenW - 60)/3 + 25 : 0;
    }else if (indexPath.section == 4){
        
        return self.dataModel.drawing_url.length > 0 ? (ScreenW - 60)/3 + 25 : 0;
    }else if (indexPath.section == 5){
        
        return self.dataModel.change_table_url.length > 0 ? (ScreenW - 60)/3 + 25 : 0;
    }
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        QYZJRobOrderDetailCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJRobOrderDetailCell" forIndexPath:indexPath];
        cell.clipsToBounds = YES;
        return cell;
    }else if (indexPath.section == 1 || indexPath.section == 6) {
        TongYongTwoCell* cell =[tableView dequeueReusableCellWithIdentifier:@"TongYongTwoCell" forIndexPath:indexPath];
        cell.moreImgV.hidden = YES;
        cell.TF.placeholder = @"";
        cell.TF.userInteractionEnabled = NO;
        cell.TF.textColor = CharacterColor80;
        cell.leftLB.textColor = CharacterBlack112;
        cell.moreImgV.image = [UIImage imageNamed:@"phone"];
        if (indexPath.section == 1) {
            cell.leftLB.text = self.leftTitleArr[indexPath.row];
            [self setTitleWithCell:cell WithIndexPath:indexPath];
        }else {
            if (indexPath.row == 0) {
                cell.leftLB.text = @"签单金额";
                cell.TF.text = [NSString stringWithFormat:@"￥%0.2f",self.dataModel.sign_money];
            }else {
                cell.leftLB.text = @"佣金额";
                cell.TF.text = [NSString stringWithFormat:@"￥%0.2f",self.dataModel.commission_price];
            }
        }
        cell.clipsToBounds = YES;
        return cell;
    }else {
        QYZJPicShowCell* cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJPicShowCell" forIndexPath:indexPath];
        if (indexPath.section == 2){
            cell.picsArr = [self.dataModel.contract_url componentsSeparatedByString:@","];
        }else if (indexPath.section == 3){
            cell.picsArr = [self.dataModel.budget_url componentsSeparatedByString:@","];
        }else if (indexPath.section == 4){
            cell.picsArr = [self.dataModel.drawing_url componentsSeparatedByString:@","];
        }else if (indexPath.section == 5){
            cell.picsArr = [self.dataModel.change_table_url componentsSeparatedByString:@","];
            
        }
        cell.clipsToBounds = YES;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)setTitleWithCell:(TongYongTwoCell *)cell WithIndexPath:(NSIndexPath * )indexPath {
    if (indexPath.section == 1) {
        NSInteger row = indexPath.row;
        if (row == 0) {
            cell.TF.text = self.dataModel.no;
        }else if (row == 1) {
            cell.TF.text = self.dataModel.b_recomend_address.length > 0 ? self.dataModel.b_recomend_address:@"未填写";
        }else if (row == 2) {
            cell.TF.text = self.dataModel.b_recomend_name.length > 0 ? self.dataModel.b_recomend_name:@"未填写";
        }else if (row == 3) {
            //            cell.TF.text = self.dataModel.b_recomend_address.length > 0 ? self.dataModel.b_recomend_address:@"未填写";
        }else if (row == 4) {
            //            cell.TF.text = self.dataModel.b_recomend_address.length > 0 ? self.dataModel.b_recomend_address:@"未填写";
        }else if (row == 5) {
            //            cell.TF.text = self.dataModel.b_recomend_address.length > 0 ? self.dataModel.b_recomend_address:@"未填写";
        }else if (row == 6) {
            //            cell.TF.text = self.dataModel.b_recomend_address.length > 0 ? self.dataModel.b_recomend_address:@"未填写";
        }else if (row == 7) {
            cell.TF.text = self.dataModel.budget > 0 ? [NSString stringWithFormat:@"%0.2f元",self.dataModel.budget]:@"未填写";
        }else if (row == 8) {
            cell.TF.text = self.dataModel.area.length > 0 ? [NSString stringWithFormat:@"%@m2",self.dataModel.area]:@"未填写";
        }else if (row == 9) {
            cell.TF.text = self.dataModel.demand_context.length > 0 ? self.dataModel.demand_context:@"未填写";
        }else if (row == 10) {
            cell.TF.text = self.dataModel.real_tel.length > 0 ? self.dataModel.real_tel:@"未填写";
        }else if (row == 11) {
            cell.TF.text = self.dataModel.reason.length > 0 ? self.dataModel.reason:@"未填写";
        }else if (row == 12) {
            cell.TF.text = self.dataModel.feedback_reply.length > 0 ? self.dataModel.feedback_reply:@"未填写";
        }else if (row == 13) {
            if (self.dataModel.appeal_status == 1) {
                cell.TF.text = @"申诉成功";
            }else if (self.dataModel.appeal_status == 2){
                cell.TF.text = @"申诉失败";
            }
        }else if (row == 14) {
            cell.TF.text = self.dataModel.appeal_reason.length > 0 ? self.dataModel.appeal_reason:@"未填写";
        }
    }
    
    
}


- (CGFloat)cellHeightWithIndexPath:(NSIndexPath *)indexPath {
    CGFloat hh = 0;
    if (self.dataModel == nil) {
        return hh;
    }
    NSInteger row = indexPath.row;
    if (row == 0) {
        hh = self.dataModel.no.length > 0 ? 50:0;
    }else if (row == 1) {
        hh = self.dataModel.b_recomend_address.length > 0 ? 50:0;
    }else if (row == 2) {
        hh = self.dataModel.b_recomend_name.length > 0 ? 50:0;
    }else if (row == 3) {
         hh = self.dataModel.manner > 0 ? 50:0;
    }else if (row == 4) {
        hh = self.dataModel.house_model > 0 ? 50:0;
    }else if (row == 5) {
        hh = self.dataModel.renovation_time > 0 ? 50:0;
    }else if (row == 6) {
        hh = self.dataModel.type_name.length > 0 ? 50:0;
    }else if (row == 7) {
        hh = 50;
//         hh = self.dataModel.budget> 0 ? 50:0;
    }else if (row == 8) {
         hh = self.dataModel.area.length > 0 ? 50:0;
    }else if (row == 9) {
        hh = 50;
    }else if (row == 10) {
         hh = self.dataModel.real_tel.length > 0 ? 50:0;
    
    }else if (row == 11) {
         hh = self.dataModel.reason.length > 0 ? 50:0;
       
    }else  {
        hh = 50;
    }
    return hh;
}



@end
