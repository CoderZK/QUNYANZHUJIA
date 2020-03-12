//
//  QYZJMineBaoXiuDetailTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineBaoXiuDetailTVC.h"
#import "QYZJMineBaoXiuCellTableViewCell.h"
#import "QYZJBaoXiuDetailCell.h"
#import "QYZJAddWorkMomentTVC.h"
#import "QYZJPingLunShowView.h"
#import "QYZJBaoBoOrQingDanOneCell.h"
#import "QYZJQIngDanPingJiaCell.h"
#import "QYZJQingDanPingJiaVC.h"
#import "QYZJMineBaoXiuListTVC.h"
@interface QYZJMineBaoXiuDetailTVC ()
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)QYZJPingLunShowView *showView;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end

@implementation QYZJMineBaoXiuDetailTVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.page = 1;
    [self getData];
    [self getDataDetail];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineBaoXiuCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"QYZJMineBaoXiuCellTableViewCell"];
    [self.tableView registerClass:[QYZJBaoBoOrQingDanOneCell class] forCellReuseIdentifier:@"QYZJBaoBoOrQingDanOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJQIngDanPingJiaCell" bundle:nil] forCellReuseIdentifier:@"QYZJQIngDanPingJiaCell"];
    [self.tableView registerClass:[QYZJBaoXiuDetailCell class] forCellReuseIdentifier:@"QYZJBaoXiuDetailCell"];
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
        
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getData];
        
    }];
    
    
    self.showView = [[QYZJPingLunShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    Weak(weakSelf);
    self.showView.sendPingLunBlock = ^(NSString * _Nonnull message) {
        [weakSelf delectOrPingAction:message];
        
        
        
    };
    
        
    
    [self setFootVWithStatus:[self.model.status intValue]];
    
}

//验收状态（服务方:1为待发起验收、2为待验收、3为待整改、4为验收通过、5为整改中、6为整改完成；1为施工中、2为验收中、3为整改中、4为已验收、5为整改中、6为整改完成）
- (void)setFootVWithStatus:(NSInteger)status {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60 - sstatusHeight - 44);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34 - sstatusHeight - 44);
    }
    
    KKKKFootView * view2 = (KKKKFootView *)[self.view viewWithTag:666];
    if (view2 != nil) {
        [view2 removeFromSuperview];
    }
    BOOL isLayer = NO;
    static NSString * str = @"";
    if (self.type == 1) {
        if (self.model.is_service) {
            //用户
            if (self.staus == 8) {
                if (self.model.isRepair) {
                    str = @"查看报修";
                    isLayer = YES;
                }else {
                    
                    str = @"报修";
                    isLayer = YES;
                    if (self.isNoShow) {
                        isLayer = NO;
                    }
                }
            }else {
                if (status == 2){
                    str = @"验收此阶段";
                    isLayer = YES;
                }else if (status == 7){
                    str = @"评价";
                    isLayer = YES;
                }
            }
            
            
        }else {
            //服务方
            if (status == 1) {
                str = @"提交阶段验收";
                isLayer = YES;
            }else if (status == 3) {
                isLayer = YES;
                str= @"立即整改";
            }
        }
    }else {
        if (self.model.isService) {
            //服务方
            if(status == 1) {
                isLayer = YES;
                str= @"确认报修";
            }else if (status == 2) {
                isLayer = YES;
                str= @"提交验收";
            }else if (status == 5) {
                isLayer = YES;
                str= @"立即整改";
            }
            
        }else {
            if (status == 3) {
                isLayer = YES;
                str= @"验收";
            }
        }
        
        
    }
    if (!isLayer) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 44);
        return;
        
    }
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:str andImgaeName:@""];
    view.tag = 666;
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton *button) {
        
        [weakSelf clickBottomAction:status];
        
    };
    [self.view addSubview:view];
    
}

//点击事件
- (void)clickBottomAction:(NSInteger)status {
    
    
    if (self.type == 1) {
        //清单过来
        if (self.model.is_service) {
            //客户
            if (status == 2) {
                
                [self showYanshouView];
                
            }else if (status == 4 || status == 6) {
                if (self.model.isRepair ) {
                    QYZJMineBaoXiuListTVC * vc =[[QYZJMineBaoXiuListTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else {
                    QYZJAddWorkMomentTVC * vc =[[QYZJAddWorkMomentTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.type = 6;
                    vc.ID = self.model.ID;
                    vc.constructionStageId = self.model.constructionStageId;
                    vc.IDTwo = self.model.turnoverListId;
                    vc.IDThree = self.model.selfId;
                    vc.changeType =  [self.model.type intValue];
                    [self.navigationController pushViewController:vc animated:YES];
                    return;
                }
            }else if (status == 7){
                QYZJQingDanPingJiaVC * vc =[[QYZJQingDanPingJiaVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.ID = self.model.ID;
                
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
            
            
        }else {
            //服务方
            if (status == 1) {
                [self yanShouOrTiaoJiaoWithUrl:[QYZJURLDefineTool user_turnoverStageConfirmURL] andID:self.model.ID isYanShou:NO];
            }else if (status == 3) {
                QYZJAddWorkMomentTVC * vc =[[QYZJAddWorkMomentTVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.type = 7;
                vc.ID = self.model.ID;
                vc.IDThree = self.model.selfId;
                vc.IDTwo = self.model.turnoverListId;
                vc.constructionStageId = self.model.constructionStageId;
                vc.changeType = [self.model.type intValue];
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
            
            
        }

    }else {
        //报修过来
        if (self.model.isService) {
            //服务方
            if(status == 1) {
                //"确认保修";
                  [self baoXiuConfirmAction:1];
            }else if (status == 2) {
                // @"提交验收";
                [self yanShouOrTiaoJiaoWithUrl:[QYZJURLDefineTool user_turnoverRepairConfirmURL] andID:self.model.ID isYanShou:NO];
            }else if (status == 5) {
                // @"立即整改";
                QYZJAddWorkMomentTVC * vc =[[QYZJAddWorkMomentTVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.type = 6;
                vc.ID = self.model.ID;
                vc.IDThree = self.model.selfId;
                vc.IDTwo = self.model.turnoverListId;
                vc.constructionStageId = self.model.constructionStageId;
                vc.changeType = [self.model.type intValue];
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
            
        }else {
            if (status == 3) {
                [self showYanshouView];
            }
        }
        
    }
    
}

//服务方确认报修
- (void)confirmAction {
    
    UIAlertController  * alertVC = [UIAlertController alertControllerWithTitle:@"报修确认" message:@"请选择报修状态" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"不通过" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self baoXiuConfirmAction:1];
    }];
    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"通过" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self baoXiuConfirmAction:1];
    }];
    
    
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [alertVC addAction:action1];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}


//报修确认
- (void)baoXiuConfirmAction:(NSInteger)isSure {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.model.ID;
    dict[@"isSure"] = @(isSure);
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_sureRepairURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [self getDataDetail];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


//验收
- (void)showYanshouView {
    
    
    //验收
    UIAlertController  * alertVC = [UIAlertController alertControllerWithTitle:@"验收确认" message:@"请选择审核状态" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"不通过" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        if (self.type == 1) {
            
            [self yanShouOrTiaoJiaoWithUrl:[QYZJURLDefineTool user_turnoverStageNotPassURL] andID:self.model.ID isYanShou:YES];
        }else {
            [self yanShouOrTiaoJiaoWithUrl:[QYZJURLDefineTool user_turnoverRepairNotPassURL] andID:self.model.ID isYanShou:YES];
        }
        
        
        
    }];
    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"通过" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        if (self.type == 1) {
            [self yanShouOrTiaoJiaoWithUrl:[QYZJURLDefineTool user_turnoverStagePassURL] andID:self.model.ID isYanShou:YES];
        }else {
            [self yanShouOrTiaoJiaoWithUrl:[QYZJURLDefineTool user_turnoverRepairPassURL] andID:self.model.ID isYanShou:YES];
        }
        
        
        
    }];
    
    
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [alertVC addAction:action1];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    
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
                
                [self getDataDetail];
                
            }else {
                [SVProgressHUD showSuccessWithStatus:@"提交阶段验收成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self getDataDetail];
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



- (void)getDataDetail {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.model.ID;
    NSString * url = @"";
    if (self.type == 1) {
        url = [QYZJURLDefineTool user_turnoverListDetailsURL];
    }else{
        url = [QYZJURLDefineTool user_repairDetailsURL];
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            QYZJFindModel * mdoel = [QYZJFindModel mj_objectWithKeyValues:responseObject[@"result"][@"constructionStageList"]];
            self.model.year = mdoel.year;
            if (self.type != 1) {
                mdoel =[QYZJFindModel mj_objectWithKeyValues:responseObject[@"result"][@"repair"]];
            }
            self.model.status = mdoel.status;
//            self.model.constructionStageId = mdoel.constructionStageId;
            [self setFootVWithStatus:[self.model.status intValue]];
            [self.tableView reloadData];
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
    NSString * url = [QYZJURLDefineTool user_repairBroadcastListURL];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"id"] = self.model.ID;
    if (self.type == 1) {
        url = [QYZJURLDefineTool user_broadcastListURL];
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            NSArray<QYZJFindModel *>*arr = [QYZJFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            [self.tableView reloadData];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }else if (section == 1) {
        if (self.model.evaluateLevel > 0) {
            return 10;
        }else {
            return 0.01;
        }
    }  else {
        return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 0.01;
    }else {
        return 40;
    }
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    QYZJTongYongHeadFootView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (view == nil) {
        view = [[QYZJTongYongHeadFootView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 49.4, ScreenW, 0.6)];
        backV.backgroundColor = lineBackColor;
        [view addSubview:backV];
        
        
    }
    view.rightBt.hidden = YES;
    if ((self.type == 1 && !self.model.is_service) || self.model.isService) {
        view.rightBt.hidden = NO;
    }else {
        view.rightBt.hidden = YES;
    }
    
    [view.rightBt setTitleColor:OrangeColor forState:UIControlStateNormal];
    [view.rightBt addTarget:self action:@selector(addBoBao) forControlEvents:UIControlEventTouchUpInside];
    [view.rightBt setTitle:@"创建播报" forState:UIControlStateNormal];
    [view.rightBt setImage:[UIImage imageNamed:@"35"] forState:UIControlStateNormal];
    [view.rightBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [view.rightBt setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    view.leftLB.text = @"播报";
    view.backgroundColor = WhiteColor;
    view.contentView.backgroundColor = WhiteColor;
    view.clipsToBounds = YES;
    return view;
}

- (void)addBoBao {
    
    
    
    QYZJAddWorkMomentTVC * vc =[[QYZJAddWorkMomentTVC alloc] init];
    vc.type = 2;
    if (self.type == 1) {
        vc.type = 5;
    }
    vc.ID = self.model.ID;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section ==0) {
        return 1;
    }else if (section == 1) {
        if (self.model.evaluateLevel >0) {
            return 1;
        }else {
            return 0;
        }
    }
    return self.dataArray.count;
    
    //    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.model.cellHeight;
    }else if (indexPath.section == 1){
        return UITableViewAutomaticDimension;
    }
    return self.dataArray[indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        QYZJBaoBoOrQingDanOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJBaoBoOrQingDanOneCell" forIndexPath:indexPath];
        cell.type = self.type;
        cell.model = self.model;
        return cell;
    }else if (indexPath.section == 1) {
        
        QYZJQIngDanPingJiaCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJQIngDanPingJiaCell" forIndexPath:indexPath];
        cell.model = self.model;
        return cell;
    }
    
    QYZJBaoXiuDetailCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJBaoXiuDetailCell" forIndexPath:indexPath];
    if (self.type == 1) {
        cell.isServer = !self.model.is_service;
    }else {
        cell.isServer = self.model.isService;
    }
    
    cell.waiModel = self.dataArray[indexPath.row];
    [cell.fuHuiBt addTarget:self action:@selector(fuhuiAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteBt addTarget:self action:@selector(delectAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (void)fuhuiAction:(UIButton *)button {
    
    QYZJBaoXiuDetailCell * cell = (QYZJBaoXiuDetailCell *)button.superview.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    [self.showView show];
    self.indexPath = indexPath;
    
}

- (void)delectAction:(UIButton *)button {
    QYZJBaoXiuDetailCell * cell = (QYZJBaoXiuDetailCell *)button.superview.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    self.indexPath = indexPath;
    [self delectOrPingAction:@""];
    
}


- (void)delectOrPingAction:(NSString *)titleStr {
    
    [SVProgressHUD show];
    NSString * url = @"";
    
    if (titleStr.length == 0) {
        //删除
        url = [QYZJURLDefineTool user_repairBoradcastDelURL];
        if (self.type == 1) {
            url = [QYZJURLDefineTool user_boradcastDelURL];
        }
    }else {
        //回复
        url = [QYZJURLDefineTool user_repairBroadcastReplyURL];
        if(self.type == 1) {
            url = [QYZJURLDefineTool user_broadcastReplyURL];
        }
        
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.dataArray[self.indexPath.row].ID;
    dict[@"content"] = titleStr;
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            if (titleStr.length > 0) {
                //回复播报
                self.page = 1;
                [self getData];
                [self.showView diss];
                
            }else {
                //删除播报
                [self.dataArray removeObjectAtIndex:self.indexPath.row];
                [self.tableView reloadData];
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
    
}

@end
