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
- (void)setIsShenHe:(NSInteger)isShenHe {
    _isShenHe = isShenHe;
}
- (void)setDataArray:(NSArray<QYZJFindModel *> *)dataArray {
    _dataArray = dataArray;
    
    if (dataArray.count == 0) {
        return;
    }
    
    QYZJFindModel * modelLeft = dataArray[0];
    QYZJFindModel * modelRight = nil;
    if (dataArray.count == 2) {
        modelRight = dataArray[1];

        NSString * rightStr = @"";
        if (modelRight.pic.length > 0) {
           rightStr = [[modelRight.pic componentsSeparatedByString:@","] firstObject];
        }
        [self.rightImgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:rightStr]] placeholderImage:[UIImage imageNamed:@"789"]];
        self.rightTitleLB.text = modelRight.name;
        self.rightMoneyLB.text = [NSString stringWithFormat:@"￥%0.2f",modelRight.price];
        self.rightImgV.hidden = self.rightEdibtBt.hidden = self.rightMoneyLB.hidden = self.rightTitleLB.hidden = self.rightBt.hidden = NO;
        if (self.isShenHe){
            self.rightEdibtBt.hidden = YES;
        }
    }else {
    
      self.rightImgV.hidden = self.rightEdibtBt.hidden = self.rightMoneyLB.hidden = self.rightTitleLB.hidden = self.rightBt.hidden = YES;
    }
    NSString * leftStr = @"";
    if (modelLeft.pic.length > 0) {
       leftStr = [[modelLeft.pic componentsSeparatedByString:@","] firstObject];
    }
    
     self.leftEditBt.hidden = self.isShenHe;
     [self.leftImgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:leftStr]] placeholderImage:[UIImage imageNamed:@"789"]];
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
