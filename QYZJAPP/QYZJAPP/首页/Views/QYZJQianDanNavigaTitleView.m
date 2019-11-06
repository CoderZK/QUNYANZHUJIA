//
//  QYZJQianDanNavigaTitleView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJQianDanNavigaTitleView.h"

@interface QYZJQianDanNavigaTitleView()
@property(nonatomic,strong)UIButton *leftBt,*rightBt;
@end

@implementation QYZJQianDanNavigaTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 3;
        self.layer.borderColor = OrangeColor.CGColor;
        self.layer.borderWidth = 1;
        self.clipsToBounds = YES;
        self.leftBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width / 2, frame.size.height)];
        [self.leftBt setTitle:@"待抢单" forState:UIControlStateNormal];
        self.leftBt.titleLabel.font = kFont(15);
        [self.leftBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.leftBt.backgroundColor = OrangeColor;
        [self addSubview:self.leftBt];
        self.leftBt.tag = 100;
        [self.leftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width / 2, 0, frame.size.width / 2, frame.size.height)];
        [self.rightBt setTitle:@"待抢单" forState:UIControlStateNormal];
        self.rightBt.titleLabel.font = kFont(15);
        [self.rightBt setTitleColor:OrangeColor forState:UIControlStateNormal];
        self.rightBt.backgroundColor = WhiteColor;
        [self addSubview:self.rightBt];
        self.rightBt.tag = 101;
        [self.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    return self;
}

- (void)clickAction:(UIButton *)button {
    
    if (button.tag == 100) {
        [self.rightBt setTitleColor:OrangeColor forState:UIControlStateNormal];
        self.rightBt.backgroundColor = WhiteColor;
        [self.leftBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.leftBt.backgroundColor = OrangeColor;
    }else {
        [self.rightBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.rightBt.backgroundColor = OrangeColor;
        [self.leftBt setTitleColor:OrangeColor forState:UIControlStateNormal];
        self.leftBt.backgroundColor = WhiteColor;
    }
    if (self.navigaBlock != nil) {
        self.navigaBlock(button.tag - 100);
    }
    
    
}

@end
