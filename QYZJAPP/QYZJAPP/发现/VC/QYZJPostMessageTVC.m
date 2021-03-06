//
//  QYZJPostMessageTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJPostMessageTVC.h"
#import "QYZJFindShopCell.h"
@interface QYZJPostMessageTVC ()<TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)IQTextView * desTV;
@property(nonatomic,strong)UIView *whiteOneV,*whiteTwoV;
@property(nonatomic,strong)UIImageView *videoImgV;
@property(nonatomic,strong)UIButton *addBt;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *picsArr;
@property(nonatomic,strong)NSMutableArray *picsStrArr;
@property(nonatomic,strong)NSString *videoStr;

@property(nonatomic,assign)BOOL   isChooseVideo;
@property(nonatomic,assign)BOOL isShowShop;
@property(nonatomic,strong)UIButton *deleteBt;

@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,strong)QYZJTongYongModel *imgModel,*videoModel;



@end

@implementation QYZJPostMessageTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setFootV];
    [self createHeadV];
    self.picsArr = @[].mutableCopy;
    self.picsArr  = @[].mutableCopy;
    [self addPicsWithArr:@[].mutableCopy];
    self.videoStr = nil;
    self.navigationItem.title = @"发布动态";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJFindShopCell" bundle:nil] forCellReuseIdentifier:@"QYZJFindShopCell"];
    
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"TongYongTwoCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.dataArray = @[].mutableCopy;
    self.page = 1;
    [self getData];
       self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           self.page = 1;
           [self getData];
       }];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self getImgDict];
    [self getVideoDict];
    
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

- (void)getData {

    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(100);
    dict[@"type"] = @(1);
    dict[@"other_user_id"] = [zkSignleTool shareTool].session_uid;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_goodsListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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


- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"发布" andImgaeName:@""];
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton *button) {
          
        [weakSelf FaBuDongTai];
        
    };
    [self.view addSubview:view];
}




- (void)createHeadV {
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 20)];
    self.headV.backgroundColor = WhiteColor;

    
    UIView * backV1 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW,10)];
    backV1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.headV addSubview:backV1];
    
    
    UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(10,  CGRectGetMaxY(backV1.frame) + 30, 80, 20)];
    lb2.textColor = CharacterBlack112;
    lb2.font = kFont(14);
    lb2.text = @"动态";
    [self.headV addSubview:lb2];
    
    
    self.desTV = [[IQTextView alloc] initWithFrame:CGRectMake(95, CGRectGetMaxY(backV1.frame) + 10, ScreenW - 110, 60)];
    self.desTV.font = kFont(14);
    self.desTV.placeholder = @"请输入这一刻的想法....";
    [self.headV addSubview:self.desTV];
    
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 10, ScreenW - 110, ww+20)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = WhiteColor;
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
    [button setBackgroundImage:[UIImage imageNamed:@"29"] forState:UIControlStateNormal];
    [imageView addSubview:button];
    button.alpha = 0.8;
    [button addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    button.userInteractionEnabled = YES;
    imageView.hidden = YES;
    
    UIButton * delectVideoBt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) - 10, 3, 20, 20)];
    [delectVideoBt setImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];
    [delectVideoBt addTarget:self action:@selector(deleteVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteTwoV addSubview:delectVideoBt];
    self.deleteBt.hidden = YES;
    self.deleteBt = delectVideoBt;

    
    self.headV.mj_h = CGRectGetMaxY(self.whiteTwoV.frame);
    self.tableView.tableHeaderView = self.headV;
    self.headV.backgroundColor = self.whiteOneV.backgroundColor = self.whiteTwoV.backgroundColor = WhiteColor;
    
}

- (void)deleteVideo {
    self.videoStr = nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.6;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
     UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
       if (view == nil ) {
           view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.6)];
           view.clipsToBounds = YES;
           view.backgroundColor = lineBackColor;
       }
       return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isShowShop) {
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }
    return self.dataArray.count / 2 + self.dataArray.count % 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0 ) {
        return 50;
    }else if (indexPath.section == 1) {
        return 40;
    }
    CGFloat hh = (ScreenW - 30) / 2 * 3 / 4;
    return hh + 40 + 20 + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 || indexPath.section == 1) {
         TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"TongYongTwoCell" forIndexPath:indexPath];
        cell.moreImgV.hidden = cell.TF.hidden = YES;
        cell.swith.hidden = NO;
        cell.swith.userInteractionEnabled = NO;
        if (indexPath.section == 0 && self.isShowShop) {
            cell.lineV.hidden = NO;
            
        }else {
            cell.lineV.hidden = YES;
         
        }
        if (indexPath.section == 0) {
            cell.leftLB.text = @"关联小店";
        }else {
            cell.leftLB.text = @"   商品";
            cell.swith.hidden = YES;
            cell.lineV.hidden = YES;
        }
        cell.swith.on = self.isShowShop;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    QYZJFindShopCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJFindShopCell" forIndexPath:indexPath];
    
    if (indexPath.row * 2 + 2 <= self.dataArray.count) {
        cell.dataArray = [self.dataArray subarrayWithRange:NSMakeRange(indexPath.row * 2 , 2)];
    }else {
        cell.dataArray = [self.dataArray subarrayWithRange:NSMakeRange(indexPath.row * 2 , 1)];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==0){
        self.isShowShop = !self.isShowShop;
        [self.tableView reloadData];
    }
}




- (void)setVideoStr:(NSString *)videoStr {
    _videoStr = videoStr;
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        if (videoStr == nil || videoStr.length == 0) {
            
            self.addBt.hidden = NO;
            self.whiteTwoV.mj_h = 110;
            self.videoImgV.hidden = YES;
            self.headV.mj_h = CGRectGetMaxY(self.whiteTwoV.frame);
            self.tableView.tableHeaderView = self.headV;
            self.deleteBt.hidden = YES;
            
        }else {
            self.addBt.hidden = YES;
            self.videoImgV.hidden = NO;
            self.whiteTwoV.mj_h = (ScreenW - 110)*9/16 + 20;
            self.videoImgV.image = [PublicFuntionTool firstFrameWithVideoURL:[NSURL URLWithString:[QYZJURLDefineTool getVideoURLWithStr:[videoStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]] size:CGSizeMake((ScreenW - 110), (ScreenW - 110)*9/16)];
            self.headV.mj_h = CGRectGetMaxY(self.whiteTwoV.frame);
            self.tableView.tableHeaderView = self.headV;
            self.deleteBt.hidden = NO;
            
        }
        
    });
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

- (void)FaBuDongTai {
    
    if (self.desTV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入动态内容"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"0";
    dict[@"video"] = self.videoStr;
    dict[@"picture"] = [self.picsArr componentsJoinedByString:@","];
    NSMutableArray * goodsA = @[].mutableCopy;
    for (QYZJFindModel * model in self.dataArray) {
        if (model.isSelect) {
            [goodsA addObject:model.ID];
        }
    }
    if (goodsA.count > 0) {
        dict[@"type"] = @"3";
        dict[@"refShopId"] = [self.dataArray firstObject].shopId;
    }
    dict[@"goodsIds"] = [goodsA componentsJoinedByString:@","];
    dict[@"content"] = self.desTV.text;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_insertArticleURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"发帖成功,已进入后台人工审核"];
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


- (void)deleteHitAction:(UIButton *)button {
    [self.picsArr removeObjectAtIndex:button.tag - 100];
    [self addPicsWithArr:self.picsArr];
}

- (void)hitAction:(UIButton *)button {
    
    if (button.tag == self.picsArr.count + 100) {
        //添加图片
        self.isChooseVideo = NO;
        [self addPict];
    }else {
        [[zkPhotoShowVC alloc] initWithArray:self.picsArr index:button.tag - 100];
        
    }
}

//添加选图片
- (void)addVideoaction {
    self.isChooseVideo = YES;
    [self addPict];

}


- (void)captureVideoButtonClick{
    [PublicFuntionTool showCameraVideoWithViewController:self];
    Weak(weakSelf);
    [PublicFuntionTool shareTool].videoBlock = ^(NSData *data) {
        NSMutableDictionary * dict = @{}.mutableCopy;
        dict[@"token"] = self.videoModel.token;
        showProgress * showOb =  [[showProgress alloc] init];
        [showOb showViewOnView:weakSelf.addBt];
        [zkRequestTool NetWorkingUpLoadVeidoWithfileData:data parameters:dict progress:^(CGFloat progress) {
            NSLog(@"====\n%lf",progress);
            showOb.progress = progress;
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"上传视频成功"];
            weakSelf.videoStr = [NSString stringWithFormat:@"%@",responseObject[@"key"]];
                
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [showOb diss];
        }];
        
    };
     
}
- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            
            if (self.isChooseVideo) {
                //视频
                [self captureVideoButtonClick];
            }else {
                    [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                    [self.picsArr addObject:image];
                    [self addPicsWithArr:self.picsArr];
                    [self updateImgsToQiNiuYun];
                }];
            }
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
                imagePickerVc.allowPickingVideo = YES;
                imagePickerVc.allowPickingImage = NO;
                imagePickerVc.allowTakePicture = NO;
            }else {
                imagePickerVc.allowTakeVideo = NO;
                imagePickerVc.allowPickingVideo = NO;
                imagePickerVc.allowPickingImage = YES;
                imagePickerVc.allowTakePicture = YES;
            }
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

- (void)play {
    [PublicFuntionTool presentVideoVCWithNSString:[QYZJURLDefineTool getVideoURLWithStr:self.videoStr] isBenDiPath:NO];
}

#pragma mark ------ 如下是图片和视频的处理上传过程 ------
//视频选择结束
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    [PublicFuntionTool getImageFromPHAsset:asset Complete:^(NSData * _Nonnull data, NSString * _Nonnull str) {
        NSMutableDictionary * dict = @{}.mutableCopy;
        dict[@"token"] = self.videoModel.token;
        showProgress * showOb =  [[showProgress alloc] init];
        [showOb showViewOnView:self.addBt];
        [zkRequestTool NetWorkingUpLoadVeidoWithfileData:data parameters:dict progress:^(CGFloat progress) {
            NSLog(@"====\n%lf",progress);
            showOb.progress = progress;
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"上传视频成功"];
            self.videoStr = [NSString stringWithFormat:@"%@",responseObject[@"key"]];
                
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [showOb diss];
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

