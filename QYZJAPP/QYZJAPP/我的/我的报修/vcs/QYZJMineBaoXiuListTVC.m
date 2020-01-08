//
//  QYZJMineBaoXiuListTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineBaoXiuListTVC.h"
#import "QYZJConstructionListCell.h"
#import "QYZJMineBaoXiuDetailTVC.h"
@interface QYZJMineBaoXiuListTVC ()<QYZJConstructionListCellDelegate>
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJWorkModel *> *dataArray;
@end

@implementation QYZJMineBaoXiuListTVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的报修";
    
    [self.tableView registerClass:[QYZJConstructionListCell class] forCellReuseIdentifier:@"cell"];
    
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
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_repairListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<QYZJWorkModel *>*arr = [QYZJWorkModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArray[indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJConstructionListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    QYZJWorkModel * model = self.dataArray[indexPath.row];
    model.selfStage = model.repairSelf;
    model.stageName = model.turnoverStageName;
    model.des = model.con;
    cell.type = 1;
    cell.is_service = !model.isService;
    cell.model = model;
    cell.delegate = self;
    
    
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        QYZJWorkModel * model = self.dataArray[indexPath.row];
        QYZJFindModel * modelNei = [[QYZJFindModel alloc] init];
        modelNei.nickName = model.turnoverStageName;
        modelNei.content = model.con;
        modelNei.time = model.time;
        modelNei.pictures = model.pics.mutableCopy;
        modelNei.videos = model.videos.mutableCopy;
        modelNei.price = model.price;
        modelNei.isOverRepairTime = model.isOverRepairTime;
        modelNei.status = model.status;
        modelNei.evaluateLevel = model.evaluateLevel;
        modelNei.evaluateCon = model.evaluateCon;
        modelNei.ID = model.ID;
        modelNei.turnoverListId = model.turnoverListId;
        modelNei.turnoverTitle = model.turnoverTitle;
        modelNei.isService = model.isService;
        QYZJMineBaoXiuDetailTVC * vc =[[QYZJMineBaoXiuDetailTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.model = modelNei;
        [self.navigationController pushViewController:vc animated:YES];
    
    
}

-(void)didclickQYZJConstructionListCell:(QYZJConstructionListCell *)cell withIndex:(NSInteger)index isNeiClick:(BOOL )isNei NeiRow:(NSInteger )row isClickNeiCell:(BOOL)isClickNeiCell{
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QYZJWorkModel * model = nil;
    
    if (isClickNeiCell) {
           //点击的是内容部cell
             model = self.dataArray[indexPath.row].repairSelf[row];
             QYZJFindModel * modelNei = [[QYZJFindModel alloc] init];
             modelNei.nickName = self.dataArray[indexPath.row].turnoverStageName;
             modelNei.content = model.con;
             modelNei.time = model.time;
             modelNei.pictures = model.pics.mutableCopy;
             modelNei.videos = model.videos.mutableCopy;
             modelNei.price = model.price;
             modelNei.isService = model.isService;
             modelNei.status = model.status;
             modelNei.evaluateLevel = model.evaluateLevel;
             modelNei.evaluateCon = model.evaluateCon;
             modelNei.ID = model.ID;
             modelNei.turnoverListId = model.turnoverListId;
             modelNei.turnoverTitle = self.dataArray[indexPath.row].turnoverTitle;
             QYZJMineBaoXiuDetailTVC * vc =[[QYZJMineBaoXiuDetailTVC alloc] init];
             vc.hidesBottomBarWhenPushed = YES;
             vc.model = modelNei;
             [self.navigationController pushViewController:vc animated:YES];
           
           
       }
    
}



@end
