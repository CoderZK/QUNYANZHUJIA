//
//  QYZJAppShopTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJAppShopTVC.h"
#import "QYZJMineShopHeadView.h"
#import "QYZJMineShopCell.h"
#import "QYZJShopDetailTVC.h"
@interface QYZJAppShopTVC ()<QYZJMineShopCellDelegate>
@property(nonatomic,strong)QYZJMineShopHeadView *headV;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@end

@implementation QYZJAppShopTVC
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH + sstatusHeight);
    self.headV = [[QYZJMineShopHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150+sstatusHeight)];
    self.headV.clipsToBounds = YES;
    self.headV.editBt.hidden = self.headV.shareBt.hidden = YES;
    Weak(weakSelf);
    self.headV.clickShopHeadBlock = ^(NSInteger index) {
        
        if (index == 0) {
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else if (index == 1) {
            //分享
            
        }else if (index == 2) {
            //头像
            
        }
        
    };
    self.tableView.tableHeaderView = self.headV;
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineShopCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataArray = @[].mutableCopy;;
    
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.shopId;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_shopInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [self.headV.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:responseObject[@"result"][@"pic"]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
            self.headV.titelLB.text = responseObject[@"result"][@"name"];
            self.dataArray  = [QYZJFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"goods_list"]];
            [self.tableView reloadData];
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
    return self.dataArray.count / 2 + self.dataArray.count % 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat hh = (ScreenW - 30) / 2 * 3 / 4;
    return hh + 40 + 20 + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMineShopCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.isShenHe = YES;;
    if (indexPath.row * 2 + 2 <= self.dataArray.count) {
        cell.dataArray = [self.dataArray subarrayWithRange:NSMakeRange(indexPath.row * 2 , 2)];
    }else {
        cell.dataArray = [self.dataArray subarrayWithRange:NSMakeRange(indexPath.row * 2 , 1)];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark ----- 点击 ----
- (void)didClickQYZJMineShopCell:(QYZJMineShopCell*)cell index:(NSInteger)index isEdit:(BOOL)isEdit
{
        NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        QYZJFindModel * model = self.dataArray[indexPath.row * 2+index];
        QYZJShopDetailTVC * vc =[[QYZJShopDetailTVC alloc] init];
        vc.ID = model.ID;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];    
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
