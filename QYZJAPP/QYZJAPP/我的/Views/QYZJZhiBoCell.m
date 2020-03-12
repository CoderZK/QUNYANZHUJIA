//
//  QYZJZhiBoCell.m
//  QYZJAPP
//
//  Created by zk on 2019/12/23.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJZhiBoCell.h"

@implementation QYZJZhiBoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataArray:(NSMutableArray<QYZJMoneyModel *> *)dataArray {
    _dataArray = dataArray;
    if (dataArray.count == 0) {
        return;
    }
    if (dataArray.count == 2) {
        self.rightBt.hidden = self.rightLb1.hidden = self.rightLb2.hidden = NO;
        self.rightLb1.text = dataArray[1].name;
        self.rightLb2.text = dataArray[1].time;
        if (dataArray[1].isPlaying) {
            [self.rightBt setTitle:@"正在播放中" forState:UIControlStateNormal];
        }else {
           [self.rightBt setTitle:@"点击播放" forState:UIControlStateNormal];
        }
    }else {
       self.rightBt.hidden = self.rightLb1.hidden = self.rightLb2.hidden = YES;
    }
    
    self.leftLb1.text = dataArray[0].name;
    self.leftLb2.text = dataArray[0].time;
    if (dataArray[0].isPlaying) {
        [self.leftBt setTitle:@"正在播放中" forState:UIControlStateNormal];
    }else {
       [self.leftBt setTitle:@"点击播放" forState:UIControlStateNormal];
    }
    
    
}

@end
