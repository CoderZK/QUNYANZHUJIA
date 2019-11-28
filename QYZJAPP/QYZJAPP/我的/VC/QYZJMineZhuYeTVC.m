//
//  QYZJMineZhuYeTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/22.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineZhuYeTVC.h"
#import "QYZJMineAnLiTVC.h"
#import "QYZJMineShopTVC.h"
#import "QYZJZhuYeYuYinCell.h"
#import "QYZJMineShopCell.h"
#import "QYZJMineAnLiCell.h"
#import "QYZJMineZhuYeHeadVIew.h"
@interface QYZJMineZhuYeTVC ()
@property(nonatomic,strong)QYZJUserModel * dataModel;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,strong)NSArray *leftArr;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)QYZJMineZhuYeHeadVIew *headV;
@end

@implementation QYZJMineZhuYeTVC
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //    self.navigationController.navigationBar.hidden = YES;;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH + sstatusHeight - 60);
    if (sstatusHeight > 20) {
       self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH + sstatusHeight - 60 - 34);
    }

    self.headV = [[QYZJMineZhuYeHeadVIew alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    Weak(weakSelf);
    self.headV.clickZhuYeHeadBlock = ^(NSInteger index ,UIButton *button) {
       if (index == 0) {
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else if (index == 1) {
            //分享
            
        }else if (index == 2) {
            //头像
            
        }else if (index == 3) {
            //关注
            
        }
    };

    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineShopCell" bundle:nil] forCellReuseIdentifier:@"QYZJMineShopCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJZhuYeYuYinCell" bundle:nil] forCellReuseIdentifier:@"QYZJZhuYeYuYinCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineAnLiCell" bundle:nil] forCellReuseIdentifier:@"QYZJMineAnLiCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    [self getData];
    [self getDataTwo];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getDataTwo];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getDataTwo];
    }];
    
    self.leftArr = @[@"案例",@"小店",@"回答的所有语音"];
    
    KKKKFootView * view =  [[PublicFuntionTool shareTool] createFootvTwoWithLeftTitle:@"1元预约" letfTietelColor:OrangeColor rightTitle:@"1元提问" rightColor:WhiteColor];
    view.mj_y = ScreenH  - 60;
    if (sstatusHeight>20){
        view.mj_y = ScreenH  - 60 - 34;
    }
     view.footViewClickBlock = ^(UIButton *button) {
              NSLog(@"\n\n%@",@"完成");
    };
    [self.view addSubview:view];
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"other_user_id"] = self.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_getUserInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataModel = [QYZJUserModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.headV.mj_h = self.headV.headHeight;
            self.headV.dataModel = self.dataModel;
            self.tableView.tableHeaderView = self.headV;
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (void)getDataTwo {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_mediaListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataModel.case_list.count;
    }else if(section == 1) {
        return self.dataModel.goods_list.count / 2 + self.dataModel.goods_list.count % 2;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1) {
        CGFloat hh = (ScreenW - 30) / 2 * 3 / 4;
         return hh + 40 + 20 + 10;
    }
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        QYZJMineAnLiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineAnLiCell" forIndexPath:indexPath];
        cell.model = self.dataModel.case_list[indexPath.row];
        return cell;
    }else if (indexPath.section == 1) {
        QYZJMineShopCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineShopCell" forIndexPath:indexPath];
         cell.isShenHe = YES;
        if (indexPath.row * 2 + 2 <= self.dataModel.goods_list.count) {
               cell.dataArray = [self.dataModel.goods_list subarrayWithRange:NSMakeRange(indexPath.row * 2 , 2)];
           }else {
               cell.dataArray = [self.dataModel.goods_list subarrayWithRange:NSMakeRange(indexPath.row * 2 , 1)];
           }
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        QYZJZhuYeYuYinCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJZhuYeYuYinCell" forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headVview"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
        view.clipsToBounds = YES;
        view.backgroundColor = WhiteColor;
        UILabel * leftLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 150, 20)];
        leftLB.font = kFont(15);
        leftLB.text = @"推荐答人";
        leftLB.tag = 101;
        [view addSubview:leftLB];
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 15 - 80, 10, 80, 30)];
        [button setTitleColor:CharacterBackColor forState:UIControlStateNormal];
        button.titleLabel.font = kFont(14);
        button.tag = 100;
        [button setTitle:@"更多 >" forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [view addSubview:button];
        view.tag = section;
    }
    
    UILabel * lb = (UILabel *)[view viewWithTag:101];
    lb.text = self.leftArr[section];
    UIButton * bt = (UIButton*)[view viewWithTag:100];
    [bt addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [bt setTitle:@"更多 >" forState:UIControlStateNormal];
    if (section == 2) {
       [bt setTitle:@"" forState:UIControlStateNormal];
    }
    return view;
}


- (void)moreAction:(UIButton *)button {
    NSInteger ta = button.superview.tag;
    if (ta == 0) {
        QYZJMineAnLiTVC * vc =[[QYZJMineAnLiTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        QYZJMineShopTVC * vc =[[QYZJMineShopTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

@end
