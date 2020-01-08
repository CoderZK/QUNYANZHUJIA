//
//  QYZJChangeDetailedListTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/19.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJChangeDetailedListTVC.h"

@interface QYZJChangeDetailedListTVC ()<TZImagePickerControllerDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIView *whiteOneV;
@property(nonatomic,strong)NSArray *leftTitleArr,*placeHolderArr;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,strong)QYZJTongYongModel *imgModel;
@end

@implementation QYZJChangeDetailedListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createHeadV];
    
    self.navigationItem.title = @"添加变更清单";
    [self addFootV];
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    self.leftTitleArr = @[@"施工阶段",@"施工金额",@"工期",@"时间段"];
    self.placeHolderArr = @[@"请输入施工阶段",@"请输入金额",@"请输入工期",@"请选择时间段"];
    self.tableView.backgroundColor =[UIColor groupTableViewBackgroundColor];
    self.dataArray = @[].mutableCopy;
    QYZJFindModel * model = [[QYZJFindModel alloc] init];
    [self.dataArray addObject:model];

    [self getImgDict];
}

- (void)getImgDict {
    [zkRequestTool getUpdateImgeModelWithCompleteModel:^(QYZJTongYongModel *model) {
           self.imgModel = model;
       }];
}

- (void)addFootV {
    
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
       if (sstatusHeight > 20) {
           self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
       }
       
       KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"提交" andImgaeName:@""];
        Weak(weakSelf);
           view.footViewClickBlock = ^(UIButton *button) {
                    NSLog(@"\n\n%@",@"完成");
               [weakSelf clickAction:button];
          };
       [self.view addSubview:view];
    self.tableView.backgroundColor = [UIColor whiteColor];
    UIView * footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
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

- (void)createHeadV {
    
    CGFloat ww = 90;
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ww+60)];
    UIView * backV1 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    backV1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.headV addSubview:backV1];
    self.whiteOneV = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenW, ww+40)];
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.whiteOneV.frame) , ScreenW, 10)];
    backV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.headV addSubview:backV];
    self.whiteOneV.backgroundColor = WhiteColor;
    
    
    
    UILabel * lb3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, self.whiteOneV.frame.size.height-20)];
    lb3.textColor = CharacterBlack112;
    lb3.font = kFont(14);
    lb3.text = @"变更单";
    [self.whiteOneV addSubview:lb3];
    [self.headV addSubview:self.whiteOneV];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 10, ScreenW-110, ww+20)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.whiteOneV addSubview:self.scrollView];
    
    [self.headV addSubview:self.whiteOneV];
    self.headV.backgroundColor = WhiteColor;
    self.tableView.tableHeaderView = self.headV;
    
    [self addPicsWithArr:self.picsArr];
    
}

- (void)addPicsWithArr:(NSMutableArray *)picsArr {

    CGFloat space = 20;
    CGFloat ww = 90;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake((picsArr.count + 1) * (ww+space), ww+10);

    for (int i = 0 ; i < picsArr.count + 1; i++) {
        
        UIButton * anNiuBt = [[UIButton alloc] initWithFrame:CGRectMake((ww +  space) * i , 10, ww, ww)];
        anNiuBt.layer.cornerRadius = 3;
        anNiuBt.tag = 100+i;
        anNiuBt.clipsToBounds = YES;
        [anNiuBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:anNiuBt];
        
        if (i == picsArr.count) {
            
            [anNiuBt setBackgroundImage:[UIImage imageNamed:@"tianjia"] forState:UIControlStateNormal];
            
        }else {
            UIButton * deleteBt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(anNiuBt.frame) - 10 ,0 , 20, 20)];
            [deleteBt setImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];
            deleteBt.tag = 100+i;
            [deleteBt addTarget:self action:@selector(deleteHitAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:deleteBt];
             if ([picsArr[i] isKindOfClass:[NSString class]]) {
                            [anNiuBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:picsArr[i]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"789"] options:SDWebImageRetryFailed];
            }else {
                [anNiuBt setBackgroundImage:picsArr[i] forState:UIControlStateNormal];
            }
            
        }
        
        
    }

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    
    TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.rightLB.hidden =cell.moreImgV.hidden =  YES;
    cell.TF.userInteractionEnabled = NO;
    cell.TF.delegate = self;
    QYZJFindModel * model = self.dataArray[indexPath.section];
    cell.TF.keyboardType= UIKeyboardTypeDefault;
    if (indexPath.row == 0){
        cell.TF.text = model.stage_name;
    }else  if (indexPath.row == 1){
        cell.rightLB.hidden = NO;
        if (model.price>0) {
            cell.TF.text = [NSString stringWithFormat:@"%0.2f",model.price];
        }else {
            cell.TF.text = @"";
        }
        cell.TF.keyboardType =  UIKeyboardTypeDecimalPad;
        cell.TF.userInteractionEnabled = YES;
        cell.rightLB.text = @"元";
    }else  if (indexPath.row ==2) {
        cell.rightLB.hidden = NO;
        if (model.days>0) {
            cell.TF.text = [NSString stringWithFormat:@"%0.0f",model.days];
        }else {
            cell.TF.text = [NSString stringWithFormat:@"%@",@""];
        }
        cell.TF.keyboardType =  UIKeyboardTypeNumberPad;
        cell.rightLB.text = @"天";
        cell.TF.userInteractionEnabled = YES;
    }else if (indexPath.row == 3) {
        if (model.time_start.length == 0 || model.time_end.length == 0) {
            cell.TF.text = @"";
        }else {
          cell.TF.text = [NSString stringWithFormat:@"%@到%@",model.time_start,model.time_end];
        }
        
    }
    cell.leftLB.text = self.leftTitleArr[indexPath.row];
    cell.TF.placeholder = self.placeHolderArr[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView endEditing:YES];
    
    if (indexPath.row == 0) {
        QYZJShowFromTopView * view = [[QYZJShowFromTopView alloc] initWithFrame:CGRectMake(0, 0 , ScreenW, ScreenH)];
        [self.view addSubview:view];
        view.dataArray = @[@"拆改",@"水电",@"木工",@"瓦工",@"油漆",@"安装",@"治理"];
        view.subject = [[RACSubject alloc] init];
        //点击
        @weakify(self);
        [view.subject subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.dataArray[indexPath.section].stage_name = x;
            [self.tableView reloadData];
        }];
        [view show];
    }else  if (indexPath.row == 3){
        
        if (self.dataArray[indexPath.section].days==0) {
            [SVProgressHUD showErrorWithStatus:@"请先填写工期"];
            return;
        }else {
            
            SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
            selectTimeV.isCanSelectOld = NO;
            selectTimeV.isCanSelectToday = YES;
            Weak(weakSelf);
            selectTimeV.block = ^(NSString *timeStr) {
                self.dataArray[indexPath.section].time_start = timeStr;
                NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate * nowDate = [dateFormatter dateFromString:timeStr];
                NSDate * otherDate =[NSString getLaterDateFromDate:nowDate withYear:0 month:0 day:self.dataArray[indexPath.section].days];
                self.dataArray[indexPath.section].time_end = [dateFormatter stringFromDate:otherDate];
                [weakSelf.tableView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
            
            
        }
        
    }
    
    
}
#pragma mark --- 填写内容结束时 ----
- (void)textFieldDidEndEditing:(UITextField *)textField {
    TongYongTwoCell * cell = (TongYongTwoCell *)textField.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QYZJFindModel *model = self.dataArray[indexPath.section];
    
      if (indexPath.row == 1) {
          model.price = [textField.text floatValue];
        }else if (indexPath.row == 2){
          model.days = [textField.text floatValue];
        }
       [self.tableView reloadData];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    TongYongTwoCell  * cell = (TongYongTwoCell *)textField.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    if (indexPath.row == 1 ) {
        NSMutableString *futureString = [NSMutableString stringWithString:textField.text];
           [futureString insertString:string atIndex:range.location];
           
        if ([futureString containsString:@"-"]) {
            return NO;
        }
           NSInteger flag = 0;
           // 这个可以自定义,保留到小数点后两位,后几位都可以
           const NSInteger limited = 3 - indexPath.row;
           
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

#pragma mark ---- 添加阶段 ----
- (void)addJieDuan {
    if([self cheackFullMessage]) {
        QYZJFindModel * model = [[QYZJFindModel alloc] init];
        [self.dataArray addObject:model];
        [self.tableView reloadData];
    }
}

#pragma mark ---- 点击完成 ----
- (void)clickAction:(UIButton *)button {

    if ([self cheackFullMessage]) {
        [self createStageAction];
    }
    
    
    
}

- (BOOL)cheackFullMessage {
    for (QYZJFindModel *model  in self.dataArray) {
        if (model.stage_name.length == 0 ||  model.days == 0 || model.time_start.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"信息填写不完整"];
            return NO;
        }
    }
    return YES;
    
}

- (void)createStageAction {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"list"] = [self listStr];
    dict[@"turnoverId"] = self.ID;
    dict[@"changeTableUrl"] = [self.picsArr componentsJoinedByString:@","];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_createChangeStageURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"添加变更清单成功"];
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

- (NSString *)listStr {
    NSMutableArray * dataArr = @[].mutableCopy;
    for (QYZJFindModel * model  in self.dataArray) {
        NSMutableDictionary * dict = @{}.mutableCopy;
        dict[@"stage_name"] = model.stage_name;
        dict[@"price"] = @(model.price);
        dict[@"days"] = @(model.days);
        dict[@"time_start"] = model.time_start;
        dict[@"time_end"] = model.time_end;
        [dataArr addObject:dict];
    }
    
    NSString * str = [NSString convertToJsonDataWithDict:dataArr];
    return str;
}



- (void)deleteHitAction:(UIButton *)button {
    [self.picsArr removeObjectAtIndex:button.tag - 100];
    [self addPicsWithArr: self.picsArr];
}

- (void)hitAction:(UIButton *)button {
    
    if (button.tag == self.picsArr.count + 100) {
        //添加图片
        [self addPict];
    }else {
        [[zkPhotoShowVC alloc] initWithArray:self.picsArr index:button.tag - 100];
        
    }
}

- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePhotos]) {
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                [self.picsArr addObject:image];
                [self addPicsWithArr: self.picsArr];
                [self updateImgsToQiNiuYun];

            }];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:MAXFLOAT columnNumber:4 delegate:self pushPhotoPickerVc:YES];
             imagePickerVc.allowTakeVideo = NO;
            imagePickerVc.allowPickingVideo = NO;
            imagePickerVc.allowPickingImage = YES;
            imagePickerVc.allowTakePicture = YES;
            imagePickerVc.showSelectBtn = NO;
            imagePickerVc.allowCrop = YES;
            imagePickerVc.needCircleCrop = NO;
            imagePickerVc.cropRectPortrait = CGRectMake(0, (ScreenH - ScreenW)/2, ScreenW, ScreenW);
            imagePickerVc.cropRectLandscape = CGRectMake(0, (ScreenW - ScreenH)/2, ScreenH, ScreenH);
            imagePickerVc.circleCropRadius = ScreenW/2;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                
                [self.picsArr addObjectsFromArray:photos];
                [self addPicsWithArr: self.picsArr];
                [self updateImgsToQiNiuYun];
                
                
                
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];

    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action1];
    [ac addAction:action2];
    [ac addAction:action3];
    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
    
}



//创建上传图片队列
- (void)updateImgsToQiNiuYun {
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    //创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0 ; i < self.picsArr.count; i++) {
        if ([self.picsArr[i] isKindOfClass:[UIImage class]]) {
            dispatch_group_async(group, queue, ^{
                [self upimgWithindex:i withgrop:group];
            });
        }
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       //全部上传成功
        [SVProgressHUD showSuccessWithStatus:@"上传图片成功"];
//        [self addPicsWithArr:self.picsArr];
    });
}
//上传图片操作
- (void)upimgWithindex:(NSInteger)index withgrop:(dispatch_group_t)group{

    dispatch_group_enter(group);
       NSMutableDictionary * dict = @{}.mutableCopy;
       dict[@"token"] = self.imgModel.token;
      __block showProgress * showOb =  [[showProgress alloc] init];
       dispatch_async(dispatch_get_main_queue(), ^{
         UIButton *  button  = [self.scrollView viewWithTag:index + 100];
         [showOb showViewOnView:button];
       });
       [zkRequestTool NetWorkingUpLoadimage:self.picsArr[index] parameters:dict progress:^(CGFloat progress) {
           
           showOb.progress = progress;
           
       } success:^(NSURLSessionDataTask *task, id responseObject) {
           NSLog(@"%@",@"京东卡的风控安徽");
           [self.picsArr removeObjectAtIndex:index];
           [self.picsArr insertObject:[NSString stringWithFormat:@"%@",responseObject[@"key"]] atIndex:index];
           dispatch_group_leave(group);
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           [showOb diss];
       }];
    

    
    
    
}


@end
