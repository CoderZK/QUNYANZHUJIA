//
//  QYZJRobOrderDetailCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/20.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJRobOrderDetailCell.h"

@implementation QYZJRobOrderDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.gouTongBt.layer.cornerRadius = 12.5;
    self.gouTongBt.clipsToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
