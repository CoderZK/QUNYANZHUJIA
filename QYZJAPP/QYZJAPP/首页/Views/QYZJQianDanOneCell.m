//
//  QYZJQianDanOneCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJQianDanOneCell.h"

@implementation QYZJQianDanOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.qianDanBt.layer.cornerRadius = 32.5;
    self.qianDanBt.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
