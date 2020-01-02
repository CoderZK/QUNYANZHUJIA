//
//  QYZJFangDanTwoTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFangDanTwoTVC.h"
#import "QYZJRecommendTwoCell.h"
#import "QYZJRecommendFootV.h"
@interface QYZJFangDanTwoTVC ()<zkPickViewDelelgate,UITextFieldDelegate,UITextViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)NSMutableArray<QYZJTongYongModel *> *quDaoArr;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *LeiXingArr;
@property(nonatomic,strong)NSArray *leftArr,*placeholdArr,*chooseArr;
@property(nonatomic,strong)QYZJRecommendFootV *footV;
@property(nonatomic,strong)QYZJMoreChooseView *moreChooseV;
@property(nonatomic,assign)NSInteger needType,styleType,houseType;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)QYZJTongYongModel * audioModel;
@end

@implementation QYZJFangDanTwoTVC

- (NSMutableArray<zkPickModel *> *)LeiXingArr {
    if (_LeiXingArr == nil) {
        _LeiXingArr = [NSMutableArray array];
    }
    return _LeiXingArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"放单";
    self.leftArr = @[@"小区名称",@"推荐渠道",@"需求类型",@"风格",@"户型",@"装修时间",@"建筑面积",@"预算",@"描述",@"姓名",@"是否实名推荐",@"是否通知被推荐人"];
    self.placeholdArr = @[@"请输入小区名称",@"请选择分类(可多选)",@"请选择需求类型",@"请选择风格",@"请选择户型",@"请选择装修时间",@"请输入建筑面积",@"请输入预算",@"请输入描述",@"请输入真实姓名",@"",@""];
    self.quDaoArr = [NSMutableArray mutableCopy];
    
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[QYZJRecommendTwoCell class] forCellReuseIdentifier:@"QYZJRecommendTwoCell"];
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getQuDaoArrList];
    [self getLeiXingArrList];
    
    
    [self setFootV];
    [self setTableViewFootView];
    self.moreChooseV = [[QYZJMoreChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [self getAudioDict];
    
    
}

- (void)getAudioDict {
    
    [zkRequestTool getUpdateAudioModelWithCompleteModel:^(QYZJTongYongModel *model) {
        self.audioModel = model;
    }];
    
}

- (void)setTableViewFootView {
    
    self.footV = [[QYZJRecommendFootV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 120)];
    Weak(weakSelf);
    self.footV.clickRecommendFootVBlock = ^{
        if ([weakSelf checkData]) {
            QYZJFindModel * model = [[QYZJFindModel alloc] init];
            [weakSelf.dataArray addObject:model];
            if (weakSelf.addDemndBlock != nil) {
                weakSelf.addDemndBlock(weakSelf.dataArray);
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }
    };
    self.tableView.tableFooterView = self.footV;
}

- (void)getQuDaoArrList {
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_labelListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.quDaoArr = [QYZJTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


- (BOOL)checkData {
    for (QYZJFindModel  * model in self.dataArray) {
        if (model.community_name.length == 0 || model.role_ids.length == 0 || model.type_id == 0 || model.manner_id == 0 || model.house_model_id == 0 || model.renovation_time_id == 0 || model.area.length == 0 || model.budget <= 0 || model.demand_context.length == 0 || model.b_recomend_name.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请填写全信息"];
            return NO;
            
        }
    }
    return YES;
}



- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"完成" andImgaeName:@""];
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton *button) {
        [weakSelf.tableView endEditing:YES];
        
        [weakSelf clickAction:button];
        
    };
    [self.view addSubview:view];
}


- (void)getLeiXingArrList {
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_demandTypeListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.LeiXingArr = [zkPickModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 8) {
        return 135;
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
    
    if (indexPath.row == 8) {
        QYZJRecommendTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QYZJRecommendTwoCell" forIndexPath:indexPath];
        cell.TV.text = self.dataArray[indexPath.section].demand_context;
        cell.TV.delegate = self;
        [cell.luyinBt addTarget:self action:@selector(luYinAction:) forControlEvents:UIControlEventTouchUpInside];
               [cell.listBt addTarget:self action:@selector(listAction:) forControlEvents:UIControlEventTouchUpInside];
               if (self.dataArray[indexPath.section].mediaUrl.length == 0) {
                   cell.listBt.hidden = YES;
               }else {
                   cell.listBt.hidden = NO;
                   [cell.listBt setTitle:@"语音描述" forState:UIControlStateNormal];
               }
               return cell;
        return cell;
    }else {
        TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.leftLB.text = self.leftArr[indexPath.row];
        cell.TF.keyboardType= UIKeyboardTypeDefault;
        cell.TF.delegate = self;
        cell.swith.userInteractionEnabled = NO;
        cell.TF.hidden = NO;
        cell.TF.placeholder = self.placeholdArr[indexPath.row];
        cell.TF.userInteractionEnabled = NO;
        cell.moreImgV.hidden = NO;
        cell.TF.mj_w = ScreenW - 150;
        cell.swith.hidden = YES;
        if (indexPath.row == 0 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 9) {
            if  (indexPath.row == 6 || indexPath.row == 9) {
                cell.TF.keyboardType =  UIKeyboardTypeDecimalPad;
            }
            cell.moreImgV.hidden = YES;
            cell.TF.mj_w = ScreenW - 120;
            cell.TF.userInteractionEnabled = YES;
        }else if (indexPath.row == 11||indexPath.row == 10) {
            cell.swith.hidden = NO;
            cell.leftLB.mj_w = 200;
            cell.moreImgV.hidden = cell.TF.hidden =  YES;
        }
        [self setTitleWithCell:cell WithIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}


//播放
- (void)listAction:(UIButton *)button {
    
       QYZJRecommendTwoCell * cell = (QYZJRecommendTwoCell *)button.superview;
       NSIndexPath  * indexPath = [self.tableView indexPathForCell:cell];
       QYZJFindModel * model = self.dataArray[indexPath.section];
       [[PublicFuntionTool shareTool] palyMp3WithNSSting:[QYZJURLDefineTool getVideoURLWithStr:model.mediaUrl] isLocality:NO];
       [button setTitle:@"正在播放..." forState:UIControlStateNormal];
       [PublicFuntionTool shareTool].findPlayBlock = ^{
           [button setTitle:@"点击播放" forState:UIControlStateNormal];
       };
}


- (void)luYinAction:(UIButton *)button {

    QYZJRecommendTwoCell * cell = (QYZJRecommendTwoCell *)button.superview;
    NSIndexPath  * indexPath = [self.tableView indexPathForCell:cell];

    
    [[QYZJLuYinView LuYinTool] show];
               Weak(weakSelf);
               [QYZJLuYinView LuYinTool].statusBlock = ^(BOOL isStare,NSData *mediaData) {
       
                   dispatch_async(dispatch_get_main_queue() , ^{
                       if (isStare) {
                           weakSelf.navigationItem.title = @"正在录音...";
                       }else {
                           
                            weakSelf.navigationItem.title = @"预约表单";
//
//                           NSString * firlpath = [[NSBundle mainBundle] pathForResource:@"8888" ofType:@"mp3"];
//                           NSData * dd = [NSData dataWithContentsOfFile:firlpath];
//                           [weakSelf updateLoadMediaWithData:dd];
                           if (mediaData.length == 4096) {
                                return ;
                            }
                           
                          
                               [weakSelf updateLoadMediaWithData:mediaData WithIndexPath:indexPath];
                               [[QYZJLuYinView LuYinTool] diss];
                           
                           
                          
                           
                       }
                   });
       
       
               };
    
    
}





- (void)updateLoadMediaWithData:(NSData *)data WithIndexPath:(NSIndexPath*)indexPath{
           NSMutableDictionary * dict = @{}.mutableCopy;
           dict[@"token"] = self.audioModel.token;
           [zkRequestTool NetWorkingUpLoadMediaWithfileData:data parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
               [SVProgressHUD showSuccessWithStatus:@"上传音频成功"];
               self.dataArray[indexPath.section].mediaUrl = responseObject[@"key"];
               [self.tableView reloadData];
               
           } failure:^(NSURLSessionDataTask *task, NSError *error) {
               NSLog(@"\n\n------%@",error);
           }];
}




- (void)setTitleWithCell:(TongYongTwoCell *)cell WithIndexPath:(NSIndexPath * )indexPath {
    
    NSInteger row = indexPath.row;
    QYZJFindModel * model = self.dataArray[indexPath.section];
    if (row == 0) {
        cell.TF.text = model.community_name;
    }else if (row == 1) {
        cell.TF.text = model.role_strs;
    }else if (row == 2) {
        if (model.type_id > 0 && self.LeiXingArr.count >= model.type_id) {
            cell.TF.text = self.LeiXingArr[model.type_id -1].name;
        }else {
            cell.TF.text = @"";
        }
    } else if (row == 3) {
        if (model.manner_id >0 && [zkSignleTool shareTool].mannerArr.count >= model.manner_id) {
            cell.TF.text = [zkSignleTool shareTool].mannerArr[model.manner_id-1];
        }else {
            cell.TF.text = @"";
        }
    }else if (row == 4) {
        if (model.house_model_id>0 && [zkSignleTool shareTool].houseModelArr.count >= model.house_model_id) {
            cell.TF.text = [zkSignleTool shareTool].houseModelArr[model.house_model_id-1];
        }else {
            cell.TF.text = @"";
        }
    }else if (row == 5) {
        if (model.renovation_time_id >0 && [zkSignleTool shareTool].renvoationTimeArr.count >= model.renovation_time_id) {
            cell.TF.text = [zkSignleTool shareTool].renvoationTimeArr[model.renovation_time_id-1];
        }else {
            cell.TF.text = @"";
        }
    }else if (row == 6) {
        cell.TF.text = [NSString stringWithFormat:@"%@",model.area.length > 0 ? model.area:@""];
    }else if (row == 7) {
        if(model.budget == 0) {
            cell.TF.text = @"";
        }else {
            cell.TF.text = [NSString stringWithFormat:@"%0.2f元",model.budget];
        }
    }else if (row == 8) {
        cell.TF.text = model.demand_context;
    }else if (row == 9) {
        cell.TF.text = model.b_recomend_name;
    }else if (row == 10) {
        cell.swith.on = model.is_realname;
    }else if (row == 11) {
        cell.swith.on = model.is_notice;
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.indexPath = indexPath;
    [self.tableView endEditing:YES];
    
    
    if (indexPath.row == 1) {
        self.moreChooseV.dataArray = self.quDaoArr;
        Weak(weakSelf);
        self.moreChooseV.chooseViewMoreBlockFinsh = ^{
            NSMutableArray * arr = @[].mutableCopy;
            NSMutableArray * arrTwo = @[].mutableCopy;
            for (QYZJTongYongModel  * tModel in weakSelf.quDaoArr) {
                if (tModel.isSelect) {
                    [arr addObject:tModel.ID];
                    [arrTwo addObject:tModel.name];
                }
            }
            weakSelf.dataArray[indexPath.section].role_ids = [arr componentsJoinedByString:@","];
            weakSelf.dataArray[indexPath.section].role_strs = [arrTwo componentsJoinedByString:@","];
            [weakSelf.tableView reloadData];
        };
        [self.moreChooseV show];
    }else if (indexPath.row == 2) {
        if (self.LeiXingArr.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"获取类型中,请先填写其它内容"];
            [self getLeiXingArrList];
            return;
        }
        zkPickView * picker = [[zkPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self;
        picker.arrayType = NormalArray;
        picker.array = self.LeiXingArr;
        picker.selectLb.text = @"";
        [picker show];
        
        
    }else if (indexPath.row == 3) {
        if ([self isCanChoose]) {
            zkPickView * picker = [[zkPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            picker.delegate = self;
            picker.arrayType = titleArray;
            picker.array = [zkSignleTool shareTool].mannerArr.mutableCopy;
            picker.selectLb.text = @"";
            [picker show];
        }
    }else if (indexPath.row == 4) {
        if ([self isCanChoose]) {
            zkPickView * picker = [[zkPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            picker.delegate = self;
            picker.arrayType = titleArray;
            picker.array =[zkSignleTool shareTool].houseModelArr.mutableCopy;
            picker.selectLb.text = @"";
            [picker show];
        }
        
        
    }else if (indexPath.row == 5) {
        if ([self isCanChoose]) {
            zkPickView * picker = [[zkPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            picker.delegate = self;
            picker.arrayType = titleArray;
            picker.array =[zkSignleTool shareTool].renvoationTimeArr.mutableCopy;
            picker.selectLb.text = @"";
            [picker show];
        }
    }else if (indexPath.row == 10) {
        self.dataArray[indexPath.section].is_realname = !self.dataArray[indexPath.section].is_realname;
        [self.tableView reloadData];
        
    }else if (indexPath.row == 11) {
        self.dataArray[indexPath.section].is_notice = !self.dataArray[indexPath.section].is_notice;
        [self.tableView reloadData];
    }
    
    
    
}

#pragma mark ---- 点击完成 ----
- (void)clickAction:(UIButton *)button {
    if ([self checkData]) {
        NSMutableArray * dataArr = @[].mutableCopy;
        for (QYZJFindModel * model  in self.dataArray) {
            NSMutableDictionary * dict = @{}.mutableCopy;
            dict[@"b_recomend_phone"] = model.telphone;
            dict[@"b_recomend_name"] = model.b_recomend_name;
            dict[@"pro_id"] = model.pro_id;
            dict[@"city_id"] = model.city_id;
            dict[@"area_id"] = model.area_id;
            dict[@"address"] = model.b_recomend_address;
            dict[@"type_id"] = @(model.type_id);
            dict[@"area"] = model.area;
            dict[@"demand_context"] = model.demand_context;
            dict[@"role_ids"] = model.role_ids;
            dict[@"address_pca"] = model.address_pca;
            if (model.is_realname) {
                dict[@"value1"] = @"ture";
                dict[@"is_realname"] = @(1);
            }else {
                dict[@"value1"] = @"false";
                dict[@"is_realname"] = @(0);
            }
            if (model.is_notice) {
                dict[@"value2"] = @"ture";
                dict[@"is_notice"] = @(1);
            }else {
                dict[@"value2"] = @"false";
                dict[@"is_notice"] = @(0);
            }
            
            dict[@"manner_id"] = @(model.manner_id);
            dict[@"house_model_id"] = @(model.house_model_id);
            dict[@"renovation_time_id"] = @(model.renovation_time_id);
            dict[@"budget"] = @(model.budget);
            dict[@"commission_type"] = @(1);
            dict[@"community_name"] = model.community_name;
            dict[@"demand_voice"] = model.mediaUrl;
            [dataArr addObject:dict];
        }
        
        NSString * str = [NSString convertToJsonDataWithDict:dataArr];
        
        NSLog(@"list \n\n\n\n ----- %@",str);
        [self addDemandActionWithListStr:str];
        
        
    }else {
        [SVProgressHUD showErrorWithStatus:@"信息填写不完整"];
    }
    
    
    
}

- (void)addDemandActionWithListStr:(NSString *)listStr {
    
    if (self.footV.codeStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"mobile_code"] = self.footV.codeStr;
    dict[@"list"] = listStr;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_addDemandURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"添加单子成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}


#pragma mark ------- 点击筛选 ------
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex{
    
    NSLog(@"%d---%d----%d",leftIndex,centerIndex,rightIndex);
    
    QYZJFindModel  * model = self.dataArray[self.indexPath.section];
    if (self.indexPath.row == 2) {
        model.type_id = leftIndex+1;
    }else if (self.indexPath.row == 3) {
        model.manner_id = leftIndex+1;
    }else if (self.indexPath.row == 4) {
        model.house_model_id = leftIndex +1;
    }else if (self.indexPath.row == 5) {
        model.renovation_time_id = leftIndex+1;
    }
    
    [self.tableView reloadData];
    
    
}

#pragma mark ----- 输入描述结束 -----
- (void)textViewDidEndEditing:(UITextView *)textView {
    
    TongYongTwoCell  * cell = (TongYongTwoCell *)textView.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QYZJFindModel * model = self.dataArray[indexPath.section];
    model.demand_context = textView.text;
    
}
#pragma mark --- 填写内容结束时 ----
- (void)textFieldDidEndEditing:(UITextField *)textField {
    TongYongTwoCell  * cell = (TongYongTwoCell *)textField.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QYZJFindModel * model = self.dataArray[indexPath.section];
    if (indexPath.row == 0) {
        model.community_name = textField.text;
    }else if (indexPath.row == 6) {
        model.area = textField.text;
    }else if (indexPath.row == 7) {
        model.budget = [textField.text floatValue];
    }else if (indexPath.row == 9){
        model.b_recomend_name = textField.text;
    }
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    TongYongTwoCell  * cell = (TongYongTwoCell *)textField.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    if (indexPath.row == 6 || indexPath.row == 7) {
        NSMutableString *futureString = [NSMutableString stringWithString:textField.text];
           [futureString insertString:string atIndex:range.location];
           
        if ([futureString containsString:@"-"]) {
            return NO;
        }
           NSInteger flag = 0;
           // 这个可以自定义,保留到小数点后两位,后几位都可以
           const NSInteger limited = 2;
           
           for (NSInteger i = futureString.length - 1; i >= 0; i--) {
               
               if ([futureString characterAtIndex:i] == '.') {
                   // 如果大于了限制的就提示
                   if (flag > limited) {
                       
                       [SVProgressHUD showErrorWithStatus:@"请输入最多两位小数的数值"];
                       return NO;
                   }
                   
                   break;
               }
               
               flag++;
           }
    }
    
    
    
    
   
    
    return YES;
}


@end
