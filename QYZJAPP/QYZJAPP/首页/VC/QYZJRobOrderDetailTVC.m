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
#import "QYZJAddZiLiaoTVC.h"
#import "QYZJCreateShiGongQingDanTVC.h"
#import "QYZJMinePayDetailVC.h"
#import "QYZJOtherCell.h"
#import "QYZJQingDanPingJiaVC.h"
@interface QYZJRobOrderDetailTVC ()
@property(nonatomic,strong)QYZJWorkModel *dataModel;
@property(nonatomic,strong)NSArray *headTitleArr;
@property(nonatomic,strong)NSArray *leftTitleArr;
@property(nonatomic,strong)NSString *reason;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,assign)BOOL isRel;
@end

@implementation QYZJRobOrderDetailTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJRobOrderDetailCell" bundle:nil] forCellReuseIdentifier:@"QYZJRobOrderDetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJOtherCell" bundle:nil] forCellReuseIdentifier:@"QYZJOtherCell"];
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"TongYongTwoCell"];
    [self.tableView registerClass:[QYZJPicShowCell class] forCellReuseIdentifier:@"QYZJPicShowCell"];
    [self.tableView registerClass:[TongYongFourCell class] forCellReuseIdentifier:@"TongYongFourCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.headTitleArr = @[@"",@"",@"合同",@"预算",@"图纸",@"变更相册",@"",@""];
    self.leftTitleArr = @[@"订单号",@"地址",@"小区名称",@"风格",@"户型",@"装修时间",@"需求类型",@"预算",@"建筑面积",@"需求描述",@"联系电话",@"反馈内容",@"客服回复",@"申诉状态",@"申诉内容",@"驳回原因"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
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
            if (self.dataModel.real_tel.length > 0) {
                self.isRel = YES;
            }
            if (self.dataModel.link_tel.length > 0) {
                self.dataModel.real_tel = self.dataModel.link_tel;
            }
            if ([self.dataModel.status intValue]== 0 && self.dataModel.user_status.length == 0) {
                [self setFootVWithStatus:0];
            }else if ([self.dataModel.user_status intValue]== 2) {
                [self setFootVWithStatus:1];
            }else if ([self.dataModel.user_status intValue]== 3) {
                [self setFootVWithStatus:2];
            }else if ([self.dataModel.user_status intValue]== 4) {
                [self setFootVWithStatus:3];
            }else if ([self.dataModel.user_status intValue]== 5) {
                [self setFootVWithStatus:4];
            }else if ([self.dataModel.user_status intValue]== 6) {
                [self setFootVWithStatus:6];
            }else if ([self.dataModel.user_status intValue]== 7) {
                [self setFootVWithStatus:7];
            }else if ([self.dataModel.user_status intValue]== 8) {
                [self setFootVWithStatus:8];
            }else if ([self.dataModel.user_status intValue]== 10) {
                [self setFootVWithStatus:9];
            }
//            else if ([self.dataModel.user_status intValue]== 11) {
//                [self setFootVWithStatus:10];
//            }
            
            if (self.type== 0) {
                self.dataModel.contract_url = self.dataModel.budget_url = self.dataModel.drawing_url = self.dataModel.change_table_url = @"";
                self.dataModel.sign_money = 0;
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

// 0 抢单 1 反馈 2 签单 3 申诉 4 填写资料 6 签单失败 7 佣金支付 8 创建施工清单 9 查看交付 10 评价
- (void)setFootVWithStatus:(NSInteger)status {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60 - sstatusHeight - 44);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34 - sstatusHeight - 44);
    }
    
    
    
    
    KKKKFootView * view2 = (KKKKFootView *)[self.view viewWithTag:666];
    if (view2 != nil) {
        [view2 removeFromSuperview];
    }
    
    if (status == 6){
          self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 44);
          return;
      }

    if (status==1 || status == 2) {
        NSString * leftStr = @"反馈无效";
        NSString * rightStr = @"反馈有效";
        if (status == 2) {
            leftStr = @"签单失败";
            rightStr = @"签单成功";
        }
        KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvTwoWithLeftTitle:leftStr letfTietelColor:OrangeColor rightTitle:rightStr rightColor:WhiteColor];
        view.tag = 666;
        Weak(weakSelf);
        view.footViewClickBlock = ^(UIButton *button) {
            
            if (status == 1 && button.tag == 0) {
                self.status = 1;
                [self showTFWithStatus:1];
            }else {
                [weakSelf operateDemandActonWithIsOK:button.tag withStatus:status];
            }
        };
        [self.view addSubview:view];
        
    }else {
        
        NSString * str = @"";
        if (status == 0) {
            str = @"抢单";
        }else if (status == 3) {
            str = @"申诉";
        }else if (status == 4) {
            str = @"填写资料";
        }else if (status == 7){
            str = @"支付佣金";
        }else if (status == 8){
            str = @"交付";
        }else if (status == 9){
            str = @"查看交付";
        }else if (status == 10){
            str = @"评价";
        }
        KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:str andImgaeName:@""];
        view.tag = 666;
        Weak(weakSelf);
        view.footViewClickBlock = ^(UIButton *button) {
            [weakSelf clickActionWithStatus:status];
        };
        [self.view addSubview:view];
        
    }
    
    
}

//点击操作
// 0 抢单 1 反馈 2 签单 3 申诉 4 填写资料 7 佣金支付 8 创建施工清单 9 查看交付 10 评价
- (void)clickActionWithStatus:(NSInteger)status {
    
    if (status == 0) {
        [self robDemandAction];
    }else if (status == 3) {
        self.status = 3;
        [self showTFWithStatus:3];
    }else if (status == 4) {
        QYZJAddZiLiaoTVC * vc =[[QYZJAddZiLiaoTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = self.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (status == 7) {
        
         [self wecharPayWithID:self.ID money:self.dataModel.commission_price];
        
        
        
    }else if (status == 8) {
        
        [self jiaoFuAction];
        
        
    }else if (status == 9) {
        QYZJMinePayDetailVC * vc =[[QYZJMinePayDetailVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.ID = self.dataModel.turnoverId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else if (status == 10) {
        
        QYZJQingDanPingJiaVC * vc =[[QYZJQingDanPingJiaVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = self.ID;
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
    }
    
}

//交付中

- (void)jiaoFuAction {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"demand_grab_sheet_id"] = self.dataModel.demand_grab_sheet_id;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_createTurnoverURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            QYZJCreateShiGongQingDanTVC * vc =[[QYZJCreateShiGongQingDanTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = responseObject[@"result"][@"turnover_id"];
            vc.IDTwo = self.ID;
            vc.isRob = YES;
            [self.navigationController pushViewController:vc animated:YES];
        
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
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
            vc.ID = ID;
            vc.type = 2;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}



//抢单
- (void)robDemandAction {
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"抢单提示" message:@"确定抢单吗?" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * actionOne = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [SVProgressHUD show];
        NSMutableDictionary * dict = @{}.mutableCopy;
        dict[@"id"] = self.ID;
        [zkRequestTool networkingPOST:[QYZJURLDefineTool user_grabDemandURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [SVProgressHUD dismiss];
            if ([responseObject[@"key"] intValue]== 1) {
                
                
               QYZJTongYongModel  * modelNei = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
                if (modelNei.is_vip) {
                    [SVProgressHUD showSuccessWithStatus:@"抢单成功,请在一个小时内进行反馈,否则超时视为反馈有效并扣费"];
                    [self setFootVWithStatus:1];
                }else {
                    if (modelNei.status == 2) {
                        
                        QYZJTongYongModel * mm = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
                        QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
                       
                        vc.model = mm;
                        vc.type = 1;
                        vc.ID = self.ID;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                   
                }
               
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
            
        }];
        
        
    }];
    
    UIAlertAction * actionTwo = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:actionTwo];
    [alertVC addAction:actionOne];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
    
}

//操作单子
- (void)operateDemandActonWithIsOK:(NSInteger)isOk withStatus:(NSInteger)type{
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"demand_id"] = self.ID;
    dict[@"type"] = @(type);
    dict[@"is_ok"] = @(isOk);
    dict[@"reason"] = self.reason;
    dict[@"appeal_reason"] = self.reason;
    NSString * url = [QYZJURLDefineTool user_operateDemandURL];
    if (type == 3) {
        url = [QYZJURLDefineTool user_addAppealURL];
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            if (type == 1) {
                if (isOk == 0) {
                    [SVProgressHUD showSuccessWithStatus:@"反馈无效成功"];
                }else {
                    
                    if ([[NSString stringWithFormat:@"%@",responseObject[@"result"][@"is_vip"]] integerValue] == 1) {
                         [SVProgressHUD showSuccessWithStatus:@"反馈有效成功!反馈金额已从余额中支付!"];
                    }else {
                         [SVProgressHUD showSuccessWithStatus:@"反馈有效成功!"];
                    }
                }
            }else {
                if (isOk == 0) {
                    [SVProgressHUD showSuccessWithStatus:@"签单失败操作成功"];
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"签单操作成功"];
                }
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self getData];
                });
           
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}

// 输入申诉
- (void)showTFWithStatus:(NSInteger)status {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入申诉原因" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField*userNameTF = alertController.textFields.firstObject;
        
        self.reason = userNameTF.text;
        [self operateDemandActonWithIsOK:NO withStatus:self.status];
        
        
        
    }]];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
        
        textField.placeholder=@"请输入详细地址";
        
        
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
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
        view.backgroundColor = [UIColor groupTableViewBackgroundColor]; //[UIColor groupTableViewBackgroundColor];
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
    view.lineV.hidden = YES;
    view.backgroundColor = WhiteColor;
    view.contentView.backgroundColor = WhiteColor;
    view.clipsToBounds = YES;
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataModel.media_url.count;
    }else if (section == 1) {
        
        return self.leftTitleArr.count;
        
    }else if (section < 6) {
        return 1;
    }else if (section == 6) {
        return 2;
    }else {
        return self.dataModel.other.count;
    }
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row ==0) {
            return 85;
        }
        return 35;
        
    }else if (indexPath.section ==1) {
        if (indexPath.row == 10 && ([self.dataModel.status intValue] == 0 ||  self.dataModel.real_tel.length == 0)) {
            return 0;
        }
        return  [self cellHeightWithIndexPath:indexPath];
    }
    
    //    else if (indexPath.section == 6) {
    //        if (indexPath.row == 9) {
    //            return UITableViewAutomaticDimension;
    //        }
    //        return 50;
    //    }
    
    else if (indexPath.section == 2){
        
        return self.dataModel.contract_url.length > 0 ? (ScreenW - 60)/3 + 25 : 0;
    }else if (indexPath.section == 3){
        
        return self.dataModel.budget_url.length > 0 ? (ScreenW - 60)/3 + 25 : 0;
    }else if (indexPath.section == 4){
        
        return self.dataModel.drawing_url.length > 0 ? (ScreenW - 60)/3 + 25 : 0;
    }else if (indexPath.section == 5){
        
        return self.dataModel.change_table_url.length > 0 ? (ScreenW - 60)/3 + 25 : 0;
    }else if (indexPath.section == 6) {
        if (self.dataModel.sign_money == 0) {
            return 0;
        }else {
            return 50;
        }
    }else if (indexPath.section == 7) {
        return 120;
    }
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        QYZJRobOrderDetailCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJRobOrderDetailCell" forIndexPath:indexPath];
        cell.clipsToBounds = YES;
        cell.titelLB.text = @"小燕子";
        cell.gouTongBt.tag = indexPath.row;
        cell.type = 2;
        if (indexPath.row == 0) {
            cell.titelLB.hidden = NO;
            cell.listBtTopCos.constant = 50;
        }else {
            cell.titelLB.hidden = YES;
            cell.listBtTopCos.constant = 0;
        }
        Weak(weakSelf);
        cell.listBtActionBlock = ^(UIButton * _Nonnull button) {
            [weakSelf sitDemandActionwithButton:button];
        };
        cell.lineV.hidden = YES;
        return cell;
    }else if (indexPath.section == 1 || indexPath.section == 6) {
        
        //        if (indexPath.section == 6 && indexPath.row == 9) {
        //            TongYongFourCell* cell =[tableView dequeueReusableCellWithIdentifier:@"TongYongFourCell" forIndexPath:indexPath];
        //            cell.leftLB.text = self.leftTitleArr[indexPath.row];
        //            cell.rightLB.text = self.dataModel.demand_context;
        //            cell.rightLB.textColor = CharacterColor80;
        //            cell.leftLB.textColor = CharacterBlack112;
        //            cell.clipsToBounds = YES;
        //            cell.lineV.hidden = NO;
        //            return cell;
        //        }else
        
        if (indexPath.section == 1 && indexPath.row == 9) {
            
            QYZJRobOrderDetailCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJRobOrderDetailCell" forIndexPath:indexPath];
            cell.clipsToBounds = YES;
            cell.titelLB.text = self.dataModel.demand_context;
            cell.titelLB.textColor = CharacterColor80;
            cell.leftLB.text = @"需求描述";
            cell.gouTongBt.tag = indexPath.row;
            cell.type = 1;
            cell.titelLB.hidden = cell.leftLB.hidden = NO;
            
            cell.leftCons.constant = 100;

            cell.model = self.dataModel;
            cell.lineV.hidden = NO;
            return cell;
            
        }
        
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
            if (indexPath.row == 10 ) {
                if (self.dataModel.virtual_num_expire == NO  || self.isRel) {
                    cell.moreImgV.hidden = NO;
                    cell.moreImgV.image =[UIImage imageNamed:@"tel"];
                }else {
                     cell.moreImgV.hidden = YES;
                    NSString * str = [NSString stringWithFormat:@"%@%@",self.dataModel.real_tel,@"号码已过期,点击重新获取"];
                    cell.TF.attributedText = [str getMutableAttributeStringWithFont:13 lineSpace:0 textColor:CharacterColor80 textColorTwo:[UIColor greenColor] nsrange:NSMakeRange(str.length - 12, 12)];
                }
            }
        }else {
            if (indexPath.row == 0) {
                cell.leftLB.text = @"签单金额";
                cell.TF.text = [NSString stringWithFormat:@"￥%0.2f",self.dataModel.sign_money];
            }else {
                cell.leftLB.text = @"佣金额";
                cell.TF.text = [NSString stringWithFormat:@"￥%0.2f",self.dataModel.commission_price];
            }
            
        }
        cell.lineV.hidden = NO;
        cell.clipsToBounds = YES;
        return cell;
    }else if (indexPath.section < 7){
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
    }else {
        QYZJOtherCell* cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJOtherCell" forIndexPath:indexPath];
        cell.content.text = self.dataModel.other[indexPath.row].feedback_reply;
        return cell;
    }
}
//旁听单子可无语音
- (void)sitDemandActionwithButton:(UIButton *)button {
    
    QYZJRobOrderDetailCell * cell = (QYZJRobOrderDetailCell *)button.superview.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QYZJWorkModel * model = self.dataModel.media_url[indexPath.row];
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"demand_id"] = self.ID;
    dict[@"media_id"] = model.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_sitDemandURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([responseObject[@"key"] intValue]== 1) {
            if ([[NSString stringWithFormat:@"%@",responseObject[@"result"][@"is_pay"]] isEqualToString:@"0"]) {
                //已经支付
                [button setTitle:@"播放中..." forState:UIControlStateNormal];
                [[PublicFuntionTool shareTool] palyMp3WithNSSting:[QYZJURLDefineTool getVideoURLWithStr:model.mediaUrl] isLocality:NO];
                [PublicFuntionTool shareTool].findPlayBlock = ^{
                    [button setTitle:@"与客服沟通语音" forState:UIControlStateNormal];
                };
            }else {
                QYZJTongYongModel * mm = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
                mm.ID = model.ID;
                QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.type = 3;
                vc.ID = model.demandId;
                vc.model = mm;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 10) {
        
        if (self.dataModel.virtual_num_expire == NO || self.isRel) {
            
            
            [self callPhone];
            
        }else {
            
            
            [SVProgressHUD show];
            NSMutableDictionary * dict = @{}.mutableCopy;
            dict[@"id"] = self.ID;
            [zkRequestTool networkingPOST:[QYZJURLDefineTool app_bindVirtualPhoneURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
 
                [SVProgressHUD dismiss];
                if ([responseObject[@"key"] intValue]== 1) {
                    
                    self.dataModel.real_tel = responseObject[@"result"][@"virtual_num"];
                    self.dataModel.virtual_num_expire = NO;
                    [self.tableView reloadData];
                    
                }else {
                    [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                
            }];
            
        }
        
        
        
        
        
        
        
        
    }
    
}


- (void)callPhone {
    
    if (self.isRel) {
        
        
        UIAlertController  * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"是否拨打%@",self.dataModel.real_tel] preferredStyle:(UIAlertControllerStyleAlert)];
                      UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                          
                      }];
                      UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                          
                          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.dataModel.real_tel]]];
                          
                      }];
                      
                      [alertVC addAction:action1];
                      [alertVC addAction:action2];
                      
                      [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        
    }else {
       
        UIAlertController  * alertVC11 = [UIAlertController alertControllerWithTitle:@"提示" message:@"为保护用户隐私安全,您正在拨打的号码为虚拟号码,将于30分钟后失效" preferredStyle:(UIAlertControllerStyleAlert)];
           UIAlertAction * action22 = [UIAlertAction actionWithTitle:@"继续拨打" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
               
               UIAlertController  * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"是否拨打%@",self.dataModel.real_tel] preferredStyle:(UIAlertControllerStyleAlert)];
               UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                   
               }];
               UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                   
                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.dataModel.real_tel]]];
                   
               }];
               
               [alertVC addAction:action1];
               [alertVC addAction:action2];
               
               [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
               
               
           }];
           
           
           UIAlertAction * action11 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
               
           }];
           
           [alertVC11 addAction:action11];
           [alertVC11 addAction:action22];
           
           [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC11 animated:YES completion:nil];
        
    }
    
   
    
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
        } else if (row == 3) {
            if (self.dataModel.manner >0 && [zkSignleTool shareTool].mannerArr.count > 0) {
                cell.TF.text = [zkSignleTool shareTool].mannerArr[self.dataModel.manner-1];
            }
        }else if (row == 4) {
            if (self.dataModel.house_model >0 && [zkSignleTool shareTool].houseModelArr.count >= self.dataModel.house_model) {
                cell.TF.text = [zkSignleTool shareTool].houseModelArr[self.dataModel.house_model-1];
            }
        }else if (row == 5) {
            if (self.dataModel.renovation_time >0 && [zkSignleTool shareTool].renvoationTimeArr.count >= self.dataModel.renovation_time) {
                cell.TF.text = [zkSignleTool shareTool].renvoationTimeArr[self.dataModel.renovation_time-1];
            }
        }else if (row == 6) {
            cell.TF.text = self.dataModel.type_name.length > 0 ? self.dataModel.type_name:@"未填写";
        }else if (row == 7) {
            cell.TF.text = self.dataModel.budget > 0 ? [NSString stringWithFormat:@"%0.2f元",self.dataModel.budget]:@"未填写";
        }else if (row == 8) {
            cell.TF.text = self.dataModel.area.length > 0 ? [NSString stringWithFormat:@"%@m²",self.dataModel.area]:@"未填写";
        }else if (row == 9) {
            cell.TF.text = self.dataModel.demand_context.length > 0 ? self.dataModel.demand_context:@"未填写";
        }else if (row == 10) {
            cell.TF.text = self.dataModel.real_tel.length > 0 ? self.dataModel.real_tel:@"未填写";
        }else if (row == 11) {
            cell.TF.text = self.dataModel.reason.length > 0 ? self.dataModel.reason:@"未填写";
        }else if (row == 12) {
            cell.TF.text = self.dataModel.feedback_reply.length > 0 ? self.dataModel.feedback_reply:@"未回复";
        }else if (row == 13) {
            if ([self.dataModel.appeal_status integerValue] ==1) {
                cell.TF.text = @"申诉成功";
            }else if ([self.dataModel.appeal_status integerValue] ==2){
                cell.TF.text = @"申诉失败";
            }else {
                cell.TF.text = @"申诉中";
            }
        }else if (row == 14) {
            cell.TF.text = self.dataModel.appeal_reason.length > 0 ? self.dataModel.appeal_reason:@"未填写";
        }else if (row == 15) {
            cell.TF.text = self.dataModel.appeal_plateReason.length > 0 ? self.dataModel.appeal_plateReason:@"未填写";
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
        if (self.dataModel.demand_voice.length > 0) {
            hh = 85;
        }
    }else if (row == 10) {
        hh = self.dataModel.real_tel.length > 0 ? 50:0;
        hh = 50;
        
    }else if (row == 11) {
        //客服回复
        hh = self.dataModel.reason.length > 0 ? 50:0;
        
    }else if (row == 12) {
        //客服回复
        hh = self.dataModel.feedback_reply.length > 0 ? 50:0;
        
    }else if (row == 14 || row == 13 ){
        //申述状态
        if (self.dataModel.appeal_status.length == 0) {
            hh = 0;
        }else {
            hh = 50;
        }
        
    }else if (row == 15){
        
        hh = self.dataModel.appeal_plateReason.length > 0 ? 50:0;
    }
    return hh;
}



@end
