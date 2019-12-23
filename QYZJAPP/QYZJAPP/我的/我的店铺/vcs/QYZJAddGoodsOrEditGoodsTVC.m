//
//  QYZJAddGoodsOrEditGoodsTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJAddGoodsOrEditGoodsTVC.h"

@interface QYZJAddGoodsOrEditGoodsTVC ()<TZImagePickerControllerDelegate,zkPickViewDelelgate>
@property(nonatomic,strong)UITextField *titleTF,*typeTF,*moneyTF;
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
@property(nonatomic,strong)QYZJTongYongModel *imgModel,*videoModel;
@property(nonatomic,strong)NSArray *typeArr;//类型arr
@property(nonatomic,assign)NSInteger shopType; //商品类型
@property(nonatomic,strong)QYZJFindModel *dataModel;
@end

@implementation QYZJAddGoodsOrEditGoodsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shopType = -1;
    if (self.dataModel != nil) {
        self.shopType = [self.dataModel.type intValue];
    }
    self.picsArr = @[].mutableCopy;
    self.typeArr = @[@"普通商品",@"设计师图纸"];
    [self setFootV];
    if (self.type == 0) {
        [self createHeadV];
    }else {
       [self getData];
    }
   
    [self getImgDict];
}

- (void)setFootV {
    
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    if (self.type == 1) {
        
        self.navigationItem.title = @"修改商品";
        KKKKFootView * view =  [[PublicFuntionTool shareTool] createFootvTwoWithLeftTitle:@"下架" letfTietelColor:OrangeColor rightTitle:@"上架" rightColor:WhiteColor];
        Weak(weakSelf);
        view.footViewClickBlock = ^(UIButton *button) {
            NSLog(@"\n\n%@",@"编辑或者完成");
            if (button.tag == 0) {
                 [weakSelf addGoodsOrEditGoods:0];
            }else {
                 [weakSelf addGoodsOrEditGoods:1];
            }
        };
        [self.view addSubview:view];
        
    }else {
        self.navigationItem.title = @"添加商品";
        KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"发布" andImgaeName:@""];
        if (self.type == 2) {
            view.titleStr = @"上架";
            self.navigationItem.title = @"修改商品";
        }
        Weak(weakSelf);
        view.footViewClickBlock = ^(UIButton *button) {
            if (weakSelf.type == 2) {
                [weakSelf addGoodsOrEditGoods:1];
            }else {
                 [weakSelf addGoodsOrEditGoods:2];
            }
            
        };
        [self.view addSubview:view];
        
        
    }
    
}



//2 添加 0 下架 1 上架
- (void)addGoodsOrEditGoods:(NSInteger )isOpen {
    
    
    if (isOpen == 1 || isOpen == 2) {
        if (self.titleTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入商品名称"];
            return;
        }
        if (self.typeTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请选择类型"];
            return;
        }
        if (self.moneyTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入商品价格"];
            return;
        }
        if (self.desTV.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入商品描述"];
            return;
        }
        if (self.picsArr.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"请选择图片"];
            return;
        }
        if (self.shopType == -1) {
            [SVProgressHUD showErrorWithStatus:@"请选择商品类型"];
            return;
        }
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    NSString * url = [QYZJURLDefineTool user_addGoodsURL];

    if (isOpen == 0) {
        url = [QYZJURLDefineTool user_editGoodsURL];
        dict[@"is_open"] = @(isOpen);
        dict[@"id"] = self.goodsId;
    }else {
        if (isOpen == 1) {
            url = [QYZJURLDefineTool user_editGoodsURL];
            dict[@"is_open"] = @(isOpen);
            dict[@"id"] = self.goodsId;
        }
        dict[@"shop_id"] = self.shopId;
        dict[@"name"] = self.titleTF.text;
        dict[@"pic"] = [self.picsArr componentsJoinedByString:@","];
        dict[@"context"] = self.desTV.text;
        dict[@"price"] = self.moneyTF.text;
        dict[@"type"] = @(self.shopType);
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            if (isOpen == 2) {
                [SVProgressHUD showSuccessWithStatus:@"添加商品成功"];
            }else if (isOpen == 1){
                [SVProgressHUD showSuccessWithStatus:@"商品修改成功"];
            }else {
               [SVProgressHUD showSuccessWithStatus:@"商品下架成功"];
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
    lb1.text = @"名称";
    [self.headV addSubview:lb1];
    
    self.titleTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, ScreenW - 110, 30)];
    self.titleTF.font = kFont(14);
    self.titleTF.placeholder = @"请输入商品名称";
    self.titleTF.text = self.dataModel.name;
    [self.headV addSubview:self.titleTF];
    
    UIView * backV1 =[[UIView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, 0.6)];
    backV1.backgroundColor = lineBackColor;
    [self.headV addSubview:backV1];
    
    
    self.typeTF = [[UITextField alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(backV1.frame) + 10, ScreenW - 110 - 30, 30)];
    self.typeTF.font = kFont(14);
    self.typeTF.placeholder = @"请选择商品类型";
    self.typeTF.userInteractionEnabled = NO;
    if (self.type != 0) {
        self.typeTF.text = self.typeArr[[self.dataModel.type intValue]];
        self.shopType = [self.dataModel.type intValue];
    }
    [self.headV addSubview:self.typeTF];
    
    UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 30, CGRectGetMaxY(backV1.frame) + 15, 20,   20)];
    imgV.image = [UIImage imageNamed:@"more"];
    [self.headV addSubview:imgV];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backV1.frame)+5, ScreenW, 40)];
    [self.headV addSubview:button];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * backV5 =[[UIView alloc] initWithFrame:CGRectMake(0, 100, ScreenW, 0.6)];
    backV5.backgroundColor = lineBackColor;
    [self.headV addSubview:backV5];
    
    UILabel * lb5 = [[UILabel alloc] initWithFrame:CGRectMake(10,  CGRectGetMaxY(backV1.frame) + 15, 80, 20)];
    lb5.textColor = CharacterBlack112;
    lb5.font = kFont(14);
    lb5.text = @"类型";
    [self.headV addSubview:lb5];
    
    
    //价格
    UILabel * lb6 = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, 80, 20)];
    lb6.textColor = CharacterBlack112;
    lb6.font = kFont(14);
    lb6.text = @"价格";
    [self.headV addSubview:lb6];
    
    self.moneyTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 110, ScreenW - 110, 30)];
    self.moneyTF.font = kFont(14);
    self.moneyTF.keyboardType = UIKeyboardTypeDecimalPad;
    self.moneyTF.placeholder = @"请输入商品价格";
    if (self.dataModel != nil) {
        self.moneyTF.text = [NSString stringWithFormat:@"%0.2f",self.dataModel.price];
    }
    [self.headV addSubview:self.moneyTF];
    
    UIView * backV6 =[[UIView alloc] initWithFrame:CGRectMake(0, 150, ScreenW, 0.6)];
    backV6.backgroundColor = lineBackColor;
    [self.headV addSubview:backV6];
    
    
    
    UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(10,  CGRectGetMaxY(backV6.frame) + 30, 80, 20)];
    lb2.textColor = CharacterBlack112;
    lb2.font = kFont(14);
    lb2.text = @"阶段描述";
    //    if (self.type == 1) {
    //        lb2.text = @"内容";
    //    }
    [self.headV addSubview:lb2];
    self.desTV = [[IQTextView alloc] initWithFrame:CGRectMake(95, CGRectGetMaxY(backV6.frame) + 10, ScreenW - 110, 60)];
    self.desTV.font = kFont(14);
    self.desTV.placeholder = @"请输入商品描述";
    //    if (self.type == 1) {
    //        self.desTV.placeholder = @"请输入内容";
    //    }
    [self.headV addSubview:self.desTV];
    self.desTV.text = self.dataModel.context;
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
    
    self.headV.mj_h = CGRectGetMaxY(self.whiteOneV.frame);
    self.tableView.tableHeaderView = self.headV;
    self.headV.backgroundColor = self.whiteOneV.backgroundColor = self.whiteTwoV.backgroundColor = WhiteColor;
    if (self.dataModel != nil) {
        self.picsArr = [self.dataModel.pic componentsSeparatedByString:@","].mutableCopy;
        [self addPicsWithArr:self.picsArr];
    }
   
     [self addPicsWithArr:self.picsArr];
}

- (void)click:(UIButton *)button {
    [self.tableView endEditing:YES];
    zkPickView * pickV = [[zkPickView alloc] init];
    pickV.arrayType = titleArray;
    pickV.array = self.typeArr.mutableCopy;
    pickV.selectLb.text = @"";
    pickV.delegate = self;
    [pickV show];
    
}

#pragma mark ---- 点击条件 -----
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex {
    
    self.shopType = leftIndex;
    self.typeTF.text = self.typeArr[leftIndex];
    
}

- (void)setVideoStr:(NSString *)videoStr {
    _videoStr = videoStr;
    if (videoStr == nil || videoStr.length == 0) {
        
        self.addBt.hidden = NO;
        self.whiteTwoV.mj_h = 110;
        self.videoImgV.hidden = YES;
        self.headV.mj_h = CGRectGetMaxY(self.whiteTwoV.frame);
        self.tableView.tableHeaderView = self.headV;
        
    }else {
        self.addBt.hidden = YES;
        self.videoImgV.hidden = NO;
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
        [self.tableView endEditing:YES];
        self.isChooseVideo = NO;
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
            
            imagePickerVc.allowTakeVideo = NO;
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

- (void)getImgDict {
    
    
    
    [zkRequestTool getUpdateImgeModelWithCompleteModel:^(QYZJTongYongModel *model) {
        self.imgModel = model;
    }];
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.goodsId;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_goodsInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.dataModel = [QYZJFindModel mj_objectWithKeyValues:responseObject[@"result"]];
            [self createHeadV];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}



@end
