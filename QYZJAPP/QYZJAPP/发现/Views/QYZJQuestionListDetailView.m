//
//  QYZJQuestionListDetailView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJQuestionListDetailView.h"


@interface QYZJQuestionListDetailView()
@property(nonatomic,strong)UIView *picView,*mediaView,*videoView,*gatyV;
@property(nonatomic,strong)UILabel *titleLB,*nameLB,*numberLB;
@property(nonatomic,strong)UIButton *listBt;
@end

@implementation QYZJQuestionListDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        backV.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:backV];
        
        
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, ScreenW - 10 - 100, 20)];
        self.titleLB.numberOfLines = 0;
        self.titleLB.font = kFont(15);
        [self addSubview:self.titleLB];
        
        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLB.frame) + 10, ScreenW - 20, 20)];
        self.nameLB.textColor = CharacterBlack112;
        self.nameLB.numberOfLines = 0;
        self.nameLB.font = kFont(14);
        [self addSubview:self.nameLB];
        
        
        self.numberLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 100, 25, 90, 20)];
        self.numberLB.textColor = CharacterBlack112;
        self.numberLB.font = kFont(13);
        self.numberLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.numberLB];
        
        self.picView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameLB.frame), ScreenW, 0)];
        [self addSubview:self.picView];
        
        
        
        self.mediaView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.picView.frame), ScreenW, 0)];
        [self addSubview:self.mediaView];
        
        self.listBt = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 200, 25)];
              [self.listBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
              [self.listBt setImage:[UIImage imageNamed:@"sy"] forState:UIControlStateNormal];
              [self.listBt setTitle:@"32" forState:UIControlStateNormal];
              self.listBt.titleLabel.font = kFont(14);
              self.listBt.layer.cornerRadius = 12.5;
              self.listBt.clipsToBounds = YES;
              self.listBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
              [self.listBt setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
              [self.listBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0,  0)];
              [self.mediaView addSubview:self.listBt];
        
        
        self.videoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mediaView.frame), ScreenW, 0)];
        [self addSubview:self.videoView];
        self.gatyV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        self.gatyV.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.gatyV];
        
        
    }
    return self;
}

- (void)setDataModel:(QYZJFindModel *)dataModel {
    _dataModel = dataModel;
    self.titleLB.attributedText = [dataModel.title getMutableAttributeStringWithFont:15 lineSpace:3 textColor:[UIColor blackColor]];
    CGFloat hh = [dataModel.title getHeigtWithFontSize:15 lineSpace:3 width:ScreenW - 110];
    if (hh<20) {
        hh = 20;
    }
   
    
    self.nameLB.mj_y = CGRectGetMaxY(self.titleLB.frame) + 10;
    self.nameLB.attributedText = [dataModel.context getMutableAttributeStringWithFont:14 lineSpace:3 textColor:[UIColor blackColor]];
    self.nameLB.mj_h = [dataModel.title getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 20];
     self.titleLB.mj_h = hh;
    
    self.numberLB.text = [NSString stringWithFormat:@"%ld人旁听",dataModel.sit_on_num];
    self.picView.mj_y = CGRectGetMaxY(self.nameLB.frame);
    if (dataModel.pic_url.length == 0) {
        self.picView.mj_h = 0;
       
    }else {
        [self setPictWIthArr:[dataModel.pic_url componentsSeparatedByString:@","]];
    }
    self.mediaView.mj_y = CGRectGetMaxY(self.picView.frame);
    if (dataModel.media_url.length == 0) {
        self.mediaView.mj_h = 0;
    }else {
        
        if (dataModel.is_open) {
            [self.listBt setTitle:@"点击播放" forState:UIControlStateNormal];
            [self.listBt addTarget:self action:@selector(listAction:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            [self.listBt setTitle:@"不公开" forState:UIControlStateNormal];
        }
      
        self.mediaView.mj_h = 45;
        
        
    }
    self.videoView.mj_y = CGRectGetMaxY(self.mediaView.frame);
    if (dataModel.video_url.length == 0) {
        self.videoView.mj_h = 0;
        
    }else {
        
        self.videoView.mj_h = (ScreenW - 20) * 9 / 16 + 20;
        [self.videoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10,(ScreenW - 20) , (ScreenW - 20) * 9 / 16)];
        imgV.image = [PublicFuntionTool firstFrameWithVideoURL:[NSURL URLWithString:dataModel.video_url] size:CGSizeMake((ScreenW - 20), (ScreenW - 20) * 9 / 16)];
        UIButton * button = [[UIButton alloc]init];
        button.frame = CGRectMake((ScreenW - 20)/2 - 25, ((ScreenW - 20) * 9 / 16)/2-25, 50, 50);
        [button setBackgroundImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
        [imgV addSubview:button];
        
        [button addTarget:self action:@selector(videoPlayAction:) forControlEvents:UIControlEventTouchUpInside];
        button.alpha = 0.8;
        button.userInteractionEnabled = NO;
        [self.videoView addSubview:imgV];
        
    }
    self.gatyV.mj_y = CGRectGetMaxY(self.videoView.frame);
    self.headHeight = CGRectGetMaxY(self.gatyV.frame);
    
}

- (void)listAction:(UIButton *)button {
    
    [[PublicFuntionTool shareTool] palyMp3WithNSSting:self.dataModel.media_url isLocality:NO];;
    [button setTitle:@"正在播放..." forState:UIControlStateNormal];
       [[PublicFuntionTool shareTool] palyMp3WithNSSting:self.dataModel.media_url isLocality:NO];
       [PublicFuntionTool shareTool].findPlayBlock = ^{
           [button setTitle:@"点击播放" forState:UIControlStateNormal];
       };
    
    
}

- (void)setPictWIthArr:(NSArray *)picArr {
    
    [self.picView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.picView.mj_y = CGRectGetMaxY(self.nameLB.frame);
    CGFloat space = 15;
    CGFloat ww = (ScreenW - 45 - 80)/2.0;
    self.picView.mj_h = (picArr.count / 2 + picArr.count % 2) * (space + ww) + space;
    
    for (int i = 0 ; i< picArr.count; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(space + (ww + space)* (i%2), space +( ww + space) * (i/2), ww, ww)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = i+100;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInView:)];
        tap.cancelsTouchesInView = YES;//设置成N O表示当前控件响应后会传播到其他控件上，默认为YES
        [imageView addGestureRecognizer:tap];
        [self.picView addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:picArr[i]]]  placeholderImage:[UIImage imageNamed:@"789"]];
  
    }
    
    
}


//点击图片
- (void)tapInView:(UITapGestureRecognizer *)tap {
    UIImageView * imgV = (UIImageView *)tap.view;
    NSInteger tag = imgV.tag - 100;
    
    NSArray * arr = [self.dataModel.pic_url componentsSeparatedByString:@","];
    NSMutableArray * picArr = @[].mutableCopy;
    for (NSString * str  in arr) {
        [picArr addObject:[NSString stringWithFormat:@"%@",str]];
    }
    [[zkPhotoShowVC alloc] initWithArray:picArr index:tag];
    
}


- (void)videoPlayAction:(UIButton *)button {
    
     [PublicFuntionTool presentVideoVCWithNSString:[QYZJURLDefineTool getVideoURLWithStr:self.dataModel.video_url] isBenDiPath:NO];
    
    
}

@end
