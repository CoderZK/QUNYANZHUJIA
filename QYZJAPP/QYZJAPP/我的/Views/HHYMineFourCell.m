//
//  HHYMineFourCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYMineFourCell.h"

@interface HHYMineFourCell()


@end

@implementation HHYMineFourCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)hitAction:(UIButton *)sender {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickView:withIndex:)]){
        [self.delegate didClickView:self withIndex:sender.tag - 100];
    }
    
}



@end
