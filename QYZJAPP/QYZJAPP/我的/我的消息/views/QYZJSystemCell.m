//
//  QYZJSystemCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJSystemCell.h"

@implementation QYZJSystemCell

- (void)awakeFromNib {
    [super awakeFromNib];
       self.whiteV.layer.shadowColor = [UIColor blackColor].CGColor;
       // 设置阴影偏移量
        self.whiteV.layer.shadowOffset = CGSizeMake(0,0);
       // 设置阴影透明度
        self.whiteV.layer.shadowOpacity = 0.2;
       // 设置阴影半径
        self.whiteV.layer.shadowRadius = 3;
        self.whiteV.clipsToBounds = NO;
    self.backgroundColor = [UIColor clearColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 40, 60)];
    [self.whiteVTwo addSubview:self.scrollView];
    
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    self.titleLB.text = model.title;
    self.contentLB.text = model.content;
    self.timeLB.text = model.addTime;
    
    if (model.isRead) {
        self.statusLB.text = @"已读";
        self.statusLB.textColor = OrangeColor;
    }else {
        self.statusLB.text = @"未读";
        self.statusLB.textColor = CharacterColor80;
    }
    
    
    if (model.pic.length > 0) {
        self.picCons.constant = 60;
        self.picHcons.constant = 10;
    }else {
        self.picCons.constant = 0;
        self.whiteVTwo.clipsToBounds = YES;
        self.picHcons.constant = 0;
        
    }

    [self setPicArr:[model.pic componentsSeparatedByString:@","]];
}

- (void)setPicArr:(NSArray *)picsArr {
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat ww = 60;
    CGFloat space = 10;
    
    self.scrollView.contentSize = CGSizeMake((picsArr.count ) * (ww+space), ww+10);
    for (int i = 0 ; i < picsArr.count; i++) {
        
        UIButton * anNiuBt = [[UIButton alloc] initWithFrame:CGRectMake((ww +  space) * i , 0, ww, ww)];
        anNiuBt.layer.cornerRadius = 3;
        anNiuBt.tag = 100+i;
        anNiuBt.clipsToBounds = YES;
        [anNiuBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:anNiuBt];
        if ([picsArr[i] isKindOfClass:[NSString class]]) {
                [anNiuBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:picsArr[i]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"789"] options:SDWebImageRetryFailed];
        }else {
            [anNiuBt setBackgroundImage:picsArr[i] forState:UIControlStateNormal];
        }
    }
    
    
    
}

- (void)hitAction:(UIButton *)button {
    
  
        [[zkPhotoShowVC alloc] initWithArray:[self.model.pic componentsSeparatedByString:@","] index:button.tag - 100];
        
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
