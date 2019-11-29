//
//  QYZJShopDetailTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJShopDetailTVC.h"
#import "QYZJShopDetailHeadView.h"
@interface QYZJShopDetailTVC ()
@property(nonatomic,strong)QYZJShopDetailHeadView *headV;
@property(nonatomic,strong)QYZJFindModel *dataModel;
@end

@implementation QYZJShopDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    
      self.headV = [[QYZJShopDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 20)];
      [self getData];
    if (!self.isMine) {
        
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
        if (sstatusHeight > 20) {
            self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
        }
        KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"购买" andImgaeName:@""];
        Weak(weakSelf);
        view.footViewClickBlock = ^(UIButton *button) {
            
            
            
        };
        [self.view addSubview:view];
        
    }

    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_goodsInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.dataModel = [QYZJFindModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.headV.dataModel = self.dataModel;
            self.headV.mj_h = self.headV.headHeight;
            self.tableView.tableHeaderView = self.headV;
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}




@end
