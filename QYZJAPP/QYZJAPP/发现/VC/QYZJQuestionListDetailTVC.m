
//
//  QYZJQuestionListDetailTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJQuestionListDetailTVC.h"
#import "QYZJQusetionListDetailCell.h"
#import "QYZJQuestionListDetailView.h"
#import "QYZJZhiFuVC.h"
#import "QYZJMineQuestFiveCell.h"
@interface QYZJQuestionListDetailTVC ()
@property(nonatomic,strong)QYZJQuestionListDetailView *headV;
@property(nonatomic,strong)QYZJFindModel *dataModel;
@end



@implementation QYZJQuestionListDetailTVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    
    [self setheadV];
    

    [self.tableView registerClass:[QYZJMineQuestFiveCell class] forCellReuseIdentifier:@"cell"];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
}

- (void)setheadV {
    self.headV = [[QYZJQuestionListDetailView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
}


- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_questionInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.dataModel = [QYZJFindModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.headV.dataModel = self.dataModel;
            self.headV.mj_h = self.headV.headHeight;
            self.tableView.tableHeaderView = self.headV;
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
    return self.dataModel.answer_list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataModel.answer_list[indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMineQuestFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataModel.answer_list[indexPath.row];
    cell.listBt.tag = indexPath.row;
    cell.replyBt.hidden = YES;
    [cell.listBt addTarget:self action:@selector(listAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)listAction:(UIButton *)button {
    QYZJFindModel * model = self.dataModel.answer_list[button.tag];
    if (model.is_pay) {
        //未支付
        [self sitAnswerActionWithModel:model];
    }else {
        for (QYZJFindModel * model  in self.dataModel.answer_list) {
               if (model == self.dataModel.answer_list[button.tag]) {
                   model.isPlaying = YES;
               }else {
                   model.isPlaying = NO;
               }
           }
           [self.tableView reloadData];
              [button setTitle:@"正在播放..." forState:UIControlStateNormal];
              [[PublicFuntionTool shareTool] palyMp3WithNSSting:[QYZJURLDefineTool getVideoURLWithStr:self.dataModel.answer_list[button.tag].media_url] isLocality:NO];
              [PublicFuntionTool shareTool].findPlayBlock = ^{
                  [button setTitle:@"点击播放" forState:UIControlStateNormal];
              };
        
    }
    
    
}

- (void)sitAnswerActionWithModel:(QYZJFindModel *)model {
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"answer_id"] = model.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_sitAnswerURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            QYZJTongYongModel * mm = [[QYZJTongYongModel alloc] init];
            mm = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
            mm.ID = model.ID;
            if (model.is_pay) {
                QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
                vc.type = 4;
                vc.model = mm;
                vc.ID = model.ID;
            
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}


@end
