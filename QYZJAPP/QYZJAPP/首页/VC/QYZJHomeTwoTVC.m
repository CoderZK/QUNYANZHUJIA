//
//  QYZJHomeTwoTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJHomeTwoTVC.h"
#import "FindHeadView.h"
#import "QYZJHomeThreeCell.h"
#import "QYZJHomeFourCell.h"
#import "QYZJHomeFiveCell.h"
#import "QYZJCoachCell.h"
#import "QYZJTypesSearchTVC.h"
#import "QYZJYuYueFangDanTVC.h"
#import "QYZJSearchListTVC.h"
@interface QYZJHomeTwoTVC ()
@property(nonatomic,strong)FindHeadView *navigaV;
@property(nonatomic,strong)NSMutableArray<QYZJTongYongModel *> *labelListArr;
@property(nonatomic,assign)BOOL isMore,isSpread;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@end

@implementation QYZJHomeTwoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 0) {
        self.navigationItem.title = @"教练";
    }else {
        self.navigationItem.title = @"裁判";
    }
    [self addNav];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeThreeCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeThreeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeFourCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeFourCell"];
       [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeFiveCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeFiveCell"];
    [self.tableView registerClass:[QYZJCoachCell class] forCellReuseIdentifier:@"QYZJCoachCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getQuDaoArrList];
    
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
    dict[@"type"] = @"0";
    dict[@"city_id"] = self.cityID;
    dict[@"sort_type"] = @"0";
    dict[@"search_type"] = @(self.type);
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_searchURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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


- (void)getQuDaoArrList {
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_labelListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.labelListArr = [QYZJTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            if (self.labelListArr.count <=6) {
                self.isMore = NO;
            }else {
                self.isMore = YES;
            }
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


- (void)addNav {
    
    self.navigaV = [[FindHeadView alloc] initWithFrame:CGRectMake(0, sstatusHeight, ScreenW, 60)];
    self.navigaV.clipsToBounds = YES;
    self.navigaV.isPresentVC = YES;
    
    self.navigaV.delegateSignal = [RACSubject subject];
     @weakify(self);
    [self.navigaV.delegateSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSDictionary * dict = x;
        if ([[NSString stringWithFormat:@"%@",dict[@"key"]] isEqualToString:@"search"]) {
            //点击搜索
            QYZJSearchListTVC * vc =[[QYZJSearchListTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.cityID = self.cityID;
            vc.type = self.type;
            [self.navigationController pushViewController:vc animated:YES];

        }else {
            
        }
    }];
    self.tableView.tableHeaderView = self.navigaV;;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.dataArray.count + 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 40;
    }
    return 0.01;
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
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headVview"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
        view.clipsToBounds = YES;
        view.backgroundColor = WhiteColor;
        UILabel * leftLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
        leftLB.font = kFont(15);
        leftLB.text = @"推荐答人";
        [view addSubview:leftLB];
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 15 - 80, 10, 80, 30)];
        [button setTitleColor:CharacterBackColor forState:UIControlStateNormal];
        button.titleLabel.font = kFont(14);
        button.tag = 100;
        [button setTitle:@"更多   >" forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [view addSubview:button];
    }
    
    UIButton * bt = (UIButton*)[view viewWithTag:100];
    [bt addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.isMore){
            if (self.isSpread) {
                return 85 * ((self.labelListArr.count +1) / 3 + ((self.labelListArr.count + 1) % 3 == 0?0:1));
            }else {
                return  85*2;
            }
        }else {
            return 85 * (self.labelListArr.count / 3 + (self.labelListArr.count % 3 == 0?0:1));
        }
        return 100;
    }else if (indexPath.section == 1) {
        return 200;
    }else if (indexPath.section == 2) {
        return 110;
    }
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0){
        QYZJCoachCell* cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJCoachCell" forIndexPath:indexPath];
        Weak(weakSelf);
        cell.sendStatusBlock = ^(BOOL isMore, BOOL isSpread, BOOL isReload, NSInteger index) {
            if (isReload) {
                weakSelf.isSpread = isSpread;
                weakSelf.isMore = isMore;
                [weakSelf.tableView reloadData];
            }else {
                
                NSLog(@"-=-=-=-\n%d",index);
                
                QYZJTypesSearchTVC * vc =[[QYZJTypesSearchTVC alloc] init];
                vc.role_id = weakSelf.labelListArr[index].ID;
                vc.titleStr = weakSelf.labelListArr[index].name;
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
                
            }
        };
        cell.isSpread = self.isSpread;
        cell.isMore = self.isMore;
        cell.dataArr = self.labelListArr;
        return cell;
    }else if (indexPath.section == 1) {
        QYZJHomeThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeThreeCell" forIndexPath:indexPath];
       return cell;
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            QYZJHomeFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFourCell" forIndexPath:indexPath];
            return cell;
        }else {
            QYZJHomeFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFiveCell" forIndexPath:indexPath];
            cell.model = self.dataArray[indexPath.row - 1];
                   return cell;
        }
        
    }else {
        QYZJHomeFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFiveCell" forIndexPath:indexPath];
        return cell;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
           QYZJYuYueFangDanTVC * vc =[[QYZJYuYueFangDanTVC alloc] init];
           vc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            QYZJXiaoYanZiVC * vc =[[QYZJXiaoYanZiVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            QYZJMineZhuYeTVC * vc =[[QYZJMineZhuYeTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = self.dataArray[indexPath.row].ID;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else {
        BaseNavigationController * navc = [[BaseNavigationController alloc] initWithRootViewController:[[QYZhuJiaLoginVC alloc] init]];
        [self presentViewController:navc animated:YES completion:nil];
    }
   
}


#pragma mark ----  点击更多 -------
- (void)moreAction:(UIButton *)button {
    
}



@end
