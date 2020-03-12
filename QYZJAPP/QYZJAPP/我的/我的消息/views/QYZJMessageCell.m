//
//  QYZJMessageCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMessageCell.h"
@interface QYZJMessageCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberCons;

@end


@implementation QYZJMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.numberLB.layer.cornerRadius = 10;
    self.numberLB.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNumberStr:(NSString *)numberStr {
    _numberStr = numberStr;
    self.numberLB.text = numberStr;
    if ([numberStr integerValue] == 0) {
        self.numberLB.hidden = YES;
    }else {
        self.numberLB.hidden = NO;
        CGFloat w = [numberStr getWidhtWithFontSize:13] + 10;
        if (w<20) {
            w = 20;
        }
        self.numberCons.constant = w;
    }
   
}

@end
