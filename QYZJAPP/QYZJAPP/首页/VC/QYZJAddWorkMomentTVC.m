//
//  QYZJAddWorkMomentTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/19.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJAddWorkMomentTVC.h"

@interface QYZJAddWorkMomentTVC ()<TZImagePickerControllerDelegate>
@property(nonatomic,strong)UITextField *titleTF;
@property(nonatomic,strong)IQTextView * desTV;
@property(nonatomic,strong)UIView *whiteOneV,*whiteTwoV;
@property(nonatomic,strong)UIImageView *videoImgV;
@property(nonatomic,strong)UIButton *addBt;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *picsArr;
@property(nonatomic,strong)NSString *videoStr;
@property(nonatomic,assign)BOOL   isChooseVideo;
@property(nonatomic,strong)UIButton *deleteBt;
//@property(nonatomic,strong)UILabel *lb4;

@property(nonatomic,strong)QYZJTongYongModel *imgModel,*videoModel;


@end

@implementation QYZJAddWorkMomentTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setFootV];
    [self createHeadV];
    self.picsArr = @[].mutableCopy;
    if (self.type == 4 && self.picsArrTwo.count > 0) {
        self.picsArr = self.picsArrTwo;
    }
   
    [self addPicsWithArr:self.picsArr];
    self.videoStr = nil;
    self.navigationItem.title = @"创建施工阶段";
    if (self.type == 1) {
        self.navigationItem.title = @"修改案例";
    }else if (self.type == 2) {
        self.navigationItem.title = @"创建播报";
    }else if (self.type == 3) {
        self.navigationItem.title = @"创建案例";
    }else if (self.type == 4) {
        self.navigationItem.title = @"创建播报";
    }else if (self.type == 5) {
        self.navigationItem.title = @"创建播报";
    }else if (self.type == 6 || self.type == 7) {
        self.navigationItem.title = @"创建报修";
    }    self.tableView.backgroundColor =[UIColor groupTableViewBackgroundColor];
    
    
    [self getImgDict];
     [self getVideoDict];
    self.titleTF.text = self.titleStr;
    
    
}

- (void)getImgDict {
    [zkRequestTool getUpdateImgeModelWithCompleteModel:^(QYZJTongYongModel *model) {
           self.imgModel = model;
       }];
}

- (void)getVideoDict {
    
    [zkRequestTool getUpdateVideoModelWithCompleteModel:^(QYZJTongYongModel *model) {
        self.videoModel = model;
    }];
    
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"完成" andImgaeName:@""];
    
    if (self.type == 1) {
        view.titleStr = @"发布";
    }
    Weak(weakSelf);
        view.footViewClickBlock = ^(UIButton *button) {
            [weakSelf FaBuAction];
       };
    [self.view addSubview:view];
}

- (void)FaBuAction {
    
    if (self.titleTF.text.length ==0 && !(self.type == 7 || self.type == 6)) {
           [SVProgressHUD showErrorWithStatus:@"请输入标题"];
           return;
       }
    if (self.desTV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入动态内容"];
        return;
    }

    [SVProgressHUD show];
    
    NSString * url = [QYZJURLDefineTool user_createConstructionURL];
    if (self.type == 1) {
        url = [QYZJURLDefineTool user_updateCaseURL];
    }else if (self.type == 2) {
        url = [QYZJURLDefineTool user_createRepairBroadcastURL];
    }else if (self.type == 3) {
        url = [QYZJURLDefineTool user_addCaseURL];
    }else if (self.type == 4) {
        url = [QYZJURLDefineTool user_constructionEditURL];
    }else if (self.type == 5) {
        url = [QYZJURLDefineTool user_createBroadcastURL];
    }else if (self.type == 6 || self.type == 7) {
        url = [QYZJURLDefineTool user_createRepairURL];
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"constructionStageId"] = self.ID;
    dict[@"videoUrl"] = self.videoStr;
    dict[@"video_url"] = self.videoStr;
    dict[@"picUrl"] = [self.picsArr componentsJoinedByString:@","];
    dict[@"pic"] = [self.picsArr componentsJoinedByString:@","];
    dict[@"content"] = self.desTV.text;
    dict[@"con"] = self.desTV.text;
    dict[@"description"] = self.desTV.text;
    dict[@"title"] = self.titleTF.text;
    dict[@"context"] = self.titleTF.text;
    dict[@"stageName"] = self.titleTF.text;
    dict[@"id"] = self.ID;
    dict[@"turnoverListId"] = self.ID;
    dict[@"price"] = @(self.price);
    dict[@"changeType"] = @(self.changeType);
    dict[@"videoUrl"] = self.videoStr;
    if (self.type == 4 || self.type == 6 || self.type == 7) {
        dict[@"turnoverListId"] = self.IDTwo;
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            if (self.type == 1) {
               [SVProgressHUD showSuccessWithStatus:@"修改例成功"];
            }else if (self.type == 2 || self.type == 5) {
                [SVProgressHUD showSuccessWithStatus:@"添加播报成功"];
            }else if (self.type == 3) {
                [SVProgressHUD showSuccessWithStatus:@"创建案例成功"];
            }else if (self.type == 4) {
                [SVProgressHUD showSuccessWithStatus:@"修改阶段成功"];
            }
            
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




- (void)createHeadV {
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 20)];
    self.headV.backgroundColor = WhiteColor;
    UILabel * lb1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 80, 20)];
    lb1.textColor = CharacterBlack112;
    lb1.font = kFont(14);
    lb1.text = @"标题";
    [self.headV addSubview:lb1];
    
    self.titleTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, ScreenW - 110, 30)];
    self.titleTF.font = kFont(14);
    self.titleTF.placeholder = @"请输入标题";
    self.titleTF.text = self.titleStr;
    [self.headV addSubview:self.titleTF];
    
    UIView * backV1 =[[UIView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, 0.6)];
    backV1.backgroundColor = lineBackColor;
    
    if (self.type == 6 || self.type == 7) {
        backV1.mj_y = 0;
        self.titleTF.hidden = lb1.hidden = YES;
    }
    
    [self.headV addSubview:backV1];
    
    
    UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(10,  CGRectGetMaxY(backV1.frame) + 30, 80, 20)];
    lb2.textColor = CharacterBlack112;
    lb2.font = kFont(14);
    lb2.text = @"阶段描述";
    if (self.type == 1 || self.type == 3) {
        lb2.text = @"内容";
    }else if (self.type == 2) {
        lb2.text = @"播报描述";
    }
    [self.headV addSubview:lb2];
    
    
    self.desTV = [[IQTextView alloc] initWithFrame:CGRectMake(95, CGRectGetMaxY(backV1.frame) + 10, ScreenW - 110, 60)];
    self.desTV.font = kFont(14);
    self.desTV.placeholder = @"请输入阶段描述";
    if (self.type == 1 || self.type == 3) {
        self.desTV.placeholder = @"请输入内容";
    }else if (self.type == 2) {
        self.desTV.placeholder = @"请输入播报描述";
    }
    [self.headV addSubview:self.desTV];
    self.desTV.text = self.contentStr;
    UIView * backV2 =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.desTV.frame) + 10, ScreenW, 0.6)];
    backV2.backgroundColor = lineBackColor;
    [self.headV addSubview:backV2];
    
    CGFloat ww = 90;
    self.whiteOneV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backV2.frame), ScreenW, ww+40)];
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, self.whiteOneV.mj_h - 0.6, ScreenW, 0.6)];
    backV.backgroundColor = lineBackColor;
    [self.whiteOneV addSubview:backV];
    self.whiteOneV.backgroundColor = WhiteColor;
    
    
    
    UILabel * lb3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, self.whiteOneV.frame.size.height-20)];
    lb3.textColor = CharacterBlack112;
    lb3.font = kFont(14);
    lb3.text = @"图片";
    [self.whiteOneV addSubview:lb3];
    [self.headV addSubview:self.whiteOneV];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 10, ScreenW-110, ww+20)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.whiteOneV addSubview:self.scrollView];
    
    
    self.whiteTwoV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.whiteOneV.frame), ScreenW,   ww+20)];
    self.whiteTwoV.backgroundColor = WhiteColor;
    
    UILabel * lb4 = [[UILabel alloc] init];//WithFrame:CGRectMake(10, 10, 80, ww)];
    lb4.textColor = CharacterBlack112;
    lb4.font = kFont(14);
    lb4.text = @"视频";
    [self.whiteTwoV addSubview:lb4];
    [lb4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.whiteTwoV);
        make.left.equalTo(self.whiteTwoV).offset(10);
        make.width.equalTo(@80);
    }];
    self.addBt = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, ww, ww)];
    [self.addBt setBackgroundImage:[UIImage imageNamed:@"tianjia"] forState:UIControlStateNormal];
    [self.addBt addTarget:self action:@selector(addVideoaction) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteTwoV addSubview:self.addBt];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, ScreenW - 110, (ScreenW - 110)*9/16)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    [self.whiteTwoV addSubview:imageView];
    [self.headV addSubview:self.whiteTwoV];
    
    self.videoImgV = imageView;
    
    UIButton * button = [[UIButton alloc]init];
    button.frame = CGRectMake((ScreenW - 110)/2 - 25, ((ScreenW - 110)*9/16)/2-25, 50, 50);
    [button setBackgroundImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
    [imageView addSubview:button];
    button.alpha = 0.8;
    [button addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    button.userInteractionEnabled = NO;
    imageView.hidden = YES;
    
    UIButton * delectVideoBt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) - 10, 3, 20, 20)];
    [delectVideoBt setImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];
    [self.whiteTwoV addSubview:delectVideoBt];
    self.deleteBt = delectVideoBt;
    
    self.headV.mj_h = CGRectGetMaxY(self.whiteTwoV.frame);
    self.tableView.tableHeaderView = self.headV;
    self.headV.backgroundColor = self.whiteOneV.backgroundColor = self.whiteTwoV.backgroundColor = WhiteColor;
    
    self.videoStr = self.videoUrl;
    
}


- (void)setVideoStr:(NSString *)videoStr {
    _videoStr = videoStr;
    if (videoStr == nil || videoStr.length == 0) {
        
        self.addBt.hidden = NO;
        self.whiteTwoV.mj_h = 110;
        self.videoImgV.hidden =self.deleteBt.hidden = YES;
        self.headV.mj_h = CGRectGetMaxY(self.whiteTwoV.frame);
        self.tableView.tableHeaderView = self.headV;
        
    }else {
        self.addBt.hidden = YES;
        self.videoImgV.hidden =self.deleteBt.hidden = NO;
        self.whiteTwoV.mj_h = (ScreenW - 110)*9/16 + 20;
        self.videoImgV.image = [PublicFuntionTool firstFrameWithVideoURL:[NSURL URLWithString:[QYZJURLDefineTool getVideoURLWithStr:videoStr]] size:CGSizeMake((ScreenW - 110), (ScreenW - 110)*9/16)];
        self.headV.mj_h = CGRectGetMaxY(self.whiteTwoV.frame);
        self.tableView.tableHeaderView = self.headV;
        
    }
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

- (void)deleteHitAction:(UIButton *)button {
    [self.picsArr removeObjectAtIndex:button.tag - 100];
    [self addPicsWithArr:self.picsArr];
}

- (void)hitAction:(UIButton *)button {
    
    if (button.tag == self.picsArr.count + 100) {
        //添加图片
        self.isChooseVideo = NO;
        [self.tableView endEditing:YES];
        [self addPict];
    }else {
        [[zkPhotoShowVC alloc] initWithArray:self.picsArr index:button.tag - 100];
        
    }
}


- (void)addVideoaction {
    self.isChooseVideo = YES;
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
    [self.tableView endEditing:YES];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePhotos]) {
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                [self.picsArr addObject:image];
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
            if (self.isChooseVideo) {
                imagePickerVc.allowTakeVideo = YES;
                imagePickerVc.allowTakePicture = NO;
            }else {
                imagePickerVc.allowTakeVideo = YES;
                imagePickerVc.allowTakePicture = NO;
            }
            imagePickerVc.showSelectBtn = NO;
            imagePickerVc.allowCrop = YES;
            imagePickerVc.needCircleCrop = NO;
            imagePickerVc.cropRectPortrait = CGRectMake(0, (ScreenH - ScreenW)/2, ScreenW, ScreenW);
            imagePickerVc.cropRectLandscape = CGRectMake(0, (ScreenW - ScreenH)/2, ScreenH, ScreenH);
            imagePickerVc.circleCropRadius = ScreenW/2;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                
                [self.picsArr addObjectsFromArray:photos];
                [self updateImgsToQiNiuYun];
                
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    if (self.isChooseVideo) {
        
    }else {
        
    }
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action1];
    [ac addAction:action2];
    [ac addAction:action3];
    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
    
}



- (void)play {
    
    [PublicFuntionTool presentVideoVCWithNSString:[QYZJURLDefineTool getVideoURLWithStr:self.videoStr] isBenDiPath:NO];
    
}


#pragma mark ------ 如下是图片和视频的处理上传过程 ------
//视频选择结束
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    [PublicFuntionTool getImageFromPHAsset:asset Complete:^(NSData * _Nonnull data, NSString * _Nonnull str) {
        NSMutableDictionary * dict = @{}.mutableCopy;
        dict[@"token"] = self.videoModel.token;
 
        [zkRequestTool NetWorkingUpLoadVeidoWithfileData:data parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"上传视频成功"];
            self.videoStr = [NSString stringWithFormat:@"%@",responseObject[@"key"]];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"\n\n------%@",error);
        }];
    }];
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
        [self addPicsWithArr:self.picsArr];
    });
}
//上传图片操作
- (void)upimgWithindex:(NSInteger)index withgrop:(dispatch_group_t)group{
    dispatch_group_enter(group);
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = self.imgModel.token;
    [zkRequestTool NetWorkingUpLoad:QiNiuYunUploadURL image:self.picsArr[index] andName:@"file" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",@"京东卡的风控安徽");
        [self.picsArr removeObjectAtIndex:index];
        [self.picsArr insertObject:[NSString stringWithFormat:@"%@",responseObject[@"key"]] atIndex:index];
        dispatch_group_leave(group);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}


@end
