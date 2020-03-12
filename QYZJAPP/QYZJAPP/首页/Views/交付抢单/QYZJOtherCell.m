//
//  QYZJOtherCell.m
//  QYZJAPP
//
//  Created by zk on 2019/12/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJOtherCell.h"

@implementation QYZJOtherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgV.layer.cornerRadius = 15;
    self.imgV.clipsToBounds = YES;
    self.blackV.layer.cornerRadius = 4;
    self.blackV.clipsToBounds = YES;
    self.whiteV.backgroundColor = WhiteColor;
    self.whiteV.layer.shadowColor = OrangeColor.CGColor;
    self.whiteV.layer.shadowOpacity = 0.8;
    self.whiteV.layer.shadowRadius = 10;
    self.whiteV.layer.cornerRadius = 15;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
