//
//  QYZJFindTwoCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/7.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFindTwoCell.h"

@implementation QYZJFindTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.deleteCollectbT setTitleColor:OrangeColor forState:UIControlStateNormal];
    self.deleteCollectbT.layer.borderWidth = 1;
    self.deleteCollectbT.layer.borderColor = OrangeColor.CGColor;
    self.deleteCollectbT.layer.cornerRadius = 3;
    self.deleteCollectbT.clipsToBounds = YES;
    self.deleteCollectbT.hidden = YES;
    
}

- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 1) {
        self.zanBt.hidden = self.collectBt.hidden = self.pingLunBt.hidden = YES;
        self.deleteCollectbT.hidden = NO;
        self.bottomCons.constant = 14;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)setModel:(QYZJFindModel *)model {
    _model = model;
    self.titleLB.text = model.title;
    self.timeLB.text = model.timeNow;
    [self.zanBt setTitle:model.goodNum forState:UIControlStateNormal];
    if (model.isGood) {
        [self.zanBt setImage:[UIImage imageNamed:@"17"] forState:UIControlStateNormal];
    }else {
        [self.zanBt setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    }
    [self.pingLunBt setTitle:model.commentNum forState:UIControlStateNormal];
    if (model.isConllect) {
        [self.collectBt setImage:[UIImage imageNamed:@"xing1"] forState:UIControlStateNormal];
    }else {
        [self.collectBt setImage:[UIImage imageNamed:@"xing2"] forState:UIControlStateNormal];
    }
    [self.pingLunBt setTitle:model.commentNum forState:UIControlStateNormal];
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.showContent]]  placeholderImage:[UIImage imageNamed:@"369"]];
}

@end
