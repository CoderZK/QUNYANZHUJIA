//
//  QYZJHomeThreeCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJHomeThreeCell.h"

@implementation QYZJHomeThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imgV.layer.cornerRadius = 5;
    self.imgV.clipsToBounds = YES;
    self.imgV.backgroundColor = [UIColor redColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
