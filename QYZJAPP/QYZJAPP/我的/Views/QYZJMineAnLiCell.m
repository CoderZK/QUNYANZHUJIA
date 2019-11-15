//
//  QYZJMineAnLiCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineAnLiCell.h"

@implementation QYZJMineAnLiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"369"]];
    self.titelLB.text = model.title;
    self.contentLB.text = model.context;
    
}

@end
