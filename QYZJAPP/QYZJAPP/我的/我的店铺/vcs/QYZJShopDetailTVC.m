//
//  QYZJShopDetailTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJShopDetailTVC.h"
#import "QYZJShopDetailHeadView.h"
#import "QYZJBuyOrderDetailTVC.h"
@interface QYZJShopDetailTVC ()
@property(nonatomic,strong)QYZJShopDetailHeadView *headV;
@property(nonatomic,strong)QYZJFindModel *dataModel;
@property(nonatomic,strong)UIButton * shareBt;
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
            
             if([zkSignleTool shareTool].role == 1) {
                [SVProgressHUD showErrorWithStatus:@"您已经是服务方,不能购买其他服务方商品"];
                return ;
            }
            
            QYZJBuyOrderDetailTVC * vc =[[QYZJBuyOrderDetailTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            self.dataModel.ID = self.ID;
            vc.dataModel = self.dataModel;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [self.view addSubview:view];
        
    }
    self.shareBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 50, sstatusHeight + 2, 40, 40)];
    self.shareBt.tag = 1;
    [self.shareBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareBt setImage:[UIImage imageNamed:@"34"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareBt];
 
}

//点击分享
- (void)clickAction:(UIButton *)button {
    
    NSString * str = nil;
    if (self.dataModel.pic.length > 0) {
        str = [[self.dataModel.pic componentsSeparatedByString:@","] firstObject];
    }
    [self shareWithSetPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)] withUrl:[NSString stringWithFormat:@"http://mobile.qunyanzhujia.com/goodsDetail?id=%@&other=true",self.ID] shareModel:str withContentStr:self.dataModel.context andTitle:@""];
    
    
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
