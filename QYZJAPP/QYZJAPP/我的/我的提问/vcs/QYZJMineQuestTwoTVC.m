//
//  QYZJMineQuestTwoTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/23.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineQuestTwoTVC.h"
#import "QYZJMineQuestCell.h"
#import "QYZJMineQuestFiveCell.h"
#import "QYZJMineQyestFourCell.h"
@interface QYZJMineQuestTwoTVC ()<UITextFieldDelegate>
@property(nonatomic,strong)QYZJFindModel *dataModel;

@property(nonatomic,strong)UIView *whiteView;
@property(nonatomic,strong)UITextField *TF;
@property(nonatomic,strong)QYZJTongYongModel * audioModel;
@property(nonatomic,strong)NSString *audioStr;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,strong)UIView *yuYinV;
@property(nonatomic,strong)UIButton *listBt,*closeBt;
@property(nonatomic,strong)KKKKFootView *viewView;
@end



@implementation QYZJMineQuestTwoTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    self.row = -1;
    self.tableView.backgroundColor = self.view.backgroundColor = WhiteColor;
    [self.tableView registerClass:[QYZJMineQuestFiveCell class] forCellReuseIdentifier:@"QYZJMineQuestFiveCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineQyestFourCell" bundle:nil] forCellReuseIdentifier:@"QYZJMineQyestFourCell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    

    [self setFH];
    
    [self getAudioDict];
}

- (void)setFH {
    
    if (!self.isPay) {
        self.whiteView.hidden = YES;
        [self setFootV];
        [self diss];
        
    }else {
        self.viewView.hidden = YES;
        [self setHead];
        
        
    }
    
}


- (void)getAudioDict {
    
    [zkRequestTool getUpdateAudioModelWithCompleteModel:^(QYZJTongYongModel *model) {
        self.audioModel = model;
    }];
    
}

- (void)setHead {
    
    self.whiteView = [[UIView alloc] init];
    
    self.whiteView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.whiteView.mj_w = ScreenW ;
    self.whiteView.mj_h = 60;
    
    self.whiteView.mj_x = 0 ;
    [self.view addSubview:self.whiteView];
    
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60);
    self.whiteView.mj_y = ScreenH - sstatusHeight - 44 - 60 ;
    self.yuYinV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - sstatusHeight - 44 - 60-30, ScreenW, 30)];
    
    if (sstatusHeight > 20) {
         self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 34 - 60);
        self.whiteView.mj_y = ScreenH - sstatusHeight - 44 - 34 - 60 ;
        self.yuYinV.frame = CGRectMake(0, ScreenH - sstatusHeight - 44 - 34- 60-30, ScreenW, 30);
    }
    self.yuYinV.backgroundColor = [UIColor clearColor];
    
    self.listBt = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 200, 25)];
    [self.listBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
    [self.listBt setImage:[UIImage imageNamed:@"sy"] forState:UIControlStateNormal];
    [self.listBt setTitle:@"点击播放" forState:UIControlStateNormal];
    self.listBt.titleLabel.font = kFont(14);
    self.listBt.layer.cornerRadius = 12.5;
    self.listBt.clipsToBounds = YES;
    self.listBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.listBt setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
    [self.listBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0,  0)];
    [self.yuYinV addSubview:self.listBt];
    [self.listBt addTarget:self action:@selector(yuYinAction:) forControlEvents:UIControlEventTouchUpInside];
    self.listBt.tag = 10;
    self.yuYinV.hidden = YES;
    
    self.closeBt = [[UIButton alloc] initWithFrame:CGRectMake(210, 0, 25, 25)];
    [self.closeBt setImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
    [self.yuYinV addSubview:self.closeBt];
    [self.closeBt addTarget:self action:@selector(yuYinAction:) forControlEvents:UIControlEventTouchUpInside];
    self.closeBt.tag = 11;
    
    [self.view addSubview:self.yuYinV];
    
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 10, ScreenW - 30 - 100 , 40)];
    backV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backV];
    backV.layer.cornerRadius = 3;
    backV.clipsToBounds = YES;
    [self.whiteView addSubview:backV];

    self.TF = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, ScreenW - 50 - 100, 30)];
    self.TF.font = kFont(14);
    self.TF.placeholder = @"请输入评论";
    self.TF.delegate = self;
    self.TF.returnKeyType = UIReturnKeySend;
    [backV addSubview:self.TF];

    UIButton  * luYinBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 120, 10, 40, 40)];
    [self.whiteView addSubview:luYinBt];
    [luYinBt addTarget:self action:@selector(luYinAction:) forControlEvents:UIControlEventTouchUpInside];
    [luYinBt setImage:[UIImage imageNamed:@"audioBg"] forState:UIControlStateNormal];
//    self.whiteView.hidden = YES;
    
    UIButton * sendBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW -70, 15, 60, 30)];
    [sendBt setTitle:@"发送" forState:UIControlStateNormal];
    sendBt.titleLabel.font = kFont(14);
    [sendBt setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.whiteView addSubview:sendBt];
    [sendBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
    sendBt.layer.cornerRadius = 4;
    sendBt.clipsToBounds = YES;
    [sendBt addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    
   
    

    
}

- (void)yuYinAction:(UIButton *)button {
    
    if (button.tag == 10) {
        [[PublicFuntionTool shareTool] palyMp3WithNSSting:[QYZJURLDefineTool getVideoURLWithStr:self.audioStr] isLocality:NO];
        [self.listBt setTitle:@"正在播放..." forState:UIControlStateNormal];
        [PublicFuntionTool shareTool].findPlayBlock = ^{
            [button setTitle:@"点击播放" forState:UIControlStateNormal];
        };
        
    }else {
        self.audioStr = nil;
        self.yuYinV.hidden = YES;
    }
    
    
}


//- (void)show {
//
//    if (sstatusHeight > 20) {
//          self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - sstatusHeight -44 - 34 - 60);
//          self.whiteView.mj_y = ScreenH - sstatusHeight -44 - 34  - 60;
//      }else {
//          self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH -44 - sstatusHeight-60);
//          self.whiteView.mj_y = ScreenH - sstatusHeight  - 44-60;
//      }
//    self.whiteView.hidden = NO;
//}

- (void)diss {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH );
    self.whiteView.hidden = YES;
    self.TF.text = @"";
    self.audioStr = nil;
}

- (void)luYinAction:(UIButton *)button {
    
    self.audioStr = nil;
    
    
    [[QYZJLuYinView LuYinTool] show];
    Weak(weakSelf);
    [QYZJLuYinView LuYinTool].statusBlock = ^(BOOL isStare,NSData *mediaData) {
        
        dispatch_async(dispatch_get_main_queue() , ^{
            if (isStare) {
                weakSelf.navigationItem.title = @"正在录音...";
            }else {
                weakSelf.navigationItem.title = @"详情";
                
                if (mediaData.length == 4096) {
                  return ;
                }
                
                [weakSelf updateLoadMediaWithData:mediaData ];
                [[QYZJLuYinView LuYinTool] diss];
                
            }
        });
        
        
    };
    
    
}

- (void)updateLoadMediaWithData:(NSData *)data {
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = self.audioModel.token;
    [zkRequestTool NetWorkingUpLoadMediaWithfileData:data parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        self.audioStr = responseObject[@"key"];
        [self.tableView reloadData];
        self.yuYinV.hidden = NO;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"\n\n------%@",error);
    }];
}




- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.model.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_questionInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.dataModel = [QYZJFindModel mj_objectWithKeyValues:responseObject[@"result"]];

            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"支付" andImgaeName:@""];
    self.viewView = view;
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton *button) {
        [weakSelf.tableView endEditing:YES];
        
        [weakSelf wecharPay];
        
    };
    [self.view addSubview:view];
}

- (void)wecharPay {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pay_money"]= @(self.model.pay_money);
    dict[@"type"] = @(1);
    dict[@"id"] = self.model.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_wechatPayURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            QYZJTongYongModel * mm = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
            QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.model = mm;
            vc.ID = self.model.ID;
            vc.type = 6;
            Weak(weakSelf);
            vc.isBaoBlcok = ^{
                weakSelf.isPay = YES;
                [weakSelf setFH];
            };
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 10;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = RGB(245, 245, 245);
    }
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataModel.answer_list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return UITableViewAutomaticDimension;
    }
    return self.dataModel.answer_list[indexPath.row].cellHeight;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        QYZJMineQyestFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineQyestFourCell" forIndexPath:indexPath];
        cell.titleLB.text = self.dataModel.title;
        cell.contentLB.text = self.dataModel.context;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else {
        QYZJMineQuestFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMineQuestFiveCell" forIndexPath:indexPath];
        self.dataModel.answer_list[indexPath.row].is_pay = NO;
        cell.model = self.dataModel.answer_list[indexPath.row];
        [cell.replyBt addTarget:self  action:@selector(replyAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.replyBt.tag = indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.listBt addTarget:self action:@selector(listAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.listBt.tag = indexPath.row;
        return cell;
        
    }
    
    
}


- (void)listAction:(UIButton *)button {
    
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
           [button setTitle:@"回复语音" forState:UIControlStateNormal];
       };
}

//点击回复
- (void)replyAction:(UIButton *)button {
    self.row = button.tag;
//    [self show];
    
    self.TF.placeholder = [NSString stringWithFormat:@"回复:%@",self.dataModel.answer_list[button.tag].a_nick_name];
    [self.TF becomeFirstResponder];
}

//回复
- (void)sendAction:(UIButton *)button {
    
    if (self.audioStr.length == 0 && self.TF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"语音和文字回复必须有一个"];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"question_id"] = self.model.ID;
    dict[@"media_url"] = self.audioStr;
    dict[@"contents"] = self.TF.text;
    
    if (self.row == -1) {
        dict[@"type"] = @"0";
    }else {
       dict[@"to_id"] = self.dataModel.answer_list[self.row].ID;
        if (self.model.is_answer == 2) {
           dict[@"type"] = @"1";
        }else {
           dict[@"type"] = @"2";
        }
    }
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_replyQuestionURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            if (self.model.is_answer == 1) {
                [self wecharPayWithID:responseObject[@"result"][@"id"]];
            }else {
                [SVProgressHUD showSuccessWithStatus:@"回复成功"];
                self.row = -1;
                self.TF.placeholder = @"回复提问";
                [self.tableView endEditing:YES];
            }
            [self getData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
}


- (void)wecharPayWithID:(NSString *)ID {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
//    dict[@"pay_money"]= @(self.money);
    dict[@"type"] = @(1);
    dict[@"id"] = ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_wechatPayURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            QYZJTongYongModel * mm = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
            QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.model = mm;
            vc.ID = ID;
            vc.type = 4;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && self.model.is_answer == 2) {
        self.row = -1;
        self.TF.placeholder = @"回复提问";
    }
    
}


@end
