//
//  QYZJShopDetailHeadView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJShopDetailHeadView.h"

@interface QYZJShopDetailHeadView()
@property(nonatomic,strong)UIView *picView,*picViewTwo,*mediaView,*videoView,*gatyV;
@property(nonatomic,strong)UILabel *titleLB,*nameLB,*numberLB,*titleLBTwo,*contentLB;
@end

@implementation QYZJShopDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        backV.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:backV];
        
        self.picView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenW, 0)];
        [self addSubview:self.picView];
        
        self.picViewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenW, 0)];
              [self addSubview:self.picViewTwo];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, ScreenW - 20, 20)];
        self.titleLB.numberOfLines = 0;
        self.titleLB.font = kFont(14);
        [self addSubview:self.titleLB];
        
        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLB.frame) + 10, ScreenW - 20, 20)];
        self.nameLB.textColor = OrangeColor;
        self.nameLB.numberOfLines = 0;
        self.nameLB.font = kFont(14);
        [self addSubview:self.nameLB];
        
        
        self.titleLBTwo = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, ScreenW - 20, 20)];
        self.titleLBTwo.numberOfLines = 0;
        self.titleLBTwo.font = kFont(14);
        [self addSubview:self.titleLBTwo];
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLB.frame) + 10, ScreenW - 20, 20)];
        self.contentLB.textColor = CharacterColor80;
        self.contentLB.numberOfLines = 0;
        self.contentLB.font = kFont(14);
        [self addSubview:self.contentLB];
        

        
        self.mediaView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.picView.frame), ScreenW, 0)];
        [self addSubview:self.mediaView];
        
        self.videoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mediaView.frame), ScreenW, 0)];
        [self addSubview:self.videoView];
        self.gatyV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        self.gatyV.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.gatyV];
        
        self.backgroundColor = [UIColor redColor];
        
        
        
    }
    return self;
}


- (void)setDataModel:(QYZJFindModel *)dataModel {
    _dataModel = dataModel;
    if (dataModel.pic.length == 0) {
        self.picView.mj_h = 0;
        
    }else {
        [self setPictWIthArr:[dataModel.pic componentsSeparatedByString:@","] isTwoPic:NO];
    }
    
    self.titleLB.mj_y = CGRectGetMaxY(self.picView.frame) + 10;
    self.titleLB.attributedText = [dataModel.name getMutableAttributeStringWithFont:15 lineSpace:3 textColor:[UIColor blackColor]];
    CGFloat hh = [dataModel.name getHeigtWithFontSize:15 lineSpace:3 width:ScreenW - 20];
    if (hh<20) {
        hh = 20;
    }
    self.titleLB.mj_h = hh;
    
    self.nameLB.mj_y = CGRectGetMaxY(self.titleLB.frame) + 10;
    self.nameLB.text = [NSString stringWithFormat:@"￥%0.2f",dataModel.price];

    self.gatyV.mj_y = CGRectGetMaxY(self.nameLB.frame) + 15;
    self.titleLBTwo.text = @"商品详情";
    self.titleLBTwo.mj_y = CGRectGetMaxY(self.gatyV.frame) + 10;
    self.contentLB.mj_y = CGRectGetMaxY(self.titleLBTwo.frame) + 10;
    self.contentLB.attributedText = [dataModel.context getMutableAttributeStringWithFont:15 lineSpace:3 textColor:[UIColor blackColor]];
    CGFloat h2 = [dataModel.context getHeigtWithFontSize:15 lineSpace:3 width:ScreenW - 20];
    if (h2<20) {
        h2 = 20;
    }
    self.contentLB.mj_h = h2;
    
    self.picViewTwo.mj_y = CGRectGetMaxY(self.contentLB.frame);
    if (dataModel.pic.length == 0) {
           self.picViewTwo.mj_h = 0;
           
       }else {
           [self setPictWIthArr:[dataModel.pic componentsSeparatedByString:@","]  isTwoPic:YES];
       }
    self.height = CGRectGetMaxY(self.picViewTwo.frame) + 10;
    
}


- (void)setPictWIthArr:(NSArray *)picArr isTwoPic:(BOOL)isTwoPic {
    
    CGFloat space = 15;
       CGFloat ww = (ScreenW - 2*space);
       CGFloat hh = ww * 9 / 16;
    
    if (isTwoPic) {
        [self.picViewTwo.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
          self.picViewTwo.clipsToBounds = YES;
          self.picViewTwo.mj_h = (picArr.count) * (space + hh) + space;
    }else {
        [self.picView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
          self.picView.clipsToBounds = YES;
          self.picView.mj_h = (picArr.count) * (space + hh) + space;
    }
  
    for (int i = 0 ; i< picArr.count; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(space , space +( hh + space) * (i), ww, hh)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = i+100;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInView:)];
        tap.cancelsTouchesInView = YES;//设置成N O表示当前控件响应后会传播到其他控件上，默认为YES
        [imageView addGestureRecognizer:tap];
       
        if (isTwoPic) {
            [self.picViewTwo addSubview:imageView];
        }else {
            [self.picView addSubview:imageView];
        }
        [imageView sd_setImageWithURL:[NSURL URLWithString:picArr[i]] placeholderImage:[UIImage imageNamed:@"369"]];
        
    }
    
    
}


//点击图片
- (void)tapInView:(UITapGestureRecognizer *)tap {
    UIImageView * imgV = (UIImageView *)tap.view;
    NSInteger tag = imgV.tag - 100;
    
    NSArray * arr = [self.dataModel.pic componentsSeparatedByString:@","];
    NSMutableArray * picArr = @[].mutableCopy;
    for (NSString * str  in arr) {
        [picArr addObject:[NSString stringWithFormat:@"%@",str]];
    }
    [[zkPhotoShowVC alloc] initWithArray:picArr index:tag];
    
}


- (void)videoPlayAction:(UIButton *)button {
    
    [PublicFuntionTool presentVideoVCWithNSString:self.dataModel.video_url isBenDiPath:NO];
    
    
}


@end
