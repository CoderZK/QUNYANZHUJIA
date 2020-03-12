//
//  QYZJPingOrZanListTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJPingOrZanListTVC.h"
#import "QYZJPingOrZanCell.h"
#import "QYZJFindGuangChangDetailTVC.h"
@interface QYZJPingOrZanListTVC ()
@property(nonatomic,strong)UIButton *left1Bt,*left2Bt,*rightBt;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,assign)BOOL isRead;
@end

@implementation QYZJPingOrZanListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setheadV];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJPingOrZanCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"详情";
    
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
    dict[@"is_read"] = @(self.isRead);
    NSString * url = [QYZJURLDefineTool user_goodNewsListURL];
    if (self.type == 1) {
        url = [QYZJURLDefineTool user_commentNewsListURL];
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJPingOrZanCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.type == 0) {
        cell.imgVTwo.hidden = NO;
        cell.contentLB.hidden = YES;
    }else {
        cell.imgVTwo.hidden = YES;
        cell.contentLB.hidden = NO;
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self allReadAction:self.dataArray[indexPath.row].ID];
    
    QYZJFindGuangChangDetailTVC * vc =[[QYZJFindGuangChangDetailTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.ID = self.dataArray[indexPath.row].articleId;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)setheadV {
    
    UIView * headV= [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    headV.backgroundColor = [UIColor whiteColor];
    
    self.left1Bt = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
    self.left1Bt.titleLabel.font = kFont(14);
    [self.left1Bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.left1Bt setTitleColor:OrangeColor forState:UIControlStateSelected];
    self.left1Bt.tag = 100;
    self.left1Bt.selected = YES;
    [self.left1Bt setTitle:@"未读" forState:UIControlStateNormal];
    [self.left1Bt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [headV addSubview:self.left1Bt];
    
    self.left2Bt = [[UIButton alloc] initWithFrame:CGRectMake(90, 10, 60, 30)];
    self.left2Bt.titleLabel.font = kFont(14);
    [self.left2Bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.left2Bt setTitleColor:OrangeColor forState:UIControlStateSelected];
    self.left2Bt.tag = 101;
    [self.left2Bt setTitle:@"已读" forState:UIControlStateNormal];
    [self.left2Bt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [headV addSubview:self.left2Bt];
    
    
    self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 120, 10, 110, 30)];
    self.rightBt.titleLabel.font = kFont(14);
    [self.rightBt setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.rightBt.layer.cornerRadius = 3;
    self.rightBt.clipsToBounds = YES;;
  
    [self.rightBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
    self.rightBt.tag = 102;
    [self.rightBt setTitle:@"全部标记为已读" forState:UIControlStateNormal];
    [self.rightBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [headV addSubview:self.rightBt];
    
    
    self.tableView.tableHeaderView = headV;
}

- (void)action:(UIButton *)button {
    self.isRead = button.tag - 100;
    if (button.tag == 100) {
        self.left1Bt.selected = YES;
        self.left2Bt.selected = NO;
        self.rightBt.hidden = NO;
        
        self.page = 1;
           [self getData];
        
    }else if (button.tag == 101) {
        self.left1Bt.selected = NO;
        self.left2Bt.selected = YES;
        self.rightBt.hidden = YES;
        
        self.page = 1;
           [self getData];
        
    }else {
        
        [self allReadAction:@""];
        
    }

   
}

- (void)allReadAction:(NSString *)ID{

    NSMutableDictionary * dict = @{}.mutableCopy;

    if (ID.length == 0) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString * time = [formatter stringFromDate:[NSDate date]];
        dict[@"time"] = time;
    }else {
        dict[@"id"]=ID;
    }
    
    NSString * url = [QYZJURLDefineTool user_commentNewsReadURL];
    if (self.type == 0) {
        url = [QYZJURLDefineTool user_goodNewsReadURL];
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.page = 1;
            [self getData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


@end
