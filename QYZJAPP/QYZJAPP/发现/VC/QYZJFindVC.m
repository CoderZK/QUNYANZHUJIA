//
//  QYZJFindVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/1.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFindVC.h"
#import "FindHeadView.h"
#import "QYZJFindOneCell.h"
#import "QYZJFindCell.h"
#import "QYZJHomeFiveCell.h"
#import "QYZJFindTwoCell.h"
@interface QYZJFindVC ()
@property(nonatomic,strong)FindHeadView *navigaV;
@property(nonatomic,strong)UIButton *faBuBt;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)NSInteger page;
@end

@implementation QYZJFindVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = 0;
    self.page = 1;
    self.dataArray = [NSMutableArray array];
     self.tableView.frame = CGRectMake(0, sstatusHeight + 110, ScreenW, ScreenH - sstatusHeight - 110);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJFindOneCell" bundle:nil] forCellReuseIdentifier:@"QYZJFindOneCell"];
    [self.tableView registerClass:[QYZJFindCell class] forCellReuseIdentifier:@"QYZJFindCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeFiveCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeFiveCell"];
      [self.tableView registerNib:[UINib nibWithNibName:@"QYZJFindTwoCell" bundle:nil] forCellReuseIdentifier:@"QYZJFindTwoCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 1;
    [self addNav];
    
    [self getDataWithType:self.type];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getDataWithType:self.type];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getDataWithType:self.type];
    }];
    
    

    
    
}

- (void)getDataWithType:(NSInteger )type {
    
    NSString * urlStr = [QYZJURLDefineTool app_articleListURL];
    if (type == 1) {
        urlStr = [QYZJURLDefineTool app_logiciansListURL];
    }else if (type == 2) {
        urlStr = [QYZJURLDefineTool app_headlinenewsListURL];
    }else if (type == 3){
       urlStr = [QYZJURLDefineTool app_questionSitListOpenURL];
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"city_id"] = @"1004";
    dict[@"page"] = @(self.page);
    [zkRequestTool networkingPOST:urlStr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            self.dataArray = [QYZJFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
}


- (void)addFaTieView {
     self.faBuBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 100, ScreenH - 240, 60, 60)];
     [self.faBuBt setBackgroundImage:[UIImage imageNamed:@"qy34"] forState:UIControlStateNormal];
    [[self.faBuBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       //发帖
        
        
    }];
     [self.view addSubview:self.faBuBt];
}


- (void)addNav {
    
    self.navigaV = [[FindHeadView alloc] initWithFrame:CGRectMake(0, sstatusHeight, ScreenW, 110)];
    [self.view addSubview:self.navigaV];
    self.navigaV.delegateSignal = [RACSubject subject];
    [self.navigaV.delegateSignal subscribeNext:^(id  _Nullable x) {
       
        NSDictionary * dict = x;
        if ([[NSString stringWithFormat:@"%@",dict[@"search"]] isEqualToString:@"city"]) {
            //点击搜索
        }else {
            NSNumber *number = dict[@"text"];
            
            self.type = [number intValue];
            self.page = 1;
            [self getDataWithType:self.type];
            
            NSLog(@"%@",number);

        }
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 0) {
        return UITableViewAutomaticDimension;
    }else if (self.type == 1) {
        return 125;
    }else if (self.type == 2) {
        return 130+10;
    }else {
        
    }
    return 100;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 0) {
        QYZJFindCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJFindCell" forIndexPath:indexPath];
          cell.model = self.dataArray[indexPath.row];
          return cell;
    }else if(self.type == 1){
        QYZJHomeFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFiveCell" forIndexPath:indexPath];
        return cell;
    }else if (self.type == 2) {
        QYZJFindTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJFindTwoCell" forIndexPath:indexPath];
        return cell;
    }
    QYZJFindCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJFindCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




@end
