//
//  QYZJHomeFourCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJHomeFourCell.h"

@interface QYZJHomeFourCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UIButton *headBt;

@end

@implementation QYZJHomeFourCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headBt.layer.cornerRadius = 40;
    self.headBt.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickAciton:(UIButton *)button {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickHomeFourCell:index:)]) {
        
        [self.delegate didClickHomeFourCell:self index:button.tag - 100];
        
    }
    
}

@end
