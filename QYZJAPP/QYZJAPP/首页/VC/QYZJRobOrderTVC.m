//
//  QYZJRobOrderTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJRobOrderTVC.h"
#import "QYZJQianDanNavigaTitleView.h"
#import "QYZJHomeFourCell.h"
#import "QYZJQianDanOneCell.h"
#import "QYZJRobOrderDetailTVC.h"
#import "QYZJJingXingZhongRobOrderTVC.h"
#import "QYZJRecommendTwoCell.h"
@interface QYZJRobOrderTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,assign)NSInteger type;
@end

@implementation QYZJRobOrderTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleView];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeFourCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeFourCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJQianDanOneCell" bundle:nil] forCellReuseIdentifier:@"QYZJQianDanOneCell"];
    
    [self.tableView registerClass:[QYZJRecommendTwoCell class] forCellReuseIdentifier:@"QYZJRecommendTwoCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.type = 0;
    
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

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"range_type"] = @"1";
    dict[@"type"] = @(self.type);
    dict[@"city_id"] = [zkSignleTool shareTool].cityId;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_demandListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<QYZJFindModel *>*arr = [QYZJFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            if (self.dataArray.count == 0) {
                [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
            }
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}

- (void)addTitleView {
    
    QYZJQianDanNavigaTitleView * view = [[QYZJQianDanNavigaTitleView alloc] initWithFrame:CGRectMake(0, 200, ScreenW - 160, 40)];
    Weak(weakSelf);
    view.navigaBlock = ^(NSInteger index) {
        weakSelf.type = index;
        weakSelf.page = 1;
        [weakSelf getData];
    };
    self.navigationItem.titleView = view;
    
    //    [self.view addSubview:view];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.dataArray.count;
    }
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = RGB(245, 245, 245);
    }
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110;
    }else if (indexPath.section == 1) {
        
        
        QYZJFindModel * model = self.dataArray[indexPath.row];;
        if (model.media_url.length > 0) {
            return 125+35;
        }else {
            return 125;
        }
    }
    
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        QYZJHomeFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFourCell" forIndexPath:indexPath];
        return cell;
    }else {
        QYZJQianDanOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJQianDanOneCell" forIndexPath:indexPath];
        cell.gouTongBt.userInteractionEnabled = NO;
        QYZJFindModel * model = self.dataArray[indexPath.row];
        cell.model = model;
        cell.qianDanBt.hidden = YES;
        cell.statusLB.hidden = NO;
        if (self.type == 0) {
            cell.qianDanBt.hidden = NO;
            cell.statusLB.hidden = YES;
        }else {
            cell.statusLB.hidden = NO;
            cell.qianDanBt.hidden = YES;
        }
        
       
        
        cell.qianDanBt.tag = indexPath.row;
        [cell.qianDanBt addTarget:self action:@selector(qianDanAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QYZJFindModel * model = self.dataArray[indexPath.row];
//    if (self.type == 0 && [model.status intValue]== 0) {
//        QYZJJingXingZhongRobOrderTVC * vc =[[QYZJJingXingZhongRobOrderTVC alloc] init];
//         vc.hidesBottomBarWhenPushed = YES;
//         vc.ID = self.dataArray[indexPath.row].ID;
//         [self.navigationController pushViewController:vc animated:YES];
//    }else {
//        QYZJRobOrderDetailTVC * vc =[[QYZJRobOrderDetailTVC alloc] init];
//         vc.hidesBottomBarWhenPushed = YES;
//         vc.ID = self.dataArray[indexPath.row].ID;
//         [self.navigationController pushViewController:vc animated:YES];
//    }
    
        QYZJRobOrderDetailTVC * vc =[[QYZJRobOrderDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = self.dataArray[indexPath.row].ID;
        [self.navigationController pushViewController:vc animated:YES];
    
    
}

//抢单操作
- (void)qianDanAction:(UIButton *)button {
    QYZJFindModel * model = self.dataArray[button.tag];
    
    if ([model.status intValue]== 0 || [model.status intValue]== 1) {
        
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"抢单提示" message:@"确定抢单吗?" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction * actionOne = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            [SVProgressHUD show];
              NSMutableDictionary * dict = @{}.mutableCopy;
              dict[@"id"] = model.ID;
              [zkRequestTool networkingPOST:[QYZJURLDefineTool user_grabDemandURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
              
                  [SVProgressHUD dismiss];
                  if ([responseObject[@"key"] intValue]== 1) {
                     
                      QYZJTongYongModel  * modelNei = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
                      if (modelNei.is_vip) {
                          [SVProgressHUD showSuccessWithStatus:@"抢单成功,请在一个小时内进行反馈,否则超时视为反馈有效并扣费"];
                      }else {
                          if (modelNei.status == 2) {
                              
                              QYZJTongYongModel * mm = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
                              QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
                             
                              vc.model = mm;
                              vc.type = 1;
                              vc.ID = model.ID;
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
    
    
}




@end
