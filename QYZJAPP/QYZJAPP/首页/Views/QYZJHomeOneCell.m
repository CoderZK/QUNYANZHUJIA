//
//  QYZJHomeOneCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJHomeOneCell.h"

@implementation QYZJHomeOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)action:(UIButton *)sender {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickHomeCellIndex:)]) {
        [self.delegate didClickHomeCellIndex:sender.tag - 100];
    }
    
    
}

@end
