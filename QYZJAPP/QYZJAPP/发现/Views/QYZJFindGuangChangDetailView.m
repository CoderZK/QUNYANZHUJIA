//
//  QYZJFindGuangChangDetailView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFindGuangChangDetailView.h"

@interface QYZJFindGuangChangDetailView()
@property(nonatomic,strong)UIButton *headBt,*zanBt,*collectBt;
@property(nonatomic,strong)UILabel *contentLB,*timeLB,*nameLB;
@property(nonatomic,strong)UIView * ViewOne,*viewTwo,*viewThree,*viewFour,*lineV,*gayV;

@end

@implementation QYZJFindGuangChangDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        self.headBt.layer.cornerRadius = 25;
        self.headBt.clipsToBounds = YES;
        self.headBt.backgroundColor = [UIColor redColor];
        self.headBt.tag = 10;
        [self.headBt addTarget:self action:@selector(goodBtAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.headBt];
        
        self.nameLB = [[UILabel alloc] init];
        self.nameLB.font = kFont(15);
        
        [self addSubview:self.nameLB];
        self.nameLB.frame = CGRectMake(75, 30, 120, 20);
        
        self.timeLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 135, 30, 125, 20)];
        self.timeLB.font = kFont(14);
        self.timeLB.textAlignment = NSTextAlignmentRight;
        self.timeLB.textColor = CharacterBlack112;
        [self addSubview:self.timeLB];
        
        self.contentLB = [[UILabel alloc] init];
        self.contentLB.font = kFont(14);
        self.contentLB.numberOfLines = 0;
        [self addSubview:self.contentLB];
        self.contentLB.frame = CGRectMake(10, 80, ScreenW - 20, 20);
        
        
        self.ViewOne = [[UIView alloc] init];
        [self addSubview:self.ViewOne];
        self.ViewOne.frame = CGRectMake(10, 100, ScreenW - 20, 10);
        
        self.viewTwo = [[UIView alloc] init];
        [self addSubview:self.viewTwo];
        self.viewTwo.frame = CGRectMake(10, 110, ScreenW - 20, 10);
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 120, ScreenW, 0.6)];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
        self.lineV = backV;
        
        self.viewThree = [[UIView alloc] init];
        [self addSubview:self.viewThree];
        self.viewThree.frame = CGRectMake(10, 121, ScreenW - 20, 10);
        
        self.viewFour = [[UIView alloc] init];
        [self addSubview:self.viewFour];
        self.viewFour.frame = CGRectMake(10, 121, ScreenW - 20, 60);
        
        
        self.gayV = [[UIView alloc] initWithFrame:CGRectMake(0, 131, ScreenW, 10)];
        self.gayV.backgroundColor =[UIColor groupTableViewBackgroundColor];
        [self addSubview:self.gayV];
        
    }
    return self;
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.headImg]]  forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"963"]];
    self.nameLB.text = model.nickName;
    self.contentLB.attributedText = [model.article.content getMutableAttributeStringWithFont:14 lineSpace:3 textColor:[UIColor blackColor]];
    CGFloat contentH =  [model.article.content getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 20];
    self.contentLB.mj_h = contentH;
    
    self.timeLB.text = model.article.timeNow;
    self.timeLB.mj_y = CGRectGetMaxY(self.contentLB.frame) + 10;
    
    [self setPicWithideos:nil andPictArr:model.article.pictures];
    [self setVideosWithArr:model.article.videos];
    [self setGoodsListwitArr:model.article.goodsList];
    
    self.lineV.mj_y = CGRectGetMaxY(self.viewThree.frame) + 10;
    
    self.viewFour.mj_y = CGRectGetMaxY(self.lineV.frame);
    [self setZanPinViewWithArr:model.goodList];
    self.gayV.mj_y = CGRectGetMaxY(self.viewFour.frame);
    self.headHeight = CGRectGetMaxY(self.gayV.frame);
    
    if (model.article.isGood) {
        [self.zanBt setImage:[UIImage imageNamed:@"17"] forState:UIControlStateNormal];
    }else {
        [self.zanBt setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    }
    
    if (model.article.isCollect) {
        [self.collectBt setImage:[UIImage imageNamed:@"xing1"] forState:UIControlStateNormal];
    }else {
        [self.collectBt setImage:[UIImage imageNamed:@"xing2"] forState:UIControlStateNormal];
    }
}
//设置点赞view

- (void)setZanPinViewWithArr:(NSArray<QYZJFindModel *>*)goodarr {
    
    [self.viewFour.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.zanBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 45 - 45, 15, 30, 30)];
    [self.zanBt setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    self.zanBt.tag = 11;
    [self.viewFour addSubview:self.zanBt];
    [self.zanBt addTarget:self action:@selector(zanOrCollAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.collectBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW  - 45, 15, 30, 30)];
    [self.collectBt setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    self.collectBt.tag = 22;
    [self.viewFour addSubview:self.collectBt];
    [self.collectBt addTarget:self action:@selector(zanOrCollAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray<QYZJFindModel *> *arr = @[];
    if (goodarr.count > 4) {
        arr = [goodarr subarrayWithRange:NSMakeRange(0, 4)];
    }else {
        arr = goodarr;
    }
    CGFloat ww = 30;
    CGFloat space = 5;
    for (int i = 0 ; i < arr.count; i++) {
        
        UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake((space+ww)*i, 15, 30, 30)];
        imgV.layer.cornerRadius = 15;
        imgV.clipsToBounds = YES;
        [imgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:arr[i].headerPic]]  placeholderImage:[UIImage imageNamed:@"963"]];
        [self.viewFour addSubview:imgV];
    }
    
    
    UILabel * titleLB = [[UILabel alloc] initWithFrame:CGRectMake((ww + space) * arr.count + 10, 15, 180, 30)];
    titleLB.font = kFont(13);
    titleLB.textColor = CharacterBlack112;
    titleLB.text = [NSString stringWithFormat:@"已有%ld人为他点赞",self.model.goodNum];
    [self.viewFour addSubview:titleLB];
    
    
    
    
}

- (void)zanOrCollAction:(UIButton *)button {
    if (self.buttonSubject != nil) {
        [self.buttonSubject sendNext:@(button.tag)];
    }
    
    
}


//设置商品
- (void)setGoodsListwitArr:(NSMutableArray<QYZJFindModel *>*)goodArr {
    [self.viewThree.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (goodArr.count == 0) {
        
        self.viewThree.mj_y = CGRectGetMaxY(self.viewTwo.frame);
        self.viewThree.mj_h = 0;
        
    }else {
        CGFloat hh = 70;
        CGFloat space = 10;
        CGFloat totalH = (space + hh) * goodArr.count;
    
        self.viewThree.mj_y = CGRectGetMaxY(self.viewTwo.frame) + 10;
        self.viewThree.mj_h = totalH;
        
        for (int i = 0 ; i < goodArr.count; i++) {
            UIButton * googBt = [[UIButton alloc] initWithFrame:CGRectMake(0, space+hh*i, ScreenW - 20, hh)];
            googBt.layer.cornerRadius = 5;
            googBt.clipsToBounds = YES;
            googBt.backgroundColor = [UIColor groupTableViewBackgroundColor];
            googBt.tag = i+100;
            [googBt addTarget:self action:@selector(goodBtAction:) forControlEvents:UIControlEventTouchUpInside];
            UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
            imgV.layer.cornerRadius = 5;
            imgV.clipsToBounds = YES;
            [imgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:goodArr[i].pic]]  placeholderImage:[UIImage imageNamed:@"789"]];
            [googBt addSubview:imgV];
            
            UILabel * titleLB = [[UILabel alloc] initWithFrame:CGRectMake(70 , 10,  ScreenW - 20 -80, 20)];
            titleLB.font = kFont(13);
            titleLB.text =goodArr[i].name;
            [googBt addSubview:titleLB];
            
            UILabel * moneyLB = [[UILabel alloc] initWithFrame:CGRectMake(70 , 10+27,  ScreenW - 20 - 80, 20)];
            moneyLB.font = kFont(13);
            moneyLB.textColor = OrangeColor;
            moneyLB.text =[NSString stringWithFormat:@"￥%0.2f",goodArr[i].price];
            [googBt addSubview:moneyLB];
            
            [self.viewThree addSubview:googBt];
        }
        
        
        
    }
}

#pragma makr ------------- 点击商店  -------------
- (void)goodBtAction:(UIButton *)button {
    
}


//设置图片
- (void)setPicWithideos:(NSArray *)videArr andPictArr:(NSArray *)pictArr {
    [self.ViewOne.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat ww = (ScreenW - 40)/3;
    CGFloat hh = ww * 3/4;
    CGFloat space = 10;
    NSMutableArray * arr = @[].mutableCopy;
    //    if (videArr.count > 0) {
    //        for (NSString *str in videArr) {
    //            [arr addObject:[PublicFuntionTool firstFrameWithVideoURL:[NSURL URLWithString:str] size:CGSizeMake(ww, hh)]];
    //        }
    //    }
    if (pictArr.count>0) {
        [arr addObjectsFromArray:pictArr];
    }
    if (arr.count==0) {
        self.ViewOne.mj_y = CGRectGetMaxY(self.contentLB.frame);
        self.ViewOne.mj_h = 0;
    }else {
        
        NSInteger number = arr.count / 3 + (arr.count % 3>0?1:0);
        CGFloat imgH = number * (hh + 10);
        self.ViewOne.mj_y = CGRectGetMaxY(self.contentLB.frame) + 10;
        self.ViewOne.mj_h = imgH;
        for (int i = 0; i<arr.count; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ww + 10)* (i%3), space +( hh + space) * (i/3), ww, hh)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i+100;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInView:)];
            tap.cancelsTouchesInView = YES;//设置成N O表示当前控件响应后会传播到其他控件上，默认为YES
            [imageView addGestureRecognizer:tap];
            [self.ViewOne addSubview:imageView];
            //无视频
            [imageView sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:arr[i]]]  placeholderImage:[UIImage imageNamed:@"789"]];
        }
        
        
    }
}

//设置视频
- (void)setVideosWithArr:(NSArray *)videArr {
    [self.viewTwo.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat ww = (ScreenW - 20);
    CGFloat hh = ww * 9/16;
    CGFloat space = 10;
    NSMutableArray * arr = @[].mutableCopy;
    if (videArr.count > 0) {
        for (NSString *str in videArr) {
            [arr addObject:[PublicFuntionTool firstFrameWithVideoURL:[NSURL URLWithString:str] size:CGSizeMake(ww, hh)]];
        }
    }
    
    if (arr.count==0) {
        self.viewTwo.mj_y = CGRectGetMaxY(self.ViewOne.frame);
        self.viewTwo.mj_h = 0;
    }else {
        
        NSInteger number = arr.count / 3 + (arr.count % 3>0?1:0);
        CGFloat imgH = number * (hh + 10);
        self.viewTwo.mj_y = CGRectGetMaxY(self.ViewOne.frame) + 10;
        self.viewTwo.mj_h = imgH;
        
        for (int i = 0; i<arr.count; i++) {
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ww + 10)* (i%3), space +( hh + space) * (i/3), ww, hh)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i+100;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVideosInView:)];
            tap.cancelsTouchesInView = YES;//设置成N O表示当前控件响应后会传播到其他控件上，默认为YES
            [imageView addGestureRecognizer:tap];
            [self.viewTwo addSubview:imageView];
            //有视频
            imageView.image = arr[i];
            UIButton * button = [[UIButton alloc]init];
            button.frame = CGRectMake(ww/2 - 25, hh/2-25, 50, 50);
            [button setBackgroundImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
            [imageView addSubview:button];
            button.alpha = 0.8;
            button.userInteractionEnabled = NO;
            
        }
        
        
        
        
    }
    
    
}




//点击图片
- (void)tapInView:(UITapGestureRecognizer *)tap {
    UIImageView * imgV = (UIImageView *)tap.view;
    NSInteger tag = imgV.tag - 100;
    //无视频
    NSArray * arr = self.model.article.pictures;
    NSMutableArray * picArr = @[].mutableCopy;
    for (NSString * str  in arr) {
        [picArr addObject:[NSString stringWithFormat:@"%@",str]];
    }
    [[zkPhotoShowVC alloc] initWithArray:picArr index:tag];
}
//点击视频
- (void)tapVideosInView:(UITapGestureRecognizer *)tap {
    UIImageView * imgV = (UIImageView *)tap.view;
    NSInteger tag = imgV.tag - 100;
    //视频
    [PublicFuntionTool presentVideoVCWithNSString:[QYZJURLDefineTool getVideoURLWithStr:self.model.article.videos[tag]] isBenDiPath:NO];
}



@end
