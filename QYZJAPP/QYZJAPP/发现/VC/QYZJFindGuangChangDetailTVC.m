//
//  QYZJFindGuangChangDetailTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFindGuangChangDetailTVC.h"
#import "QYZJFindGuangChangDetailView.h"
@interface QYZJFindGuangChangDetailTVC ()
@property(nonatomic,strong)QYZJFindModel *dataModel;
@property(nonatomic,strong)QYZJFindGuangChangDetailView *headV;
@end

@implementation QYZJFindGuangChangDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [self getData];
    
}

- (QYZJFindGuangChangDetailView *)headV {
    if (_headV == nil) {
        _headV = [[QYZJFindGuangChangDetailView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.01)];
        _headV.clipsToBounds = YES;
        
    }
    return _headV;
}


- (void)getData {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"id"] = self.ID;
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_articleDetailsURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            self.dataModel = [QYZJFindModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.headV.model = self.dataModel;
            self.headV.mj_h = self.headV.headHeight;
            self.tableView.tableHeaderView = self.headV;
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}


@end
