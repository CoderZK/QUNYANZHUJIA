//
//  QYZJSettingCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJSettingCell.h"

@implementation QYZJSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.switchBt.hidden = YES;
    self.switchBt.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
