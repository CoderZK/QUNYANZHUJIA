//
//  HHYMineFiveCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYMineFiveCell.h"

@implementation HHYMineFiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)action:(UIButton *)sender {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickFiveCellWithIndex:)]) {
        
        [self.delegate didClickFiveCellWithIndex:sender.tag];
        
    }
    
}

@end
