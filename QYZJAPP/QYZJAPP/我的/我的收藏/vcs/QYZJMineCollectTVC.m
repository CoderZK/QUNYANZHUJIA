//
//  QYZJMineCollectTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/13.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineCollectTVC.h"
#import "QYZJFindCell.h"
#import "QYZJFindTwoCell.h"
#import "QYZJFindGuangChangDetailTVC.h"
#import "QYZJFindTouTiaoDetailTVC.h"
@interface QYZJMineCollectTVC ()<QYZJFindTwoCellDelegate,QYZJFindCellDelegate>
@property(nonatomic,strong)UIButton *leftBt,*rightBt;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,assign)NSInteger type;//1头条 2 动态
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,assign)NSInteger page;
@end

@implementation QYZJMineCollectTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    [self setheadV];
    self.page = 1;
    self.type = 1;
    [self.tableView registerClass:[QYZJFindCell class] forCellReuseIdentifier:@"QYZJFindCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJFindTwoCell" bundle:nil] forCellReuseIdentifier:@"QYZJFindTwoCell"];
    self.dataArray = @[].mutableCopy;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
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


- (void)setheadV  {
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.6)];
    backV.backgroundColor = lineBackColor;
    [self.headV addSubview:backV];

    self.leftBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2 - 100 - 10, 10, 100, 35)];
    [self.leftBt setTitle:@"头条" forState:UIControlStateNormal];
    self.leftBt.titleLabel.font = kFont(15);
    [self.leftBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBt.backgroundColor = OrangeColor;
    [self.headV addSubview:self.leftBt];
    self.leftBt.tag = 100;
    self.leftBt.layer.cornerRadius = 2;
    self.leftBt.clipsToBounds = YES;
    [self.leftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2 + 10, 10, 100, 35)];
    [self.rightBt setTitle:@"动态" forState:UIControlStateNormal];
    self.rightBt.titleLabel.font = kFont(15);
    [self.rightBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rightBt.backgroundColor = WhiteColor;
    self.rightBt.layer.borderColor = OrangeColor.CGColor;
    self.rightBt.layer.borderWidth = 1;
    [self.headV addSubview:self.rightBt];
    self.rightBt.tag = 101;
    [self.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = self.headV;
    
}

- (void)clickAction:(UIButton *)button {
    
    if (button.tag == 100) {
        [self.rightBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.rightBt.backgroundColor = WhiteColor;
        [self.leftBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.leftBt.backgroundColor = OrangeColor;
        self.rightBt.layer.borderWidth = 1;
        self.rightBt.layer.borderColor = OrangeColor.CGColor;
    }else {
        [self.rightBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.rightBt.backgroundColor = OrangeColor;
        self.leftBt.layer.borderWidth = 1;
        self.leftBt.layer.borderColor = OrangeColor.CGColor;
        [self.leftBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.leftBt.backgroundColor = WhiteColor;
    }
    self.type = button.tag - 99;
    self.page = 1;
    [self getData];
    
    
}

- (void)getData {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"page"] = @(self.page);
    dict[@"type"] = @(self.type);
    dict[@"pageSize"] = @(10);
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_collectListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type==2) {
        return UITableViewAutomaticDimension;
    }
    return 190;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type ==2) {
        QYZJFindCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJFindCell" forIndexPath:indexPath];
        cell.type = 1;
        cell.delegate = self;
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }else {
        QYZJFindTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJFindTwoCell" forIndexPath:indexPath];
        cell.type = 1;
        cell.delegate = self;
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.type == 2) {
        
        QYZJFindGuangChangDetailTVC * vc =[[QYZJFindGuangChangDetailTVC alloc] init];
        vc.ID = self.dataArray[indexPath.row].ID;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        
        QYZJFindTouTiaoDetailTVC * vc =[[QYZJFindTouTiaoDetailTVC alloc] init];
        vc.ID = self.dataArray[indexPath.row].ID;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}


- (void)didClickFindTwoCell:(QYZJFindTwoCell *)cell withIndex:(NSInteger)index {
     NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    QYZJFindModel * model = self.dataArray[indexPath.row];
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    NSString * str =@"";
   
    str = [QYZJURLDefineTool app_headlinenewsCollectURL];
    dict[@"status"] = @"1";
    dict[@"headlinenews_id"] = model.ID;
    [zkRequestTool networkingPOST:str parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [self.dataArray removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    

    
}

- (void)didClickFindCell:(QYZJFindCell *)cell index:(NSInteger)index {
    
    
     NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
     QYZJFindModel * model = self.dataArray[indexPath.row];
    
         [SVProgressHUD show];
         NSMutableDictionary * dict = @{}.mutableCopy;
         dict[@"status"] = @"1";
         dict[@"article_id"] = model.ID;
         [zkRequestTool networkingPOST:[QYZJURLDefineTool app_articleCollectURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
             [SVProgressHUD dismiss];
             if ([responseObject[@"key"] intValue]== 1) {
                 
                 [self.dataArray removeObjectAtIndex:indexPath.row];
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
