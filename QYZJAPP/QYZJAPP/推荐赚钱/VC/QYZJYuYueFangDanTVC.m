//
//  QYZJYuYueFangDanTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/22.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJYuYueFangDanTVC.h"
#import "QYZJRecommendTwoCell.h"
#import "QYZJRecommendFootV.h"
@interface QYZJYuYueFangDanTVC ()<zkPickViewDelelgate,UITextFieldDelegate,UITextViewDelegate,zkPickViewDelelgate>
@property(nonatomic,strong)NSMutableArray<QYZJTongYongModel *> *quDaoArr;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *LeiXingArr;
@property(nonatomic,strong)NSArray *leftArr,*placeholdArr,*chooseArr;
@property(nonatomic,strong)QYZJRecommendFootV *footV;
@property(nonatomic,strong)QYZJMoreChooseView *moreChooseV;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *cityArray;
@property(nonatomic,strong)QYZJFindModel *dataModel;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)QYZJTongYongModel * audioModel;
@property(nonatomic,strong)NSString *audioStr;
@end

@implementation QYZJYuYueFangDanTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataModel = [[QYZJFindModel alloc] init];
    self.navigationItem.title = @"预约表单";
    self.leftArr = @[@"地址",@"小区名称",@"需求类型",@"建筑面积",@"描述",@"风格",@"户型",@"装修时间",@"预算",@"服务分类"];
    self.placeholdArr = @[@"请选择地址",@"请输入小区名称",@"请选择需求类型",@"请输入建筑面积",@"请输入描述",@"请选择风格",@"请选择户型",@"请选择装修时间",@"请输入预算",@"请选择服务分类分类(可多选)"];
    self.quDaoArr = [NSMutableArray mutableCopy];
    self.LeiXingArr = [NSMutableArray mutableCopy];
    self.cityArray = @[].mutableCopy;
    
    
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[QYZJRecommendTwoCell class] forCellReuseIdentifier:@"QYZJRecommendTwoCell"];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getQuDaoArrList];
    [self getLeiXingArrList];

    [self setFootV];
    [self setTableViewFootView];
    self.moreChooseV = [[QYZJMoreChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self getCityData];
    
    [self getAudioDict];
    
}



- (void)getAudioDict {
    
    [zkRequestTool getUpdateAudioModelWithCompleteModel:^(QYZJTongYongModel *model) {
        self.audioModel = model;
    }];
    
}


- (void)setTableViewFootView {
    
    self.footV = [[QYZJRecommendFootV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
    self.footV.type = 1;
    self.footV.clipsToBounds = YES;
    Weak(weakSelf);
    self.footV.clickRecommendFootVBlock = ^{
        
    };
    self.tableView.tableFooterView = self.footV;
    
    
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }

    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"完成" andImgaeName:@""];
    Weak(weakSelf);
        view.footViewClickBlock = ^(UIButton *button) {
           
            [weakSelf appiontAction];
       };
    [self.view addSubview:view];
}


- (void)appiontAction {
    [self.tableView endEditing:YES];
    if (self.dataModel.pro_id.length == 0 || self.dataModel.name.length == 0 || self.dataModel.type_id == 0 || self.dataModel.area.length == 0 || self.dataModel.des.length == 0 || self.dataModel.manner_id == 0 || self.dataModel.house_model_id==0 || self.dataModel.renovation_time_id == 0 || self.dataModel.price  <=0 || self.dataModel.role_strs.length == 0 || self.footV.codeStr.length == 0) {
       
        [SVProgressHUD showErrorWithStatus:@"信息填写不全"];
        return;
        
    }
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    dict[@"pro_id"] = self.dataModel.pro_id;
    dict[@"city_id"] = self.dataModel.city_id;
    dict[@"area_id"] = self.dataModel.area_id;
    dict[@"area"] = self.dataModel.area;
    dict[@"address_pca"] = [NSString stringWithFormat:@"%@%@%@",self.dataModel.proStr,self.dataModel.cityStr,self.dataModel.areaStr];
    dict[@"community_name"] = self.dataModel.name;
    dict[@"type_id"] = @(self.dataModel.type_id);
    dict[@"demand_context"] =  self.dataModel.des;
    dict[@"role_id"] = self.dataModel.role_ids;
    dict[@"manner"] = @(self.dataModel.manner_id);
    dict[@"mobile_code"] = self.footV.codeStr;
    dict[@"house_model"] = @(self.dataModel.house_model_id);;
    dict[@"renovation_time"] = @(self.dataModel.renovation_time_id);
    dict[@"budget"] = @(self.dataModel.price);
    dict[@"demand_voice"] = self.audioStr;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_appointDemandURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"预约单成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
    
}


- (void)getQuDaoArrList {
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_labelListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.quDaoArr = [QYZJTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)getLeiXingArrList {
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_demandTypeListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.LeiXingArr = [zkPickModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
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
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 4) {
        QYZJRecommendTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QYZJRecommendTwoCell" forIndexPath:indexPath];
        cell.TV.delegate = self;
        [cell.luyinBt addTarget:self action:@selector(luYinAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.listBt addTarget:self action:@selector(listAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.closeBt addTarget:self action:@selector(closeAcc:) forControlEvents:UIControlEventTouchUpInside];
        if (self.audioStr.length == 0) {
            cell.listBt.hidden = cell.closeBt.hidden = YES;
        }else {
            cell.closeBt.hidden = cell.listBt.hidden = NO;
            [cell.listBt setTitle:@"语音描述" forState:UIControlStateNormal];
        }
        return cell;
    }else {
        TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.leftLB.text = self.leftArr[indexPath.row];
        cell.TF.delegate = self;
        cell.TF.placeholder = self.placeholdArr[indexPath.row];
        cell.TF.userInteractionEnabled = NO;
        cell.TF.delegate = self;
        cell.moreImgV.hidden = NO;
        cell.TF.mj_w = ScreenW - 150;
        cell.rightLB.hidden = YES;
        cell.swith.hidden = YES;
        cell.TF.keyboardType = UIKeyboardTypeDefault;
        if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 8 ) {
            cell.moreImgV.hidden = YES;
            cell.TF.mj_w = ScreenW - 120;
            cell.TF.userInteractionEnabled = YES;
            if (indexPath.row == 3 || indexPath.row == 8) {
                cell.TF.keyboardType = UIKeyboardTypeDecimalPad;
            }
        }else if (indexPath.row == 11||indexPath.row == 10) {
            cell.swith.hidden = NO;
            cell.leftLB.mj_w = 200;
            cell.moreImgV.hidden =  cell.TF.hidden = YES;
            
        }
        
        [self setCellTextWithCell:cell withIndexPath:indexPath];
        
        return cell;
    }
 
}

- (void)setCellTextWithCell:(TongYongTwoCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        if (self.dataModel.pro_id.length == 0) {
            cell.TF.text = @"";
        }else {
          cell.TF.text = [NSString stringWithFormat:@"%@%@%@",self.dataModel.proStr,self.dataModel.cityStr,self.dataModel.areaStr];
        }
    }else if (indexPath.row == 1) {
        cell.TF.text = self.dataModel.name;
    }else if (indexPath.row == 2) {
        cell.TF.text = self.dataModel.type_name;
    }else if (indexPath.row == 3) {
        cell.rightLB.hidden = NO;
        cell.rightLB.text =@"m²";
        cell.TF.text = self.dataModel.area;
    }else if (indexPath.row == 5) {
        cell.TF.text = self.dataModel.manner_id > 0 ? [zkSignleTool shareTool].mannerArr[self.dataModel.manner_id-1]:@"";
    }else if (indexPath.row == 6) {
         cell.TF.text = self.dataModel.house_model_id > 0 ? [zkSignleTool shareTool].houseModelArr[self.dataModel.house_model_id-1]:@"";
    }else if (indexPath.row == 7) {
         cell.TF.text = self.dataModel.renovation_time_id > 0 ? [zkSignleTool shareTool].renvoationTimeArr[self.dataModel.renovation_time_id-1]:@"";
    }else if (indexPath.row == 8) {
        cell.rightLB.hidden = NO;
        cell.rightLB.text =@"元";
        if (self.dataModel.price == 0) {
            cell.TF.text = @"";
        }else {
            cell.TF.text = [NSString stringWithFormat:@"%0.2f",self.dataModel.price];
        }
       
    }else if (indexPath.row == 9) {
        cell.TF.text = self.dataModel.role_strs;
    }
    
    
    
}

//播放
- (void)listAction:(UIButton *)button {
    
       [[PublicFuntionTool shareTool] palyMp3WithNSSting:[QYZJURLDefineTool getVideoURLWithStr:self.audioStr] isLocality:NO];
       [button setTitle:@"正在播放..." forState:UIControlStateNormal];
       [PublicFuntionTool shareTool].findPlayBlock = ^{
           [button setTitle:@"点击播放" forState:UIControlStateNormal];
       };
}



- (void)luYinAction:(UIButton *)button {

    [self.tableView endEditing:YES];
    
    [[QYZJLuYinView LuYinTool] show];
               Weak(weakSelf);
               [QYZJLuYinView LuYinTool].statusBlock = ^(BOOL isStare,NSData *mediaData) {
       
                   dispatch_async(dispatch_get_main_queue() , ^{
                       if (isStare) {
                           weakSelf.navigationItem.title = @"正在录音...";
                       }else {
                           
                            weakSelf.navigationItem.title = @"预约表单";
                           
                           if (mediaData.length == 4096) {
                               return ;
                           }
                           
//
//                           NSString * firlpath = [[NSBundle mainBundle] pathForResource:@"8888" ofType:@"mp3"];
//                           NSData * dd = [NSData dataWithContentsOfFile:firlpath];
//                           [weakSelf updateLoadMediaWithData:dd];
                           [weakSelf updateLoadMediaWithData:mediaData];
                           [[QYZJLuYinView LuYinTool] diss];
                           
                       }
                   });
       
       
               };
    
    
}





- (void)updateLoadMediaWithData:(NSData *)data {
           NSMutableDictionary * dict = @{}.mutableCopy;
           dict[@"token"] = self.audioModel.token;
           [zkRequestTool NetWorkingUpLoadMediaWithfileData:data parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//               [SVProgressHUD showSuccessWithStatus:@"上传音频成功"];
               
               self.audioStr = responseObject[@"key"];
               [self.tableView reloadData];
               
           } failure:^(NSURLSessionDataTask *task, NSError *error) {
               NSLog(@"\n\n------%@",error);
           }];
}

-(void)closeAcc:(UIButton *)button {
    self.audioStr = nil;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView endEditing:YES];
    self.indexPath = indexPath;
    if (indexPath.row == 0) {
     if (self.cityArray.count == 0) {
         [SVProgressHUD showErrorWithStatus:@"获取类型中,请先填写其它内容"];
         [self cityArray];
         return;
     }
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
               picker.delegate = self ;
               picker.arrayType = AreaArray;
               picker.array = self.cityArray;
               picker.selectLb.text = @"请选择地址";
               [picker show];
        
    }else if (indexPath.row == 2) {
        if (self.LeiXingArr.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"获取类型中,请先填写其它内容"];
            [self getLeiXingArrList];
            return;
        }
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        picker.arrayType = NormalArray;
        picker.array = self.LeiXingArr;
        picker.selectLb.text = @"";
        [picker show];
        
        
    }else if (indexPath.row == 5) {
        
        if ([self isCanChoose]) {
            zkPickView * picker = [[zkPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            picker.delegate = self;
            picker.arrayType = titleArray;
            picker.array = [zkSignleTool shareTool].mannerArr.mutableCopy;
            picker.selectLb.text = @"";
            [picker show];
        }
        
    }else if (indexPath.row == 6) {
        
        if ([self isCanChoose]) {
            zkPickView * picker = [[zkPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            picker.delegate = self;
            picker.arrayType = titleArray;
            picker.array =[zkSignleTool shareTool].houseModelArr.mutableCopy;
            picker.selectLb.text = @"";
            [picker show];
        }
        
    }else  if (indexPath.row == 7){
        if ([self isCanChoose]) {
                   zkPickView * picker = [[zkPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                   picker.delegate = self;
                   picker.arrayType = titleArray;
                   picker.array =[zkSignleTool shareTool].renvoationTimeArr.mutableCopy;
                   picker.selectLb.text = @"";
                   [picker show];
               }
    }else if (indexPath.row == 9) {
        
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
            weakSelf.dataModel.role_ids = [arr componentsJoinedByString:@","];
            weakSelf.dataModel.role_strs = [arrTwo componentsJoinedByString:@","];
            [weakSelf.tableView reloadData];
        };
        [self.moreChooseV show];
        
    }
    
    
    
}

#pragma mark ---- 点击完成 ----
- (void)clickAction:(UIButton *)button {
    
}

#pragma mark ------- 点击筛选城市或者其它 ------
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex{
    
    if (self.indexPath.row == 0) {
        
           self.dataModel.proStr = self.cityArray[leftIndex].pname;
           self.dataModel.pro_id= self.cityArray[leftIndex].pid;
          
               self.dataModel.cityStr = self.cityArray[leftIndex].cityList[centerIndex].cname;
               self.dataModel.city_id = self.cityArray[leftIndex].cityList[centerIndex].cid;
               if (rightIndex == 0) {
                   self.dataModel.areaStr =  @"";
                   self.dataModel.area_id = @"0";
               }else {
                   self.dataModel.areaStr = self.cityArray[leftIndex].cityList[centerIndex].areaList[rightIndex-1].name;
                   self.dataModel.area_id = self.cityArray[leftIndex].cityList[centerIndex].areaList[rightIndex-1].ID;
               }
         
        
        
    }else if (self.indexPath.row == 2) {
        self.dataModel.type_id = [self.LeiXingArr[leftIndex].ID intValue];
        self.dataModel.type_name = self.LeiXingArr[leftIndex].name;
    }else if (self.indexPath.row == 5) {
        self.dataModel.manner_id = leftIndex+1;
    }else if (self.indexPath.row == 6) {
        self.dataModel.house_model_id = leftIndex+1;
    }else if (self.indexPath.row == 7) {
        self.dataModel.renovation_time_id = leftIndex+1;
    }
    
    NSLog(@"%d---%d----%d",leftIndex,centerIndex,rightIndex);
    
     [self.tableView reloadData];
}

#pragma mark ----- 输入描述结束 -----
- (void)textViewDidEndEditing:(UITextView *)textView {
    self.dataModel.des = textView.text;
    
}
#pragma mark --- 填写内容结束时 ----
- (void)textFieldDidEndEditing:(UITextField *)textField {
    TongYongTwoCell * cell = (TongYongTwoCell *)textField.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 1){
        self.dataModel.name = textField.text;
    }else if (indexPath.row == 3) {
        self.dataModel.area = textField.text;
    }else if (indexPath.row == 8) {
        self.dataModel.price = [textField.text floatValue];
    }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    TongYongTwoCell  * cell = (TongYongTwoCell *)textField.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    if (indexPath.row == 8 || indexPath.row == 3) {
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


- (void)getCityData {
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_addressURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.cityArray = [zkPickModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


@end
