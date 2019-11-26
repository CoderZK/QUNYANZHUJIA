//
//  QYZJMineShopCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineShopCell.h"

@implementation QYZJMineShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataArray:(NSArray<QYZJFindModel *> *)dataArray {
    _dataArray = dataArray;
    QYZJFindModel * modelLeft = dataArray[0];
    QYZJFindModel * modelRight = nil;
    if (dataArray.count == 2) {
        modelRight = dataArray[1];
        self.rightImgV.hidden = self.rightEdibtBt.hidden = self.rightMoneyLB.hidden = self.rightTitleLB.hidden = NO;
        [self.rightImgV sd_setImageWithURL:[NSURL URLWithString:modelRight.pic] placeholderImage:[UIImage imageNamed:@"369"]];
        self.rightTitleLB.text = modelRight.name;
       
        self.rightMoneyLB.text = [NSString stringWithFormat:@"￥%0.2f",modelRight.price];
    }else {
        self.rightImgV.hidden = self.rightEdibtBt.hidden = self.rightMoneyLB.hidden = self.rightTitleLB.hidden = YES;
    }
     [self.leftImgV sd_setImageWithURL:[NSURL URLWithString:modelLeft.pic] placeholderImage:[UIImage imageNamed:@"369"]];
     self.leftTitleLB.text = modelLeft.name;
    
     self.leftMoneyLB.text = [NSString stringWithFormat:@"￥%0.2f",modelLeft.price];
    
    
}

- (IBAction)click:(UIButton *)sender {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickQYZJMineShopCell:index:isEdit:)]) {
        
        if (sender.tag < 200) {
            [self.delegate didClickQYZJMineShopCell:self index:sender.tag - 100 isEdit: YES];
        }else {
            [self.delegate didClickQYZJMineShopCell:self index:sender.tag - 200 isEdit: NO];
        }
        
        
    }
    
}




@end
