//
//  QYZJChoosePeopleTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/23.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJChoosePeopleTVC.h"
#import "FindHeadView.h"
#import "QYZJHomeFiveCell.h"
@interface QYZJChoosePeopleTVC ()
@property(nonatomic,strong)FindHeadView *navigaV;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,strong)NSString *search_word;
@property(nonatomic,assign)CGFloat money;
@property(nonatomic,assign)NSInteger number;
@property(nonatomic,strong)KKKKFootView *footV;
@end

@implementation QYZJChoosePeopleTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择答人";
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeFiveCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeFiveCell"];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    if (self.isSelectOK) {
        
        [self setFootV];
        
    }else {
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 60, 30);
        [button setTitle:@"已选择" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.layer.cornerRadius = 0;
        button.clipsToBounds = YES;
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            QYZJChoosePeopleTVC * vc =[[QYZJChoosePeopleTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isSelectOK = YES;
            vc.type = self.type;
            vc.titleStr = self.titleStr;
            vc.desStr = self.desStr;
            vc.picArr = self.picArr;
            vc.videoStr = self.videoStr;
            vc.strAudionStr = self.strAudionStr;
            NSMutableArray<QYZJFindModel *> * arr = @[].mutableCopy;
            for (QYZJFindModel *model  in self.dataArray) {
                if (model.isSelect) {
                    [arr addObject:model];
                }
            }
            vc.selctArr = arr;
            [self.navigationController pushViewController:vc animated:YES];
           }];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [self addNav];
        
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
    
    
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    CGFloat money = 0;
    NSInteger number = 0;
    for (QYZJFindModel * model  in self.selctArr) {
        if (model.isSelect) {
            if (self.type == 1) {
                money = money + model.question_price;
            }else {
                 money = money + model.appoint_price;
            }
            number = number +1;
        }
        
       
    }
    self.number = number;
    self.money = money;
    NSString * str = [NSString stringWithFormat:@"￥%0.2f",money];
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:str andImgaeName:@""];
    self.footV = view;
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton *button) {
        [weakSelf.tableView endEditing:YES];
        
        BOOL isS = NO;
        for (QYZJFindModel * mm  in self.selctArr) {
            if (mm.isSelect) {
                isS = YES;
                break;
            }
        }
        
        if (!isS) {
            [SVProgressHUD showErrorWithStatus:@"至少选择一个人"];
            return ;
        }
        
        [weakSelf questOrAppiontAction];
    };
    [self.view addSubview:view];
}

- (void)questOrAppiontAction {
    
   
    
    NSString * url = [QYZJURLDefineTool user_addQuestionURL];
    if (self.type == 2) {
        url = [QYZJURLDefineTool user_appointCaipanURL];
    }

    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"title"] = self.titleStr;
    dict[@"context"] = self.desStr;
    dict[@"pic_url"] = [self.picArr componentsJoinedByString:@","];
    dict[@"video_url"] = self.videoStr;
    dict[@"media_url"] = self.strAudionStr;
    NSMutableArray * arr = @[].mutableCopy;
    for (QYZJFindModel * model  in self.selctArr) {
        if (model.isSelect) {
            [arr addObject:model.ID];
        }
    }
    dict[@"b_user_ids"] = [arr componentsJoinedByString: @","];
    dict[@"is_open"] = @(self.isOpen);

    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [self wecharPayWithID:responseObject[@"result"][@"id"]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
}


- (void)wecharPayWithID:(NSString *)ID{
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pay_money"]= @(self.money);
    dict[@"type"] = @(self.type);
    dict[@"id"] = ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_wechatPayURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            QYZJTongYongModel * mm = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
            QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.model = mm;
            vc.ID = ID;
            vc.numer = self.number;
            vc.type = 7 - self.type;
            [self.navigationController pushViewController:vc animated:YES];


        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

    }];
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"type"] = @(3-self.type);
    dict[@"city_id"] = [zkSignleTool shareTool].cityId;
    dict[@"end_type"] = @(self.type - 1);
    dict[@"sort_type"] = @"1";
    dict[@"search_type"] = @(self.type);
    dict[@"search_word"] = self.search_word;
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

- (void)addNav {
    
    self.navigaV = [[FindHeadView alloc] initWithFrame:CGRectMake(0, sstatusHeight, ScreenW, 60)];
    self.navigaV.clipsToBounds = YES;
    self.navigaV.isPresentVC = NO;
    
    self.navigaV.delegateSignal = [RACSubject subject];
     @weakify(self);
    [self.navigaV.delegateSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSDictionary * dict = x;
        if ([[NSString stringWithFormat:@"%@",dict[@"key"]] isEqualToString:@"search"]) {
            //点击搜索
       
            self.search_word = x[@"text"];
            self.page = 0;
            [self getData];

        }
    }];
    self.tableView.tableHeaderView = self.navigaV;;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSelectOK) {
        return self.selctArr.count;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    QYZJHomeFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFiveCell" forIndexPath:indexPath];
    
    if (self.isSelectOK) {
          QYZJFindModel * model  = self.selctArr[indexPath.row];
           cell.model = model;
           cell.imgV.hidden = NO;
           cell.headBtMxCons.constant = 40;
           if (model.isSelect) {
               cell.imgV.image = [UIImage imageNamed:@"xuanze_2"];
           }else {
               cell.imgV.image = [UIImage imageNamed:@"xuanze_1"];
           }
    }else {
        QYZJFindModel * model  = self.dataArray[indexPath.row];
           cell.model = model;
           cell.imgV.hidden = NO;
           cell.headBtMxCons.constant = 40;
           if (model.isSelect) {
               cell.imgV.image = [UIImage imageNamed:@"xuanze_2"];
           }else {
               cell.imgV.image = [UIImage imageNamed:@"xuanze_1"];
           }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isSelectOK) {
        self.selctArr[indexPath.row].isSelect = !self.selctArr[indexPath.row].isSelect;
        CGFloat money = 0;
        NSInteger number = 0;
        for (QYZJFindModel * model  in self.selctArr) {
            if (model.isSelect) {
                if (self.type == 1) {
                    money = money + model.question_price;
               }else {
                    money = money + model.appoint_price;
               }
                number = number +1;
            }
           
           
        }
        self.money = money;
        self.number = number;
        NSString * str = [NSString stringWithFormat:@"￥%0.2f",money];
        self.footV.titleStr = str;
    }else {
      self.dataArray[indexPath.row].isSelect = !self.dataArray[indexPath.row].isSelect;
    }
    
    [self.tableView reloadData];
    
}



@end
