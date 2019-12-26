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
#import "QYZJFindGuangChangDetailTVC.h"
#import "QYZJFindTouTiaoDetailTVC.h"
#import "QYZJFindQuestionListCell.h"
#import "QYZJQuestionListDetailTVC.h"
#import "QYZJPostMessageTVC.h"
#import "QYZJAppShopTVC.h"
#import "QYZJShopDetailTVC.h"
@interface QYZJFindVC ()<QYZJFindCellDelegate,QYZJFindTwoCellDelegate>
@property(nonatomic,strong)FindHeadView *navigaV;
@property(nonatomic,strong)UIButton *faBuBt;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSString *searchText;
@end

@implementation QYZJFindVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = 0;
    self.page = 1;
    self.searchText = @"";
    self.dataArray = [NSMutableArray array];
    self.tableView.frame = CGRectMake(0, sstatusHeight + 110, ScreenW, ScreenH - sstatusHeight - 110);
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJFindOneCell" bundle:nil] forCellReuseIdentifier:@"QYZJFindOneCell"];
    [self.tableView registerClass:[QYZJFindCell class] forCellReuseIdentifier:@"QYZJFindCell"];
    [self.tableView registerClass:[QYZJFindQuestionListCell class] forCellReuseIdentifier:@"QYZJFindQuestionListCell"];
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
    [self addFaTieView];
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
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"city_id"] = @"0";
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"title"] = self.searchText;
    dict[@"content"] = self.searchText;
    dict[@"nick_name"] = self.searchText;


    [zkRequestTool networkingPOST:urlStr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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


- (void)addFaTieView {
     self.faBuBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 100, ScreenH - 150, 60, 60)];
     [self.faBuBt setImage:[UIImage imageNamed:@"qy35"] forState:UIControlStateNormal];
    self.faBuBt.backgroundColor = [UIColor whiteColor];
    self.faBuBt.layer.shadowColor = [UIColor blackColor].CGColor;
    self.faBuBt.layer.shadowRadius = 5;
    self.faBuBt.layer.cornerRadius = 30;
    self.faBuBt.layer.shadowOpacity = 0.3;
    self.faBuBt.layer.shadowOffset = CGSizeMake(0, 0);
    [[self.faBuBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       //发帖
        QYZJPostMessageTVC * vc =[[QYZJPostMessageTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
     [self.view addSubview:self.faBuBt];
}


- (void)addNav {
    
    self.navigaV = [[FindHeadView alloc] initWithFrame:CGRectMake(0, sstatusHeight, ScreenW, 110)];
    [self.view addSubview:self.navigaV];
    self.navigaV.delegateSignal = [RACSubject subject];
    [self.navigaV.delegateSignal subscribeNext:^(id  _Nullable x) {
       
        NSDictionary * dict = x;
        if ([[NSString stringWithFormat:@"%@",dict[@"key"]] isEqualToString:@"search"]) {
            //点击搜索
            self.searchText = dict[@"text"];
            self.page = 1;
            [self getDataWithType:self.type];
        }else {
            NSNumber *number = dict[@"text"];
            self.type = [number intValue];
            self.page = 1;
            [self getDataWithType:self.type];
            NSLog(@"%@",number);
            
            if (self.type == 0) {
                self.faBuBt.hidden  = NO;
            }else {
                self.faBuBt.hidden = YES;
            }
            

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
        return 130+10 + 45;
    }else {
        return 135;
    }
    return 100;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 0) {
        QYZJFindCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJFindCell" forIndexPath:indexPath];
        cell.type = 0;
        cell.model = self.dataArray[indexPath.row];
        cell.delegate = self;
          return cell;
    }else if(self.type == 1){
        QYZJHomeFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFiveCell" forIndexPath:indexPath];
        cell.type = 1;
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }else if (self.type == 2) {
        QYZJFindTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJFindTwoCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }else if (self.type == 3) {
        QYZJFindQuestionListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJFindQuestionListCell" forIndexPath:indexPath];
        
           cell.model = self.dataArray[indexPath.row];
           return cell;
    }
    QYZJFindCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJFindCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.type == 0) {
        QYZJFindGuangChangDetailTVC * vc =[[QYZJFindGuangChangDetailTVC alloc] init];
        vc.ID = self.dataArray[indexPath.row].ID;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.type == 1) {
        
    }else if (self.type == 2) {
        QYZJFindTouTiaoDetailTVC * vc =[[QYZJFindTouTiaoDetailTVC alloc] init];
        vc.ID = self.dataArray[indexPath.row].ID;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        QYZJQuestionListDetailTVC * vc =[[QYZJQuestionListDetailTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = self.dataArray[indexPath.row].ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}

#pragma mark ------- 点击cell  ----
// 0 0 头像 1 进店 2 收藏 3评论 4赞   5删除
- (void)didClickFindCell:(QYZJFindCell *)cell index:(NSInteger)index {
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NSString * str =@"";
    BOOL isZan = NO;
       if (index == 4) {
           //点赞取消
           str = [QYZJURLDefineTool app_articleGoodURL];
           isZan = YES;
            [self zanOrNOCollectOrNOWithIndexPath:indexPath andUrlStr:str isZanOpAction:isZan];
       }else if (index == 2) {
           str = [QYZJURLDefineTool app_articleCollectURL];
           isZan = NO;
            [self zanOrNOCollectOrNOWithIndexPath:indexPath andUrlStr:str isZanOpAction:isZan];
       }else if (index == 1) {
           QYZJAppShopTVC * vc =[[QYZJAppShopTVC alloc] init];
           vc.hidesBottomBarWhenPushed = YES;
           vc.shopId = self.dataArray[indexPath.row].refShopId;
           [self.navigationController pushViewController:vc animated:YES];
       }else if (index >= 100) {
           
           QYZJShopDetailTVC * vc =[[QYZJShopDetailTVC alloc] init];
           vc.hidesBottomBarWhenPushed = YES;
           vc.ID = self.dataArray[indexPath.row].goodsList[index-100].ID;
           [self.navigationController pushViewController:vc animated:YES];
           
           
       }
   
}

- (void)didClickFindTwoCell:(QYZJFindTwoCell *)cell withIndex:(NSInteger)index {
     NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    NSString * str =@"";
    BOOL isZan = NO;
       if (index == 0) {
           //点赞取消
           str = [QYZJURLDefineTool app_headlinenewsGoodURL];
           isZan = YES;
           [self zanOrNOCollectOrNOWithIndexPath:indexPath andUrlStr:str isZanOpAction:isZan];
       }else if (index == 2) {
           str = [QYZJURLDefineTool app_headlinenewsCollectURL];
           isZan = NO;
           [self zanOrNOCollectOrNOWithIndexPath:indexPath andUrlStr:str isZanOpAction:isZan];
       }
    
}

- (void)zanOrNOCollectOrNOWithIndexPath:(NSIndexPath *)indexPath andUrlStr:(NSString *)str isZanOpAction:(BOOL)isZanOp{
    
    
      QYZJFindModel * model = self.dataArray[indexPath.row];
      [SVProgressHUD show];
      NSMutableDictionary * dict = @{}.mutableCopy;
      if (isZanOp) {
          //点赞取消
          if (model.isGood) {
              dict[@"is_good"] = @"0";
          }else {
              dict[@"is_good"] = @"1";
          }
      }else {
          if (model.isCollect) {
              dict[@"status"] = @"1";
          }else {
              dict[@"status"] = @"0";
          }
      }
      dict[@"headlinenews_id"] = model.ID;
      dict[@"article_id"] = model.ID;
      [zkRequestTool networkingPOST:str parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
          [SVProgressHUD dismiss];
          if ([responseObject[@"key"] intValue]== 1) {
              if (isZanOp) {
                  if (model.isGood) {
                      model.goodNum=model.goodNum-1;
                      model.goodsNum = model.goodsNum -1;
                  }else {
                       model.goodNum=model.goodNum+1;
                      model.goodsNum = model.goodsNum + 1;
                  }
                  model.isGood = !model.isGood;
              } else {
                  if (model.isCollect) {
                      model.collectNum=model.collectNum-1;
                  }else {
                       model.collectNum=model.collectNum+1;
                  }
                  model.isCollect = !model.isCollect;
              }
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
