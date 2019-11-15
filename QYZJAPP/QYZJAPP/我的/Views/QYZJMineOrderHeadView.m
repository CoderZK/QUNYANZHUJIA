//
//  QYZJMineOrderHeadView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineOrderHeadView.h"

@interface QYZJMineOrderHeadView()
@property(nonatomic,strong)UIView *orangeV;
@end

@implementation QYZJMineOrderHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
 
          [self addButtons];
        
        
    }
    return self;
}

- (UIView *)orangeV {
    if (_orangeV == nil) {
        _orangeV = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 40, 2)];
        _orangeV.backgroundColor = OrangeColor;
        [self addSubview:_orangeV];
    }
    return _orangeV;
}


- (void)addButtons {
    
    NSArray * arr = @[@"广场",@"名家",@"头条",@"旁听"];
    CGFloat width = 60;
    CGFloat space = (ScreenW - 5*width)/6;
    for (int i = 0 ; i<arr.count;i++) {
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake( space + (width+space)*i, 0 , width, 43);
        
        [button setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = 100+i;
        if (i == 0) {
            self.orangeV.centerX = button.centerX;
        }
        [self addSubview:button];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
}

- (void)clickAction:(UIButton *)button {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.orangeV.centerX = button.centerX;
    }];
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(button.tag - 100)];
    }
    
}


@end
