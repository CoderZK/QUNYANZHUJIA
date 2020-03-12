//
//  QYZJHomeTwoCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJHomeTwoCell.h"

@interface QYZJHomeTwoCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *con1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *con2;


@end

@implementation QYZJHomeTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.con1.constant = self.con2.constant = (ScreenW - 50 - (4*45))/3.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)action:(UIButton *)sender {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickHomeTwoCellIndex:)]) {
        [self.delegate didClickHomeTwoCellIndex:sender.tag - 100];
    }
    
    
}

@end
