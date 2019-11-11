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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
