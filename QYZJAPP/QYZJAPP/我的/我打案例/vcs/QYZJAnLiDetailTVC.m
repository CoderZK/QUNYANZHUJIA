//
//  QYZJAnLiDetailTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJAnLiDetailTVC.h"
#import "QYZJAnLiDetailHeadView.h"
#import "QYZJAddWorkMomentTVC.h"
@interface QYZJAnLiDetailTVC ()
@property(nonatomic,strong)QYZJAnLiDetailHeadView *headV;
@property(nonatomic,strong)QYZJFindModel *dataModel;
@end

@implementation QYZJAnLiDetailTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"案例详情";

    self.headV = [[QYZJAnLiDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 20)];
       self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           [self getData];
       }];
    
    [self setFootV];
    
}

- (void)setFootV {
    
     self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
       if (sstatusHeight > 20) {
           self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
       }
    KKKKFootView * view =  [[PublicFuntionTool shareTool] createFootvTwoWithLeftTitle:@"编辑" letfTietelColor:OrangeColor rightTitle:@"删除" rightColor:WhiteColor];
    view.footViewClickBlock = ^(UIButton *button) {
              NSLog(@"\n\n%@",@"编辑或者完成");
         if (button.tag == 0) {
             
             QYZJAddWorkMomentTVC * vc =[[QYZJAddWorkMomentTVC alloc] init];
             vc.type = 1;
             vc.titleStr = self.dataModel.title;
             vc.contentStr = self.dataModel.context;
             vc.ID = self.ID;
             vc.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:vc animated:YES];
         }else {
             
             [self delectAnLi];
             
         }
         
         
    };
    [self.view addSubview:view];
    
}

- (void)delectAnLi {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_deleteCaseURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"删除案例成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       
        
    }];
    
}


- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_caseInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.dataModel = [QYZJFindModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.headV.dataModel = self.dataModel;
            self.headV.mj_h = self.headV.headHeight;
            self.tableView.tableHeaderView = self.headV;
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}




@end
