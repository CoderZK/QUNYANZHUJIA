//
//  QYZJAddGoodsOrEditGoodsTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJAddGoodsOrEditGoodsTVC.h"

@interface QYZJAddGoodsOrEditGoodsTVC ()<TZImagePickerControllerDelegate>
@property(nonatomic,strong)UITextField *titleTF,*typeTF;
@property(nonatomic,strong)IQTextView * desTV;
@property(nonatomic,strong)UIView *whiteOneV,*whiteTwoV;
@property(nonatomic,strong)UIImageView *videoImgV;
@property(nonatomic,strong)UIButton *addBt;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *picsArr;
@property(nonatomic,strong)NSString *videoStr;
@property(nonatomic,assign)BOOL   isChooseVideo;

@end

@implementation QYZJAddGoodsOrEditGoodsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setFootV];
    [self createHeadV];
    
}

- (void)setFootV {
    
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    if (self.type == 1) {
        
        self.navigationItem.title = @"修改商品";
        
        
        KKKKFootView * view =  [[PublicFuntionTool shareTool] createFootvTwoWithLeftTitle:@"下架" letfTietelColor:OrangeColor rightTitle:@"上架" rightColor:WhiteColor];
        view.footViewClickBlock = ^(UIButton *button) {
            NSLog(@"\n\n%@",@"编辑或者完成");
            if (button.tag == 0) {
                
                
            }else {
                
                
                
            }
            
            
        };
        [self.view addSubview:view];
        
    }else {
        self.navigationItem.title = @"添加商品";
        
        KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"发布" andImgaeName:@""];
        Weak(weakSelf);
        view.footViewClickBlock = ^(UIButton *button) {
            NSLog(@"\n\n%@",@"完成");
            
        };
        [self.view addSubview:view];
        
        
    }
    
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
    self.titleTF.text = self.dataModel.name;
    [self.headV addSubview:self.titleTF];
    
    UIView * backV1 =[[UIView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, 0.6)];
    backV1.backgroundColor = lineBackColor;
    [self.headV addSubview:backV1];
    
    
    
    
    
    self.typeTF = [[UITextField alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(backV1.frame) + 10, ScreenW - 110 - 30, 30)];
    self.typeTF.font = kFont(14);
    self.typeTF.placeholder = @"请输入标题";
    self.typeTF.userInteractionEnabled = NO;
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
    
    
    
    UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(10,  CGRectGetMaxY(backV5.frame) + 30, 80, 20)];
    lb2.textColor = CharacterBlack112;
    lb2.font = kFont(14);
    lb2.text = @"阶段描述";
    if (self.type == 1) {
        lb2.text = @"内容";
    }
    [self.headV addSubview:lb2];
    self.desTV = [[IQTextView alloc] initWithFrame:CGRectMake(95, CGRectGetMaxY(backV5.frame) + 10, ScreenW - 110, 60)];
    self.desTV.font = kFont(14);
    self.desTV.placeholder = @"请输入阶段描述";
    if (self.type == 1) {
        self.desTV.placeholder = @"请输入内容";
    }
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 10, ScreenW, ww+20)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.whiteOneV addSubview:self.scrollView];
    
    self.headV.mj_h = CGRectGetMaxY(self.whiteOneV.frame);
    self.tableView.tableHeaderView = self.headV;
    self.headV.backgroundColor = self.whiteOneV.backgroundColor = self.whiteTwoV.backgroundColor = WhiteColor;
 
    [self addPicsWithArr:@[]];
    
}

- (void)click:(UIButton *)button {
    
    
    
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
        self.videoImgV.image = [PublicFuntionTool firstFrameWithVideoURL:[NSURL URLWithString:videoStr] size:CGSizeMake((ScreenW - 110), (ScreenW - 110)*9/16)];
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
            [anNiuBt setBackgroundImage:picsArr[i] forState:UIControlStateNormal];
            
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
                [self addPicsWithArr:self.picsArr];
                
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

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    
    NSLog(@"%@",asset);
    
    //    [PublicFuntionTool getImageFromPHAsset:asset Complete:^(NSData * _Nonnull data, NSString * _Nonnull str) {
    //
    //
    //
    //    }];
}


- (void)play {
    
    [PublicFuntionTool presentVideoVCWithNSString:self.videoStr isBenDiPath:NO];
    
}




@end
