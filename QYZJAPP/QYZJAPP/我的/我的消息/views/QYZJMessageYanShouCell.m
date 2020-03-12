//
//  QYZJMessageYanShouCell.m
//  QYZJAPP
//
//  Created by zk on 2019/12/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMessageYanShouCell.h"

@implementation QYZJMessageYanShouCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.whiteV.backgroundColor = [UIColor whiteColor];
    self.whiteV.layer.shadowOpacity = 4;
    self.whiteV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.whiteV.layer.shadowOpacity = 0.2;
    self.whiteV.layer.shadowOffset = CGSizeMake(0, 3);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
