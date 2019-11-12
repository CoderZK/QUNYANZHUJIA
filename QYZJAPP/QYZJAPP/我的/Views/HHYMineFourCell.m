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
    
    
    if (model.fans_num > uu) {
          self.fansLB.text = [NSString stringWithFormat:@"%0.2f万",model.fans_num/uu];
      }else {
          self.fansLB.text = [NSString stringWithFormat:@"%ld",model.fans_num];
      }
    
    if (model.goods_num > uu) {
          self.flowerLB.text = [NSString stringWithFormat:@"%0.2f万",model.goods_num/uu];
      }else {
          self.flowerLB.text = [NSString stringWithFormat:@"%ld",model.goods_num];
      }
    
}


@end
