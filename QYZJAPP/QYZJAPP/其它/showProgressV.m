//
//  showProgressV.m
//  QYZJAPP
//
//  Created by zk on 2019/12/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "showProgressV.h"

@interface showProgressV()
@property(nonatomic,strong)UIProgressView *ProgressV;
@property(nonatomic,strong)UILabel *lb;
@end

@implementation showProgressV

- (instancetype)initWithView:(UIView *)vv{
    
    NSLog(@"currentThread =====%@",[NSThread currentThread]);

    
    self =[super initWithFrame:CGRectMake(0, 0, vv.size.width, vv.size.height)];

        if (self) {
            
            self.ProgressV = [[UIProgressView alloc] initWithFrame:CGRectMake(0, vv.frame.size.height/2 - 5 , vv.frame.size.width - 20, 10)];
            self.ProgressV.progressTintColor = [UIColor colorWithRed:0 green:156/255.0 blue:248/255.0 alpha:1.0];
            self.ProgressV.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self addSubview:self.ProgressV];
            
            self.lb = [[UILabel alloc] initWithFrame:CGRectMake(vv.frame.size.width - 20, vv.frame.size.height/2 - 8, 20, 16)];
            self.lb.textColor = [UIColor blackColor];
            self.lb.textAlignment = NSTextAlignmentCenter;
            self.lb.font = kFont(8);
            [self addSubview:self.lb];
            
            [vv addSubview:self];
        }

    return self;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (progress == 1) {
            [self removeFromSuperview];
        }
        self.lb.text = [NSString stringWithFormat:@"%0.0f%%",progress*100];
        self.ProgressV.progress = progress;
        
    });
    
    
}

- (void)diss {
      dispatch_async(dispatch_get_main_queue(), ^{
          
        [self removeFromSuperview];
       });
}

@end
