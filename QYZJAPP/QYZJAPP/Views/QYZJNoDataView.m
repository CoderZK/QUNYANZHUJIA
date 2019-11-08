//
//  QYZJNoDataView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/1.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJNoDataView.h"


@interface QYZJNoDataView()
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *titleLB;

+  (QYZJNoDataView *)shareInstance;

@end


static QYZJNoDataView * signleV = nil;

@implementation QYZJNoDataView


+ (QYZJNoDataView *)shareInstance {
    

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signleV = [[QYZJNoDataView alloc] initWithFrame:CGRectMake(ScreenW/2 - 150, ScreenH / 2 - 100 , 300, 300)];
//        signleV.backgroundColor = [UIColor clearColor];
    });
    return signleV;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2 - 75, 20, 150, 115)];
        self.imgV.backgroundColor = [UIColor redColor];
        [self addSubview:self.imgV];
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgV.frame)+15, frame.size.width, 20)];
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        self.titleLB.font = kFont(15);
        self.titleLB.text = @"x测试四";
        [self addSubview:self.titleLB];
        
        self.titleLB.textColor= CharacterBlackColor;
        
        
    }
    return self;
}

+ (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:[QYZJNoDataView shareInstance]];
    
}

+ (void)diss{
    [[QYZJNoDataView shareInstance] removeFromSuperview];
}





@end
