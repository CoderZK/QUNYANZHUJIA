//
//  QYZJFindTouTiaoHeadView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/14.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFindTouTiaoHeadView.h"

@interface QYZJFindTouTiaoHeadView()<UIWebViewDelegate>
@property(nonatomic,strong)UILabel *titelLB;
@property(nonatomic,strong)UILabel *timeLB;
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)UIView *whiteV;
@property(nonatomic,strong)UIButton *zanBt,*collectBt;
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation QYZJFindTouTiaoHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.titelLB =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 20, 10)];
        self.titelLB.font = kFont(15);
        self.titelLB.numberOfLines = 0;
        [self addSubview:self.titelLB];
        
        self.timeLB = [[UILabel alloc] init];
        self.timeLB.frame = CGRectMake(10, 30, ScreenW - 20,20);
        self.timeLB.font = kFont(13);
        self.timeLB.textColor = CharacterColor180;
        [self addSubview:self.timeLB];
        
        self.lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, 0.6)];
        self.lineV.backgroundColor = lineBackColor;
        [self addSubview:self.lineV];
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, 51, ScreenW, 50)];
        [self addSubview:self.whiteV];
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, ScreenW, 1)];
        self.webView.delegate = self;
        self.webView.scrollView.scrollEnabled = NO;
        [self addSubview:self.webView];
        
    }
    return self;
}

//web 加载完毕
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    CGFloat documentHeight= [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    self.webView.height = documentHeight + 20;
    self.headheight = CGRectGetMaxY(self.webView.frame);
    if (self.webLoadFindBlock != nil) {
        self.webLoadFindBlock(self.headheight);
    }

}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    
    self.titelLB.attributedText = [model.headlinenews.title getMutableAttributeStringWithFont:15 lineSpace:3 textColor:[UIColor blackColor]];
    self.titelLB.mj_h = [model.headlinenews.title getHeigtWithFontSize:15 lineSpace:3 width:ScreenW - 20];
    
    self.timeLB.mj_y = CGRectGetMaxY(self.titelLB.frame) + 15;
    self.timeLB.text = model.headlinenews.time;
    self.lineV.mj_y = CGRectGetMaxY(self.timeLB.frame)+5;
    
    self.whiteV.mj_y = CGRectGetMaxY(self.lineV.frame);
    
    [self setzanPeople:model.goodList];
    
    self.webView.mj_y = CGRectGetMaxY(self.whiteV.frame)+5;
    [self.webView loadHTMLString:model.headlinenews.content baseURL:nil];

}

- (void)setzanPeople:(NSArray<QYZJFindModel *>*)arr {
    
    [self.whiteV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.zanBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 35-10 - 80, 10, 80, 35)];
    [self.zanBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.zanBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.zanBt setTitle:self.model.goodNum forState:UIControlStateNormal];
    if (self.model.headlinenews.isGood) {
        [self.zanBt setImage:[UIImage imageNamed:@"17"] forState:UIControlStateNormal];
    }else {
          [self.zanBt setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    }
    self.zanBt.tag = 0;
    [self.zanBt addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteV addSubview:self.zanBt];
    
    self.collectBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 45, 10, 35, 35)];
    [self.whiteV addSubview:self.collectBt];
    self.collectBt.tag = 1;
    if (self.model.headlinenews.isConllect) {
        [self.collectBt setImage:[UIImage imageNamed:@"xing1"] forState:UIControlStateNormal];
    }else{
        [self.collectBt setImage:[UIImage imageNamed:@"xing2"] forState:UIControlStateNormal];
    }
    [self.collectBt addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat space = -10;
    CGFloat ww = 35;
    for (int i = 0 ; i < arr.count; i++) {
    
        UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(15 + (ww + space)*i, 10, ww, ww)];
        imgV.layer.cornerRadius = 17.5;
        imgV.layer.borderColor = OrangeColor.CGColor;
        imgV.layer.borderWidth = 3;
        imgV.clipsToBounds = YES;
        [self.whiteV addSubview:imgV];
        [imgV sd_setImageWithURL:[NSURL URLWithString:arr[i].headerPic] placeholderImage:[UIImage imageNamed:@"3690"]];
        
    }
    
    
    
}

- (void)rightAction:(UIButton *)button {
    
}

@end
