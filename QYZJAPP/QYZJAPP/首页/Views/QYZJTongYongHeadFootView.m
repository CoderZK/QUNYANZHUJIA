//
//  QYZJTongYongHeadFootView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/7.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJTongYongHeadFootView.h"

@implementation QYZJTongYongHeadFootView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier])
    {
        
        self.leftLB = [[UILabel alloc] init];
        self.leftLB.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:self.leftLB];
        [self.leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.height.equalTo(@20);
            make.width.equalTo(@150);
        }];
        
        self.rightBt = [[UIButton alloc] init];
        [self addSubview:self.rightBt];
        [self.rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.height.equalTo(@30);
            make.width.equalTo(@100);
            make.right.equalTo(self).offset(-10);
        }];
//        self.rightBt.hidden = YES;
        self.rightBt.titleLabel.font = kFont(14);
        
    }
    self.backgroundColor = [UIColor whiteColor];
    
    return self;
}



@end
