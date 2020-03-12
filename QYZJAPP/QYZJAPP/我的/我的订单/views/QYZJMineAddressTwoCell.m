//
//  QYZJMineAddressTwoCell.m
//  QYZJAPP
//
//  Created by zk on 2019/12/2.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineAddressTwoCell.h"

@implementation QYZJMineAddressTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.deleteBt.layer.cornerRadius = 4;
    self.deleteBt.clipsToBounds = YES;
    self.deleteBt.layer.borderColor = OrangeColor.CGColor;
    self.deleteBt.layer.borderWidth = 1;

    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
