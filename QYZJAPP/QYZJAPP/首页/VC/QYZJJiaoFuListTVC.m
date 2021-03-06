//
//  QYZJJiaoFuListTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/25.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJJiaoFuListTVC.h"
#import "QYZJJiaoFuListCell.h"
#import "QYZJCreateShiGongQingDanTVC.h"
#import "QYZJCreateNewJiaoFuTVC.h"
@interface QYZJJiaoFuListTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@end

@implementation QYZJJiaoFuListTVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.page = 1;
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发起交付";
    
    [self setFootV];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJJiaoFuListCell" bundle:nil] forCellReuseIdentifier:@"cell"];

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
    
}


- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"range_type"] = @"1";
    dict[@"type"] = @(1);
    dict[@"status"] = @(8);
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
            
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}


- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    self.tableView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"去交付" andImgaeName:@""];
    [self.view addSubview:view];
    KKKKFootView * viewHead = [[PublicFuntionTool shareTool] createFootvWithTitle:@"创建新交付" andImgaeName:@"jia"];
    viewHead.layer.shadowOpacity = 0;
    viewHead.layer.shadowColor = [UIColor clearColor].CGColor;
    viewHead.mj_y = 0;
    viewHead.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:viewHead];
    
     Weak(weakSelf);

    view.footViewClickBlock = ^(UIButton * _Nonnull button) {
           QYZJFindModel * model = nil;
            for (int i = 0 ;i <self.dataArray.count ; i++) {
                if (self.dataArray[i].isSelect) {
                    model = self.dataArray[i];
                    break;
                }
            }
//          QYZJCreateShiGongQingDanTVC * vc =[[QYZJCreateShiGongQingDanTVC alloc] init];
//          vc.hidesBottomBarWhenPushed = YES;
//          vc.ID = model.demand_grab_sheet_id;
//          [weakSelf.navigationController pushViewController:vc animated:YES];
        
        [weakSelf jiaoFuActionWithdemand_grab_sheet_id: model.demand_grab_sheet_id];
        
    };
    
    viewHead.footViewClickBlock = ^(UIButton * _Nonnull button) {
        //创建新的交付
        QYZJCreateNewJiaoFuTVC * vc =[[QYZJCreateNewJiaoFuTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
       
    };
    
    
///
    
    
}


//交付中

- (void)jiaoFuActionWithdemand_grab_sheet_id:(NSString *)demand_grab_sheet_id {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"demand_grab_sheet_id"] = demand_grab_sheet_id;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_createTurnoverURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            QYZJCreateShiGongQingDanTVC * vc =[[QYZJCreateShiGongQingDanTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = responseObject[@"result"][@"turnover_id"];
//            vc.IDTwo = self.ID;
//            vc.isRob = YES;
            [self.navigationController pushViewController:vc animated:YES];
        
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJJiaoFuListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.dataArray[indexPath.row].isSelect = !self.dataArray[indexPath.row].isSelect;
    for (int i = 0 ; i < self.dataArray.count; i++) {
        if (i != indexPath.row) {
            self.dataArray[indexPath.row].isSelect = NO;
        }
    }
    [self.tableView reloadData];
}

@end
