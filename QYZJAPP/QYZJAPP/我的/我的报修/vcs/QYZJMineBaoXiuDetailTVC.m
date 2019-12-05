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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineBaoXiuCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"QYZJMineBaoXiuCellTableViewCell"];
    
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
    
}


- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
       dict[@"page"] = @(self.page);
       dict[@"pageSize"] = @(10);
    dict[@"id"] = self.model.ID;;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_repairBroadcastListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
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
    }else {
        return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
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
        view.backgroundColor = RGB(245, 245, 245);
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
    if (self.model.isService) {
        view.rightBt.hidden = NO;
    }
    [view.rightBt setTitleColor:OrangeColor forState:UIControlStateNormal];
    [view.rightBt addTarget:self action:@selector(addBoBao) forControlEvents:UIControlEventTouchUpInside];
    [view.rightBt setTitle:@"创建播报" forState:UIControlStateNormal];
    [view.rightBt setImage:[UIImage imageNamed:@"18"] forState:UIControlStateNormal];
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
    vc.ID = self.model.ID;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section ==0) {
        return 1;
    }
    return self.dataArray.count;
    
//    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120;
    }
    return self.dataArray[indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        QYZJMineBaoXiuCellTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineBaoXiuCellTableViewCell" forIndexPath:indexPath];
        cell.model = self.model;
        cell.contentTwoLB.hidden = NO;
        return cell;
    }
    
    QYZJBaoXiuDetailCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJBaoXiuDetailCell" forIndexPath:indexPath];
    cell.waiModel = self.dataArray[indexPath.row];
    cell.isServer = self.model.isService;
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
    NSString * url = [QYZJURLDefineTool user_repairBroadcastReplyURL];
    if (titleStr.length == 0) {
        url = [QYZJURLDefineTool user_repairBoradcastDelURL];
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



@end
