//
//  QYZJCreateShiGongQingDanTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/25.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJCreateShiGongQingDanTVC.h"
#import "QYZJRecommendTwoCell.h"
#import "QYZJShowFromTopView.h"
@interface QYZJCreateShiGongQingDanTVC ()<zkPickViewDelelgate,UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,strong)NSArray *leftArrOne;
@property(nonatomic,strong)NSArray *leftArrTwo;
@property(nonatomic,strong)NSArray * placeArrOne;
@property(nonatomic,strong)NSArray *placeArrTwo;
@property(nonatomic,strong)NSArray *rightArr;
@property(nonatomic,strong)QYZJFindModel *dataModel;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,strong)UIView *tableViewFootV;


@end

@implementation QYZJCreateShiGongQingDanTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"创建施工清单";
    self.leftArrOne = @[@"标题",@"备注",@"总价",@"工期",@"时间段"];
    self.leftArrTwo = @[@"施工阶段",@"付款比例",@"阶段金额",@"工期",@"时间段"];
    self.placeArrOne =@[@"请输入标题",@"请输入备注",@"元",@"天",@"请选择开始时间"];
    self.placeArrTwo = @[@"施工阶段",@"%",@"元",@"天",@"时间段"];
    
    
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[QYZJRecommendTwoCell class] forCellReuseIdentifier:@"QYZJRecommendTwoCell"];
    
    [self addFootV];
    
    self.dataModel = [[QYZJFindModel alloc] init];
    self.dataArray = @[].mutableCopy;
    [self.dataArray addObject:[[QYZJFindModel alloc] init]];
    
}

- (void)addFootV {
    
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"发起交付" andImgaeName:@""];
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton * _Nonnull button) {
        
    };
    [self.view addSubview:view];
    self.tableView.backgroundColor = [UIColor whiteColor];
    UIView * footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    self.tableViewFootV = footV;
    UIButton * bt = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 15, 40)];
    [footV addSubview:bt];
    [bt setImage:[UIImage imageNamed:@"18"] forState:UIControlStateNormal];
    bt.titleLabel.font = kFont(14);
    [bt setTitle:@"添加新的施工工期,付款比例,工期,时间段" forState:UIControlStateNormal];
    [bt setTitleColor:OrangeColor forState:UIControlStateNormal];
    [bt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [bt setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [bt addTarget:self action:@selector(addJieDuan) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.tableView.tableFooterView = footV;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1+self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.leftArrOne.count;
    }
    
    return self.leftArrTwo.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 && indexPath.section == 0) {
        return 80;
    }
    return 50;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = RGB(245, 245, 245);
    }
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1 && indexPath.section ==0) {
        QYZJRecommendTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QYZJRecommendTwoCell" forIndexPath:indexPath];
        cell.clipsToBounds = YES;
        cell.TV.delegate = self;
        cell.TV.text = self.dataModel.context;
        return cell;
    }else {
        TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.rightLB.hidden = YES;
        cell.swith.hidden = YES;
        cell.TF.userInteractionEnabled = YES;
        cell.moreImgV.hidden = YES;
        if (indexPath.section ==0) {
            cell.leftLB.text = self.leftArrOne[indexPath.row];
            cell.TF.placeholder = self.placeArrOne[indexPath.row];
            if (indexPath.row < 4 ) {
                if (indexPath.row == 2){
                    if (self.dataModel.price>0) {
                        cell.TF.text = [NSString stringWithFormat:@"%0.2f元",self.dataModel.price];
                    }else {
                        cell.TF.text = [NSString stringWithFormat:@"%@",@""];
                    }
                    cell.TF.keyboardType =  UIKeyboardTypeDecimalPad;
                }else  if (indexPath.row == 3) {
                    if (self.dataModel.all_days>0) {
                        cell.TF.text = [NSString stringWithFormat:@"%0.0f天",self.dataModel.all_days];
                    }else {
                        cell.TF.text = @"";
                    }
                    cell.TF.keyboardType =  UIKeyboardTypeNumberPad;
                }
            }else {
                cell.moreImgV.hidden = NO;
                cell.TF.userInteractionEnabled = NO;
                if (self.dataModel.time_start.length == 0) {
                    cell.TF.text = @"";
                }else {
                    cell.TF.text = [NSString stringWithFormat:@"%@到%@",self.dataModel.time_start,self.dataModel.time_end];
                }
            }
        }else {
            cell.leftLB.text = self.leftArrTwo[indexPath.row];
            cell.TF.placeholder = self.placeArrTwo[indexPath.row];
            QYZJFindModel * model = self.dataArray[indexPath.section-1];
            cell.TF.userInteractionEnabled = YES;
            if (indexPath.row < 4 ) {
                
                if (indexPath.row == 0){
                    cell.TF.text = model.stage_name;
                    cell.TF.userInteractionEnabled = NO;
                }else  if (indexPath.row == 1){
                    if (model.percent>0) {
                        cell.TF.text = [NSString stringWithFormat:@"%0.2f%%",model.percent];
                    }else {
                        cell.TF.text = @"";
                    }
                    cell.TF.keyboardType =  UIKeyboardTypeDecimalPad;
                    cell.TF.userInteractionEnabled = NO;
                }else  if (indexPath.row == 2){
                    if (model.percent>0) {
                        cell.TF.text = [NSString stringWithFormat:@"%0.2f元",model.percent * self.dataModel.price];
                    }else {
                        cell.TF.text = @"";
                    }
                    cell.TF.userInteractionEnabled = NO;
                }else  if (indexPath.row ==3) {
                    if (model.days>0) {
                        cell.TF.text = [NSString stringWithFormat:@"%0.0f天",model.days];
                    }else {
                        cell.TF.text = [NSString stringWithFormat:@"%@",@""];
                    }
                    cell.TF.keyboardType =  UIKeyboardTypeNumberPad;
                }
            }else {
                cell.moreImgV.hidden = NO;
                cell.TF.userInteractionEnabled = NO;
                if (model.time_start.length == 0) {
                    cell.TF.text = @"";
                }else {
                    cell.TF.text = [NSString stringWithFormat:@"%@到%@",model.time_start,model.time_end];
                }
                
            }
            
            
        }
        cell.TF.delegate = self;
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView endEditing:YES];
    if (indexPath.section > 0 ) {
        
        if (self.dataModel.price == 0 || self.dataModel.all_days == 0) {
            [SVProgressHUD showErrorWithStatus:@"请先填写总工期和总价"];
            return;
        }
        
        if (indexPath.row == 0) {
            QYZJShowFromTopView * view = [[QYZJShowFromTopView alloc] initWithFrame:CGRectMake(0, 0 , ScreenW, ScreenH)];
            [self.view addSubview:view];
            view.dataArray = @[@"查改",@"2",@"3",@"a",@"b",@"c"];
            view.subject = [[RACSubject alloc] init];
            //点击
            @weakify(self);
            [view.subject subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                self.dataArray[indexPath.section - 1].stage_name = x;
                [self.tableView reloadData];
            }];
            [view show];
        }else  if (indexPath.row == 4){
            
            if (self.dataArray[indexPath.section-1].days==0) {
                [SVProgressHUD showErrorWithStatus:@"请先填写工期"];
                return;
            }else {
                
                SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
                selectTimeV.isCanSelectOld = NO;
                selectTimeV.isCanSelectToday = YES;
                Weak(weakSelf);
                selectTimeV.block = ^(NSString *timeStr) {
                    self.dataArray[indexPath.section-1].time_start = timeStr;
                    
                    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                    NSDate * nowDate = [dateFormatter dateFromString:timeStr];
                    
                    NSTimeInterval  oneDay = 24 * 60 * 60 * 1;
                    
                    NSDate * otherDate = [nowDate initWithTimeIntervalSinceNow: +(oneDay* self.dataArray[indexPath.section-1].days)];
                    self.dataArray[indexPath.section-1].time_end = [dateFormatter stringFromDate:otherDate];
                    [weakSelf.tableView reloadData];
                };
                [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
                
                
            }
            
        }
        
        
        
    }else {
        if (indexPath.row == 4) {
            
            if (self.dataModel.all_days == 0) {
                [SVProgressHUD showErrorWithStatus:@"请先填写总工期"];
                return;
            }
            
            SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
            selectTimeV.isCanSelectOld = NO;
            selectTimeV.isCanSelectToday = YES;
            Weak(weakSelf);
            selectTimeV.block = ^(NSString *timeStr) {
                self.dataModel.time_start = timeStr;
                NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate * nowDate = [dateFormatter dateFromString:timeStr];
                NSTimeInterval  oneDay = 24 * 60 * 60 * 1;
                NSDate * otherDate = [nowDate initWithTimeIntervalSinceNow: +(oneDay* self.dataModel.all_days)];
                self.dataModel.time_end = [dateFormatter stringFromDate:otherDate];
                [weakSelf.tableView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
            
        }
        
    }
    
    
    
}

#pragma mark ---- 添加新阶段 ----
- (void)addJieDuan {
    
    if (self.dataModel.title.length == 0||self.dataModel.context.length == 0 || self.dataModel.all_days == 0 || self.dataModel.price == 0) {
        [SVProgressHUD showErrorWithStatus:@"信息填写不完整"];
        return ;
    }
    if ([self cheackFullMessage]) {
        QYZJFindModel * model = [[QYZJFindModel alloc] init];
        [self.dataArray addObject:model];
        [self.tableView reloadData];
    }
    
    
    
    
    
}


#pragma mark ---- 点击完成 ----
- (void)clickAction:(UIButton *)button {
    if (self.dataModel.title.length == 0||self.dataModel.context.length == 0 || self.dataModel.all_days == 0 || self.dataModel.price == 0) {
        [SVProgressHUD showErrorWithStatus:@"信息填写不完整"];
        return ;
    }
    
    if ([self cheackFullMessage]) {
        [self createStageAction];
    }
    
    
    
}

- (BOOL)cheackFullMessage {
    for (QYZJFindModel *model  in self.dataArray) {
        if (model.stage_name.length == 0 || model.percent == 0 || model.days == 0 || model.time_start.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"信息填写不完整"];
            return NO;
        }
    }
    return YES;
    
}

- (void)createStageAction {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"title"] = self.dataModel.title;
    dict[@"content"] = self.dataModel.context;
    dict[@"all_price"] = @(self.dataModel.price);
    dict[@"all_days"] = @(self.dataModel.all_days);
    dict[@"all_time_start"] = self.dataModel.time_start;
    dict[@"all_time_end"] = self.dataModel.time_end;
    dict[@"turnover_id"] = self.ID;
    dict[@"list"] = [self listStr];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_createStageURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}

- (NSString *)listStr {
    NSMutableArray * dataArr = @[].mutableCopy;
    for (QYZJFindModel * model  in self.dataArray) {
        NSMutableDictionary * dict = @{}.mutableCopy;
        dict[@"stage_name"] = model.stage_name;
        dict[@"percent"] = @(model.percent);
        dict[@"days"] = model.pro_id;
        dict[@"city_id"] = @(model.days);
        dict[@"time_start"] = model.time_start;
        dict[@"time_end"] = model.time_end;
        [dataArr addObject:dict];
    }
    
    NSString * str = [NSString convertToJsonDataWithDict:dataArr];
    return str;
}


#pragma mark ----- 输入描述结束 -----
- (void)textViewDidEndEditing:(UITextView *)textView {
    
    self.dataModel.context = textView.text;
    [self.tableView reloadData];
    
    
}
#pragma mark --- 填写内容结束时 ----
- (void)textFieldDidEndEditing:(UITextField *)textField {
    TongYongTwoCell * cell = (TongYongTwoCell *)textField.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    
    if (indexPath.section > 0) {
        QYZJFindModel * model = self.dataArray[indexPath.section-1];
        if (indexPath.row == 1) {
            model.percent = [textField.text floatValue];
            if ([self cheackPercentWithStr] == 0) {
                model.percent = [textField.text floatValue];
                self.tableViewFootV.hidden = NO;
            }else if ([self cheackPercentWithStr] == 2){
                [SVProgressHUD showErrorWithStatus:@"总比之和不能超过100%"];
                model.percent = 0;
                self.tableViewFootV.hidden = NO;
            }else {
                model.percent = [textField.text floatValue];
                self.tableViewFootV.hidden = YES;
            }
            [self.tableView reloadData];
        }else if (indexPath.row == 3) {
            model.days = [textField.text floatValue];
            if (![self cheackDayWithDay]) {
                model.days = 0;
            }
            
            [self.tableView reloadData];
        }
    }else {
        
        if (indexPath.row == 0) {
            self.dataModel.title = textField.text;
        }else if (indexPath.row == 2) {
            self.dataModel.price = [textField.text floatValue];
        }else if (indexPath.row == 3) {
            self.dataModel.all_days = [textField.text floatValue];
        }
        
        [self.tableView reloadData];
        
    }
    
    
    
    
}

//检测比例 0 小于 100% 1 等于100% 2 大于100%
- (NSInteger )cheackPercentWithStr{
    
    CGFloat all = 0;
    for (int i = 0 ; i < self.dataArray.count ; i++) {
        all = self.dataArray[i].percent + all;
    }
    if (all >100) {
        return 2;
    }else if (all == 100) {
        return 1;
    }else {
        return 0;
    }
}
//检测工期
- (BOOL)cheackDayWithDay{
    CGFloat all = 0;
    for (int i = 0 ; i < self.dataArray.count; i++) {
        all = self.dataArray[i].days + all;
    }
    
    if (self.dataModel.all_days < all) {
        return NO;
    }
    return YES;
}



@end
