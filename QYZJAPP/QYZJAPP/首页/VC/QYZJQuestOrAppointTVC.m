//
//  QYZJQuestOrAppointTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJQuestOrAppointTVC.h"
#import "QYZJChoosePeopleTVC.h"
@interface QYZJQuestOrAppointTVC ()<TZImagePickerControllerDelegate>
@property(nonatomic,strong)UITextField *titleTF;
@property(nonatomic,strong)IQTextView * desTV;
@property(nonatomic,strong)UIView *whiteOneV,*whiteTwoV,*whiteThreeV,*whiteFourV;
@property(nonatomic,strong)UIImageView *videoImgV;
@property(nonatomic,strong)UIButton *addBt,*luyinBt,*listBt,*switchBt;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *picsArr;
@property(nonatomic,strong)NSString *videoStr,*audioStr;
@property(nonatomic,strong)QYZJTongYongModel *imgModel,*videoModel;
@property(nonatomic,strong)UIButton *deleteBt;
@property(nonatomic,assign)BOOL   isChooseVideo;
@property(nonatomic,strong)UISwitch *switchOn ;
@property(nonatomic,strong)QYZJTongYongModel * audioModel;
@end

@implementation QYZJQuestOrAppointTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.navigationItem.title = @"快捷提问";
    if (self.type == 0) {
           self.navigationItem.title = @"快速预约";
       }
    
    [self setFootV];
    [self createHeadV];
    self.picsArr = @[].mutableCopy;
    [self getImgDict];
    [self getVideoDict];
    
     [self getAudioDict];
    
}

- (void)getAudioDict {
    
    [zkRequestTool getUpdateAudioModelWithCompleteModel:^(QYZJTongYongModel *model) {
        self.audioModel = model;
    }];
    
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
    [self.headV addSubview:self.titleTF];
    
    UIView * backV1 =[[UIView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, 0.6)];
    backV1.backgroundColor = lineBackColor;
    [self.headV addSubview:backV1];
    
    self.whiteThreeV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backV1.frame), ScreenW, 135)];
    self.whiteThreeV.backgroundColor = WhiteColor;
    [self.headV addSubview:self.whiteThreeV];
    
    UILabel * leftLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 80, 20)];
    leftLB.font = kFont(15);
    leftLB.textColor = CharacterBlackColor;
    leftLB.text = @"需求描述";
    [self.whiteThreeV addSubview:leftLB];
    
    self.desTV = [[IQTextView alloc] initWithFrame:CGRectMake(95 , 10, ScreenW - 110, 60)];
    self.desTV.textAlignment = NSTextAlignmentLeft;
    self.desTV.placeholder = @"请输入需求描述";
    self.desTV.textColor = CharacterBlackColor;
    self.desTV.font = kFont(14);
    [self.whiteThreeV addSubview:self.desTV];
    
    self.luyinBt = [[UIButton alloc] initWithFrame:CGRectMake(100, 80, 45, 45)];
    [self.luyinBt setBackgroundImage:[UIImage imageNamed:@"luyin"] forState:UIControlStateNormal];
    [self.whiteThreeV addSubview:self.luyinBt];
    [self.luyinBt addTarget:self action:@selector(luYinAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.listBt = [[UIButton alloc] initWithFrame:CGRectMake(155, 90, ScreenW - 155 - 20, 25)];
    [self.listBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
    [self.listBt setImage:[UIImage imageNamed:@"sy"] forState:UIControlStateNormal];
    [self.listBt setTitle:@"32" forState:UIControlStateNormal];
     [self.listBt setTitle:@"语音描述" forState:UIControlStateNormal];
    self.listBt.titleLabel.font = kFont(14);
    self.listBt.hidden = YES;
    self.listBt.layer.cornerRadius = 12.5;
    self.listBt.clipsToBounds = YES;
    self.listBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.listBt setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
    [self.listBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0,  0)];
    [self.whiteThreeV addSubview:self.listBt];
    
    UIView * backV5 =[[UIView alloc] initWithFrame:CGRectMake(0, 134.4, ScreenW, 0.6)];
    backV5.backgroundColor = lineBackColor;
    [self.whiteThreeV addSubview:backV5];
    
    
    CGFloat ww = 90;
    self.whiteOneV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.whiteThreeV.frame), ScreenW, ww+40)];
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, self.whiteOneV.mj_h - 0.6, ScreenW, 0.6)];
    backV.backgroundColor = lineBackColor;
    [self.whiteOneV addSubview:backV];
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
    
    [self addPicsWithArr:self.picsArr];
    
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
     [delectVideoBt addTarget:self action:@selector(deleteVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteTwoV addSubview:delectVideoBt];
    self.deleteBt = delectVideoBt;
    self.deleteBt.hidden = YES;
    
    
    self.whiteFourV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.whiteTwoV.frame), ScreenW, 60)];
    self.whiteFourV.backgroundColor = WhiteColor;
    
    UIView * backV6 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    backV6.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.whiteFourV addSubview:backV6];
    
    UILabel * lb5 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 50)];
    lb5.textColor = CharacterBlack112;
    lb5.font = kFont(14);
    lb5.text = @"是否公开";
    [self.whiteFourV addSubview:lb5];
    [self.headV addSubview:self.whiteFourV];
    
    
    self.switchOn = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenW - 75  , 20, 60, 30)];
    [self.whiteFourV addSubview:self.switchOn];
    self.switchOn.on = YES;
    [self.switchOn setOnTintColor:OrangeColor];
    
    self.switchBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 75, 10, 60, 50)];
    [self.whiteFourV addSubview:self.switchBt];
    [self.switchBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    if (self.type == 0) {
        self.whiteFourV.hidden = YES;
        self.headV.mj_h = CGRectGetMaxY(self.whiteTwoV.frame);
    }else {
        self.whiteFourV.hidden = NO;
        self.headV.mj_h= CGRectGetMaxY(self.whiteFourV.frame);
    }
    self.tableView.tableHeaderView = self.headV;
    
    
    
    
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

    [[QYZJLuYinView LuYinTool] show];
              Weak(weakSelf);
              [QYZJLuYinView LuYinTool].statusBlock = ^(BOOL isStare,NSData *mediaData) {
      
                  dispatch_async(dispatch_get_main_queue() , ^{
                      if (isStare) {
                          weakSelf.navigationItem.title = @"正在录音...";
                      }else {
                          if (weakSelf.type == 0) {
                              weakSelf.navigationItem.title = @"快速预约";
                          }else {
                              weakSelf.navigationItem.title = @"快速提问";
                          }
                          
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
               [SVProgressHUD showSuccessWithStatus:@"上传音频成功"];
               
               self.audioStr = responseObject[@"key"];
               [self.tableView reloadData];
               
           } failure:^(NSURLSessionDataTask *task, NSError *error) {
               NSLog(@"\n\n------%@",error);
           }];
}



- (void)deleteVideo {
    self.videoStr = nil;
}

- (void)clickAction:(UIButton *)button {
    self.switchOn.on = !self.switchOn.on;
}



- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"完成" andImgaeName:@""];
    if (self.isMore) {
        view.titleStr = @"选择答人";
    }
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton *button) {
        if (weakSelf.isMore) {
         QYZJChoosePeopleTVC * vc =[[QYZJChoosePeopleTVC alloc] init];
         vc.hidesBottomBarWhenPushed = YES;
         vc.cityID = self.cityID;
         vc.type = 2 - self.type;
         vc.titleStr = self.titleTF.text;
         vc.videoStr = self.videoStr;
         vc.picArr = self.picsArr;
         vc.desStr = self.desTV.text;
         vc.strAudionStr = self.audioStr;
            if (self.switchOn.on) {
                vc.isOpen = 1;
            }else {
               vc.isOpen = 0;
            }
         [self.navigationController pushViewController:vc animated:YES];
        }else {
           [weakSelf questOrAppiontAction];
        }
        
    };
    [self.view addSubview:view];
}


- (void)questOrAppiontAction {
    
    if (self.titleTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入标题"];
        return;
    }
    if (self.desTV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入需求描述"];
    }
    
    NSString * url = [QYZJURLDefineTool user_addQuestionURL];
    if (self.type == 0) {
        url = [QYZJURLDefineTool user_appointCaipanURL];
    }

    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"title"] = self.titleTF.text;
    dict[@"context"] = self.desTV.text;
    dict[@"pic_url"] = [self.picsArr componentsJoinedByString:@","];
    dict[@"video_url"] = self.videoStr;
    dict[@"media_url"] = self.audioStr;
    if (self.switchOn.on) {
        dict[@"is_open"] = @"1";
    }else {
       dict[@"is_open"] = @"0";
    }
    dict[@"b_user_ids"] = self.ID;
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

- (void)wecharPayWithID:(NSString *)ID {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pay_money"]= @(self.money);
    dict[@"type"] = @(2-self.type);
    dict[@"id"] = ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_wechatPayURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            QYZJTongYongModel * mm = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
            QYZJZhiFuVC * vc =[[QYZJZhiFuVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.model = mm;
            vc.ID = self.ID;
            vc.type = 5+self.type;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}




- (void)setVideoStr:(NSString *)videoStr {
    _videoStr = videoStr;
    if (videoStr == nil || videoStr.length == 0) {
        
        self.addBt.hidden = NO;
        self.whiteTwoV.mj_h = 110;
        self.videoImgV.hidden =self.deleteBt.hidden = YES;
        self.headV.mj_h = CGRectGetMaxY(self.whiteTwoV.frame);
        self.tableView.tableHeaderView = self.headV;
        self.whiteFourV.mj_y = CGRectGetMaxY(self.whiteTwoV.frame);
        
    }else {
        self.addBt.hidden = YES;
        self.videoImgV.hidden =self.deleteBt.hidden = NO;
        self.whiteTwoV.mj_h = (ScreenW - 110)*9/16 + 20;
        self.videoImgV.image = [PublicFuntionTool firstFrameWithVideoURL:[NSURL URLWithString:[QYZJURLDefineTool getVideoURLWithStr:videoStr]] size:CGSizeMake((ScreenW - 110), (ScreenW - 110)*9/16)];
        self.headV.mj_h = CGRectGetMaxY(self.whiteTwoV.frame);
        self.tableView.tableHeaderView = self.headV;
        self.whiteFourV.mj_y = CGRectGetMaxY(self.whiteTwoV.frame);
        
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
