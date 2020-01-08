//
//  QYZJRecommendDetailTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJRecommendDetailTVC.h"
#import "QYZJRobOrderDetailCell.h"
#import "QYZJMinePayDetailVC.h"
@interface QYZJRecommendDetailTVC ()
@property(nonatomic,strong)QYZJWorkModel *dataModel;
@property(nonatomic,strong)NSArray *leftTitleArr;

@end

@implementation QYZJRecommendDetailTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"TongYongCell" bundle:nil] forCellReuseIdentifier:@"cell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"QYZJRobOrderDetailCell" bundle:nil] forCellReuseIdentifier:@"QYZJRobOrderDetailCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];

        self.leftTitleArr = @[@"订单号",@"地址",@"小区名称",@"风格",@"户型",@"装修时间",@"需求类型",@"预算",@"建筑面积",@"需求描述",@"订单状态"];
    
    
}

- (void)setFootVWithStatus:(NSInteger)status {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60 - sstatusHeight - 44);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34 - sstatusHeight - 44);
    }
    
    
    
    
    KKKKFootView * view2 = (KKKKFootView *)[self.view viewWithTag:666];
    if (view2 != nil) {
        [view2 removeFromSuperview];
    }
    if (status != 7) {
        return;
    }
        KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"查看交付" andImgaeName:@""];
        view.tag = 666;
        Weak(weakSelf);
        view.footViewClickBlock = ^(UIButton *button) {
            [weakSelf clickActionWithStatus];
        };
        [self.view addSubview:view];
        

    
    
}

- (void)clickActionWithStatus {
    
    QYZJMinePayDetailVC * vc =[[QYZJMinePayDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.ID = self.dataModel.turnoverId;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_demandInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataModel = [QYZJWorkModel mj_objectWithKeyValues:responseObject[@"result"]];
            [self setFootVWithStatus:[self.dataModel.status intValue]];
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
    return self.leftTitleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 9 && self.dataModel.demand_voice.length > 0) {
        return 85;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 9 ) {
        QYZJRobOrderDetailCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJRobOrderDetailCell" forIndexPath:indexPath];
               cell.clipsToBounds = YES;
        cell.type = 1;
        cell.leftLB.text = @"需求描述";
        cell.leftLB.hidden = NO;
        cell.leftCons.constant = 100;
        cell.titelLB.text = self.dataModel.demand_context;
        [cell.gouTongBt setTitle:@"语音描述" forState:UIControlStateNormal];
        cell.model = self.dataModel;
        return cell;
    }
    
    TongYongCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.leftTitleArr[indexPath.row];
    cell.rightLB.textColor = CharacterColor80;
    NSInteger row = indexPath.row;
    NSString * str = @"";
    if (row == 0) {
        str = self.dataModel.no;
    }else if (row == 1) {
        str = self.dataModel.b_recomend_address;
    }else if (row == 2) {
        str = self.dataModel.community_name;
    }else if (row == 3) {
       if (self.dataModel.manner > 0 && [zkSignleTool shareTool].mannerArr.count >= self.dataModel.manner  ) {
           str = [zkSignleTool shareTool].mannerArr[self.dataModel.manner-1];
       }
    }else if (row == 4) {
       if (self.dataModel.house_model > 0 && [zkSignleTool shareTool].houseModelArr.count >= self.dataModel.house_model  ) {
            str = [zkSignleTool shareTool].houseModelArr[self.dataModel.house_model-1];
        }
    }else if (row == 5) {
        if (self.dataModel.renovation_time >0 && [zkSignleTool shareTool].renvoationTimeArr.count >= self.dataModel.renovation_time) {
            str = [zkSignleTool shareTool].renvoationTimeArr[self.dataModel.renovation_time-1];
        }
    }else if (row == 6) {
        str = self.dataModel.type_name;
    }else if (row == 7) {
        str = [NSString stringWithFormat:@"%0.2f元",self.dataModel.budget];;
    }else if (row == 8) {
        
        str = [NSString stringWithFormat:@"%@m²",self.dataModel.area];
    }else if (row == 10) {
           cell.rightLB.textColor = OrangeColor;
           if (self.dataModel.audit_status == 0) {
               str = @"未审核";
           }else if (self.dataModel.audit_status == 1) {
               if ([self.dataModel.status intValue]== 0) {
                     str = @"审核成功";
                 }else if ([self.dataModel.status intValue]== 1){
                     str = @"抢单中";
                 }else if ([self.dataModel.status intValue]== 2){
                     str = @"抢单结束";
                 }else if ([self.dataModel.status intValue]== 3 ){
                     str = @"有效信息";
                 }else if ([self.dataModel.status intValue]== 4){
                     str = @"无效信息";
                 }else if ([self.dataModel.status intValue]== 5){
                     str = @"已签单";
                 }else if ([self.dataModel.status intValue]== 6){
                     str = @" 未签单";
                 }else if ([self.dataModel.status intValue]== 7){
                     str = @"交付中";
                 }else if ([self.dataModel.status intValue]== 8 ){
                     str = @"交付完成";
                 }else if ([self.dataModel.status intValue]== 9){
                     str = @"";
                 }else if ([self.dataModel.status intValue]== 10){
                     str = @"";
                 }else if ([self.dataModel.status intValue]== 11){
                     
                 }
               
           }else {
               
              str = @"审核失败";
           }
    }
    cell.rightLB.text = str;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
