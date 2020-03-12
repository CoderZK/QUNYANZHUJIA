//
//  QYZJFindTouTiaoDetailTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/14.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFindTouTiaoDetailTVC.h"
#import "QYZJFindTouTiaoHeadView.h"
#import "QYZJPingLunNeiCell.h"
@interface QYZJFindTouTiaoDetailTVC ()<UITextFieldDelegate>
@property(nonatomic,strong)QYZJFindTouTiaoHeadView *headV;
@property(nonatomic,strong)QYZJFindModel *dataModel;
@property(nonatomic,strong)UIView *whiteView;
@property(nonatomic,strong)UITextField *TF;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,assign)BOOL isPeople;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end

@implementation QYZJFindTouTiaoDetailTVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.dataModel != nil && self.sendTouTiaoModelBlock != nil) {
        self.sendTouTiaoModelBlock(self.dataModel.headlinenews);
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJPingLunNeiCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 1;
    
    self.whiteView = [[UIView alloc] init];

    self.whiteView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.whiteView.mj_w = ScreenW ;
    self.whiteView.mj_h = 60;
    self.whiteView.mj_x = 0;
    [self.view addSubview:self.whiteView];

    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 10, ScreenW - 30 - 70, 40)];
    backV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backV];
    backV.layer.cornerRadius = 3;
    backV.clipsToBounds = YES;
    [self.whiteView addSubview:backV];
    

    
    self.TF = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, ScreenW - 50-70 , 30)];
    self.TF.font = kFont(14);
    self.TF.placeholder = @"请输入评论";
    self.TF.delegate = self;
    self.TF.returnKeyType = UIReturnKeySend;
    [backV addSubview:self.TF];
    
    UIButton * sendBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW -70, 15, 60, 30)];
     [sendBt setTitle:@"发送" forState:UIControlStateNormal];
     sendBt.titleLabel.font = kFont(14);
     [sendBt setTitleColor:WhiteColor forState:UIControlStateNormal];
     [self.whiteView addSubview:sendBt];
     [sendBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
     sendBt.layer.cornerRadius = 4;
     sendBt.clipsToBounds = YES;
     [sendBt addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 34 - 60);
        self.whiteView.mj_y = ScreenH - sstatusHeight - 44 - 34 -60;
    }else {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  -60);
        self.whiteView.mj_y = ScreenH - sstatusHeight - 44  -60;
    }
    self.headV = [[QYZJFindTouTiaoHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.1)];
    Weak(weakSelf);
    self.headV.webLoadFindBlock = ^(CGFloat hh) {
        weakSelf.headV.mj_h = hh;
        weakSelf.tableView.tableHeaderView = weakSelf.headV;
    };
    self.headV.TouTiaoClickBlock = ^(NSInteger tag) {
      
        if (tag == 0) {
            [weakSelf zanOrNOCollectOrNOWithisZanOpAction:YES];
        }else {
            [weakSelf zanOrNOCollectOrNOWithisZanOpAction:NO];
        }
        
        
        
    };
    self.navigationItem.title = @"详情";
    
    [self getData];
    
    
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    [self getDataCommend];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getDataCommend];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getDataCommend];
    }];
    
    
}

- (void)getDataCommend {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"headlinenews_id"] = self.ID;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_headlinenewsDetailsCommentURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"headlinenews_id"] = self.ID;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_headlinenewsDetailsURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            self.dataModel = [QYZJFindModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.headV.model = self.dataModel;
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

- (void)sendAction:(UIButton *)button {
    if (self.TF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    
    [self textFieldShouldReturn:self.TF];
    
}


//点击发送
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"nickName"] = [zkSignleTool shareTool].nick_name;
    if (self.isPeople) {
        dict[@"toUserId"] = self.dataArray[self.indexPath.row].userId;
        dict[@"toNickName"] = self.dataArray[self.indexPath.row].nickName;
        dict[@"commentId"] = self.dataArray[self.indexPath.row].ID;
    }
    dict[@"userId"] = [zkSignleTool shareTool].session_uid;
    dict[@"headlinenewsId"] = self.ID;
    dict[@"commentContent"] = textField.text;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_headlinenewsCommentURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.page = 1;
            [self getDataCommend];
            textField.placeholder = @"写下你的评论...";
            self.dataModel.commentNum = self.dataModel.commentNum+1;
            self.isPeople = NO;
            self.TF.text = @"";
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

        
    }];
    
    
    
    return  YES;
}


- (void)zanOrNOCollectOrNOWithisZanOpAction:(BOOL)isZanOp{

      [SVProgressHUD show];
      NSMutableDictionary * dict = @{}.mutableCopy;
      if (isZanOp) {
          //点赞取消
          if (self.dataModel.headlinenews.isGood) {
              dict[@"is_good"] = @"0";
          }else {
              dict[@"is_good"] = @"1";
          }
      }else {
          if (self.dataModel.headlinenews.isCollect) {
              dict[@"status"] = @"1";
          }else {
              dict[@"status"] = @"0";
          }
      }
      dict[@"headlinenews_id"] = self.ID;
      dict[@"article_id"] = self.ID;
    
    NSString * str = [QYZJURLDefineTool app_headlinenewsCollectURL];
    if (isZanOp) {
        str = [QYZJURLDefineTool app_headlinenewsGoodURL];
    }
    
      [zkRequestTool networkingPOST:str parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
          [SVProgressHUD dismiss];
          if ([responseObject[@"key"] intValue]== 1) {
              
              [self getData];
              
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
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    QYZJTongYongHeadFootView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (view == nil) {
        view = [[QYZJTongYongHeadFootView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 49.4, ScreenW, 0.6)];
        backV.backgroundColor = lineBackColor;
        [view addSubview:backV];
        

    }
    view.rightBt.hidden = YES;
    view.leftLB.text = [NSString stringWithFormat:@"评论(%ld)",self.dataModel.commentNum];;
    view.backgroundColor = WhiteColor;
    view.contentView.backgroundColor = WhiteColor;
    view.clipsToBounds = YES;
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJPingLunNeiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    QYZJFindModel * model = self.dataArray[indexPath.row];
    if ([model.commentId intValue] > 0) {
        NSString * str = [NSString stringWithFormat:@"%@回复%@ : %@",model.nickName,model.toNickName,model.replyContent];
        NSRange range1 = NSMakeRange(0, model.nickName.length);
        NSRange range2 = NSMakeRange(model.nickName.length + 2, model.toNickName.length);
        cell.titleLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:3 textColor:[UIColor blackColor] textColorOne:OrangeColor textColorTwo:[UIColor blueColor] nsrangeOne:range1 nsRangeTwo:range2];

    }else {
        NSString * str = [NSString stringWithFormat:@"%@ : %@",model.nickName,model.commentContent];
        cell.titleLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:3 textColor:[UIColor blackColor] textColorTwo:OrangeColor nsrange:NSMakeRange(0,model.nickName.length)];

    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    return;
    [self.TF becomeFirstResponder];
    self.TF.placeholder = [NSString stringWithFormat:@"回复: %@",self.dataArray[indexPath.row].nickName];
    self.isPeople = YES;
    self.indexPath = indexPath;
    
    
}


@end
