//
//  QYZJShaiXuanView.m
//  QYZJAPP
//
//  Created by zk on 2020/1/15.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "QYZJShaiXuanView.h"


@interface QYZJShaiXuanView()
@property(nonatomic,strong)UIView *whiteV;

@end


@implementation QYZJShaiXuanView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, sstatusHeight + 44 + 120, ScreenW , 225)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        
        NSArray * arr = @[@"可提问",@"可预约",@"提问免费",@"预约免费",@"不限"];
        for (int i = 0 ; i < arr.count; i++) {
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, i*45, ScreenW, 45)];
            [button setTitle:arr[i] forState:UIControlStateNormal];
            [button setTitleColor:CharacterColor80 forState:UIControlStateNormal];
            [button setTitleColor:OrangeColor forState:UIControlStateSelected];
            button.titleLabel.font = kFont(14);
            button.tag = 100+i;
            [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
            [self.whiteV addSubview:button];
            if (i==0) {
                button.selected = YES;
            }
            
        }
        
        self.backgroundColor = [UIColor clearColor];
        
        
         UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(diss)];
         [self addGestureRecognizer:tap];
        
        
        UIButton * bb = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.whiteV.frame), ScreenW, ScreenH - CGRectGetMaxY(self.whiteV.frame))];
        bb.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self addSubview:bb];
        [bb addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    return self;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    for (int i = 0 ; i < 5; i++) {
        UIButton * button = [self.whiteV viewWithTag:i+100];
        if (i == selectIndex){
            button.selected = YES;
        }else {
            button.selected = NO;
        }
    }
    
    
}

- (void)action:(UIButton *)button {
    
    if (self.clickShaiXuanBlock != nil) {
        self.clickShaiXuanBlock(button.tag - 100,YES);
        [self diss];
    }
    
}

- (void)diss{
    
    self.clickShaiXuanBlock(-1,YES);
    [self removeFromSuperview];
    
      
    
}

@end
