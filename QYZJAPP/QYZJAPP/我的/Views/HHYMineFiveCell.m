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

- (void)setModel:(QYZJUserModel *)model {
    _model = model;
    
    CGFloat uu = 10000.0;
    
    if (model.question_num > uu) {
        self.friendsLB.text = [NSString stringWithFormat:@"%0.2f万",model.question_num/uu];
    }else {
        self.friendsLB.text = [NSString stringWithFormat:@"%ld",model.question_num];
    }
    
     if (model.follow_num > uu) {
          self.subscribeLB.text = [NSString stringWithFormat:@"%0.2f万",model.follow_num/uu];
      }else {
          self.subscribeLB.text = [NSString stringWithFormat:@"%ld",model.follow_num];
      }
    

    
}


@end
