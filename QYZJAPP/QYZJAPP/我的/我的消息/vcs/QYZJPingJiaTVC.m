//
//  QYZJPingJiaTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/2.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJPingJiaTVC.h"

@interface QYZJPingJiaTVC ()<TZImagePickerControllerDelegate>
@property(nonatomic,strong)UIView * whiteOneV,*whiteTwoV,*whitethreeV;
@property(nonatomic,strong)IQTextView * TV;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *picsArr;
@property(nonatomic,strong)QYZJTongYongModel *imgModel,*videoModel;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,assign)NSInteger score;
@end

@implementation QYZJPingJiaTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.score = 5;
    self.navigationItem.title = @"评价";
    self.picsArr = @[].mutableCopy;
    [self getImgDict];
    
    [self createView];
    
}

- (void)getImgDict {
    [zkRequestTool getUpdateImgeModelWithCompleteModel:^(QYZJTongYongModel *model) {
           self.imgModel = model;
       }];
}


- (void)createView {
    
    UIView * headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 20)];
    headV.backgroundColor = WhiteColor;
    self.headV = headV;
    
    UIView * grayV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    grayV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [headV addSubview:grayV];
    
    UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 25, 45, 45)];
    
    NSString * goodS = @"";
    if (_model.goods_pic.length > 0 ){
        goodS = [[_model.goods_pic componentsSeparatedByString:@","] firstObject];
    }
    
    [imgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:goodS]] placeholderImage:[UIImage imageNamed:@"789"] options:SDWebImageRetryFailed];
    [headV addSubview:imgV];
    
    
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 110, 25, 100, 45)];
    lb.font = kFont(14);
    lb.textAlignment = NSTextAlignmentRight;
    lb.text = [NSString stringWithFormat:@"￥%@",self.model.goods_price];
    [headV addSubview:lb];
    
    UILabel * titlelb = [[UILabel alloc] initWithFrame:CGRectMake(70, 25, 100, 45)];
    titlelb.font = kFont(14);
    titlelb.text = self.model.goods_name;
    [headV addSubview:titlelb];
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(10, 85, ScreenW - 10, 0.6)];
    backV.backgroundColor = lineBackColor;
    [headV addSubview:backV];
    
    UILabel * lb3 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(backV.frame) + 15, 40, 20)];
    lb3.font = kFont(14);
    lb3.text = @"评分";
    [headV addSubview:lb3];
    CGFloat space = 3;
    CGFloat ww = 30;
    for (int i = 0 ; i < 5 ; i++) {
        UIButton * button  = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb3.frame) + 5 +  (space + ww) * i, CGRectGetMinY(lb3.frame) - 5, ww, ww)];
        button.tag = i + 100;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"xing1"] forState:UIControlStateNormal];
        [headV addSubview:button];
    }
    
    UILabel * lb4 = [[UILabel alloc] initWithFrame:CGRectMake(240, CGRectGetMaxY(backV.frame) + 15, 80, 20)];
    lb4.text = @"非常满意";
    lb4.textColor = CharacterColor80;
    lb4.font = kFont(13);
    lb4.tag = 1000;
    [headV addSubview:lb4];
    
    self.TV = [[IQTextView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(lb3.frame) + 15, ScreenW - 16, 80)];
    self.TV.placeholder = @"填写高质量的评价,既可参与抽奖~~";
    self.TV.font = kFont(14);
    [headV addSubview:self.TV];
    

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.TV.frame) + 20, ScreenW - 20, 100+20)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = WhiteColor;
    [headV addSubview:self.scrollView];
    [self addPicsWithArr:self.picsArr];
    
    UIView * backOneV =[[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.scrollView.frame) + 30, ScreenW-10,  0.6)];
    backOneV.backgroundColor = lineBackColor;
    [headV addSubview:backOneV];
    
    UIButton * tiJiaoBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 10-70, CGRectGetMaxY(backOneV.frame) + 10, 70,  30)];
    tiJiaoBt.layer.cornerRadius = 3;
    tiJiaoBt.layer.borderColor = [UIColor blackColor].CGColor;
    [tiJiaoBt setTitle:@"提交" forState:UIControlStateNormal];
    tiJiaoBt.titleLabel.font = kFont(14);
    tiJiaoBt.layer.borderWidth = 0.8;
    [tiJiaoBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tiJiaoBt addTarget:self action:@selector(tijiaoAction:) forControlEvents:UIControlEventTouchUpInside];
    [headV addSubview:tiJiaoBt];

    
    self.headV.mj_h = CGRectGetMaxY(backOneV.frame) + 50;
    self.tableView.tableHeaderView = self.headV;
    self.headV.clipsToBounds = YES;
    self.headV.backgroundColor = WhiteColor;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    
}

//提交
- (void)tijiaoAction:(UIButton *)button {

    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.model.ID;
    dict[@"content"] = self.TV.text;
    dict[@"pic"] = [self.picsArr componentsJoinedByString:@","];
    dict[@"score"] =@(self.score);
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_evaluateGoodsURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"评价成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
                BaseTableViewController *TVC =  self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 3];
                [self.navigationController popToViewController:TVC animated:YES];
                
            });
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}

//点击星星
- (void)clickAction:(UIButton *)button {
    
    self.score = button.tag - 99;
    UILabel * lb = (UILabel *)[self.headV viewWithTag:1000];
    if (button.tag  == 100) {
        lb.text = @"非常不满意";
    }else if (button.tag <=102) {
        lb.text = @"不满意";
    }else if (button.tag == 103) {
        lb.text = @"满意";
    }else {
        lb.text = @"非常满意";
    }
    
    for (int i = 100 ; i < 105; i++) {
        UIButton * neiBt = (UIButton *)[self.headV viewWithTag:i];
        if (neiBt.tag <=button.tag) {
            [neiBt setImage:[UIImage imageNamed:@"xing1"] forState:UIControlStateNormal];
        }else {
            [neiBt setImage:[UIImage imageNamed:@"xing2"] forState:UIControlStateNormal];
        }
    }

}

- (void)addPicsWithArr:(NSMutableArray *)picsArr {

    CGFloat space = 20;
    CGFloat ww = 100;
    
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

- (void)deleteHitAction:(UIButton *)button {
    [self.picsArr removeObjectAtIndex:button.tag - 100];
    [self addPicsWithArr:self.picsArr];
}

- (void)hitAction:(UIButton *)button {
    
    if (button.tag == self.picsArr.count + 100) {
        //添加图片
        [self addPict];
    }else {
        [[zkPhotoShowVC alloc] initWithArray:self.picsArr index:button.tag - 100];
        
    }
}

//添加选图片
- (void)addVideoaction {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = NO;
    imagePickerVc.allowPickingImage = NO;
    imagePickerVc.cropRectPortrait = CGRectMake(0, (ScreenH - ScreenW)/2, ScreenW, ScreenW);
    imagePickerVc.cropRectLandscape = CGRectMake(0, (ScreenW - ScreenH)/2, ScreenH, ScreenH);
    imagePickerVc.circleCropRadius = ScreenW/2;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        NSLog(@"\nnnn%@",assets);
        
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                [self.picsArr addObject:image];
                [self addPicsWithArr:self.picsArr];
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
                [self addPicsWithArr:self.picsArr];
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
