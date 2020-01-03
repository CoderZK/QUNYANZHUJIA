//
//  QYZJJingXingZhongRobOrderTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/20.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJJingXingZhongRobOrderTVC.h"
#import "QYZJRobOrderDetailCell.h"
#import "QYZJPicShowCell.h"
#import "QYZJZhiFuVC.h"
@interface QYZJJingXingZhongRobOrderTVC ()
@property(nonatomic,strong)QYZJWorkModel *dataModel;
@property(nonatomic,strong)NSArray *headTitleArr;
@property(nonatomic,strong)NSArray *leftTitleArr;
@property(nonatomic,strong)NSString *reason;
@end

@implementation QYZJJingXingZhongRobOrderTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJRobOrderDetailCell" bundle:nil] forCellReuseIdentifier:@"QYZJRobOrderDetailCell"];
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"TongYongTwoCell"];
    [self.tableView registerClass:[TongYongFourCell class] forCellReuseIdentifier:@"TongYongFourCell"];
    [self.tableView registerClass:[QYZJPicShowCell class] forCellReuseIdentifier:@"QYZJPicShowCell"];
    self.leftTitleArr = @[@"订单号",@"地址",@"小区名称",@"风格",@"户型",@"装修时间",@"需求类型",@"预算",@"建筑面积",@"需求描述"];
    

    
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
}

// 0 抢单 1 反馈 2 签单 3 申诉 4 填写资料
- (void)setFootVWithStatus:(NSInteger)status {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    KKKKFootView * view2 = (KKKKFootView *)[self.view viewWithTag:666];
    if (view2 != nil) {
        [view2 removeFromSuperview];
    }
    
    if (status == 0 || status == 3 || status ==4) {
        NSString * str = @"";
        if (status == 0) {
            str = @"抢单";
        }else if (status == 3) {
            str = @"申诉";
        }else if (status == 4) {
            str = @"填写资料";
        }
        KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:str andImgaeName:@""];
        view.tag = 666;
        Weak(weakSelf);
        view.footViewClickBlock = ^(UIButton *button) {
            
        };
        [self.view addSubview:view];
    }else if (status==1 || status == 2) {
        NSString * leftStr = @"反馈无效";
        NSString * rightStr = @"反馈有效";
        
        KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvTwoWithLeftTitle:leftStr letfTietelColor:OrangeColor rightTitle:rightStr rightColor:WhiteColor];
        view.tag = 666;
        Weak(weakSelf);
        view.footViewClickBlock = ^(UIButton *button) {
           
        };
        
    }
    
    
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
                 
                  [self setFootVWithStatus:1];
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
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_operateDemandURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
     
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            
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
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_demandInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataModel = [QYZJWorkModel mj_objectWithKeyValues:responseObject[@"result"]];
            [self.tableView reloadData];
            [self setFootVWithStatus:[self.dataModel.status intValue]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}





- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section ==1) {
        return 0.01;
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
    view.backgroundColor = WhiteColor;
    view.contentView.backgroundColor = WhiteColor;
    view.clipsToBounds = YES;
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataModel.media_url.count;
    }else  {
        return 10;
    }
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
         if (indexPath.row ==0) {
                 return 85;
               }
               return 35;
    }else {
        if (indexPath.row == 9) {
            return UITableViewAutomaticDimension;
        }
        return  [self cellHeightWithIndexPath:indexPath];
    }
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
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }else  {
        if (indexPath.row <9) {
            TongYongTwoCell* cell =[tableView dequeueReusableCellWithIdentifier:@"TongYongTwoCell" forIndexPath:indexPath];
            cell.moreImgV.hidden = YES;
            cell.TF.placeholder = @"";
            cell.TF.userInteractionEnabled = NO;
            cell.TF.textColor = CharacterColor80;
            cell.leftLB.textColor = CharacterBlack112;
            cell.moreImgV.image = [UIImage imageNamed:@"phone"];
            cell.leftLB.text = self.leftTitleArr[indexPath.row];
            [self setTitleWithCell:cell WithIndexPath:indexPath];
            cell.clipsToBounds = YES;
            return cell;
        }else {
            TongYongFourCell* cell =[tableView dequeueReusableCellWithIdentifier:@"TongYongFourCell" forIndexPath:indexPath];
            cell.leftLB.text = self.leftTitleArr[indexPath.row];
            cell.rightLB.text = self.dataModel.demand_context;
            cell.rightLB.textColor = CharacterColor80;
            cell.leftLB.textColor = CharacterBlack112;
            cell.clipsToBounds = YES;
            return cell;
        }
        
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
            if (self.dataModel.manner >0 && [zkSignleTool shareTool].mannerArr.count > 0) {
                cell.TF.text = [zkSignleTool shareTool].mannerArr[self.dataModel.manner-1];
            }
        }else if (row == 4) {
           if (self.dataModel.house_model >0 && [zkSignleTool shareTool].houseModelArr.count >=self.dataModel.house_model) {
                cell.TF.text = [zkSignleTool shareTool].houseModelArr[self.dataModel.house_model-1];
            }
        }else if (row == 5) {
            if (self.dataModel.renovation_time >0 && [zkSignleTool shareTool].renvoationTimeArr.count > 0) {
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
            cell.TF.text = self.dataModel.feedback_reply.length > 0 ? self.dataModel.feedback_reply:@"未填写";
        }else if (row == 13) {
            if ([self.dataModel.appeal_status intValue]== 1) {
                cell.TF.text = @"申诉成功";
            }else if ([self.dataModel.appeal_status intValue]== 2){
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
        hh = self.dataModel.budget> 0 ? 50:0;
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
                QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.type = 4;
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



@end
