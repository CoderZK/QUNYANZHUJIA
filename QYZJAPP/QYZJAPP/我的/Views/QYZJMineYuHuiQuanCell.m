//
//  QYZJMineYuHuiQuanCell.m
//  QYZJAPP
//
//  Created by zk on 2019/12/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineYuHuiQuanCell.h"

@implementation QYZJMineYuHuiQuanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CGFloat hh = (ScreenW - 20) * 125/345;
    CGFloat y = hh*4/5.0;
    CAShapeLayer *dotteShapeLayer = [CAShapeLayer layer];

    CGMutablePathRef dotteShapePath =  CGPathCreateMutable();

    //设置虚线颜色为blackColor
    [dotteShapeLayer setStrokeColor:[[UIColor whiteColor] CGColor]];

    //设置虚线宽度
    dotteShapeLayer.lineWidth = 1.5f ;

    //10=线的宽度 5=每条线的间距
    NSArray *dotteShapeArr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:3], nil];

    [dotteShapeLayer setLineDashPattern:dotteShapeArr];

    // 50为虚线Y值，和下面的50一起用。
    // kScreenWidth为虚线宽度
    CGPathMoveToPoint(dotteShapePath, NULL, 15 ,hh-40);

    CGPathAddLineToPoint(dotteShapePath, NULL, ScreenW - 20-30, hh-40);

    [dotteShapeLayer setPath:dotteShapePath];

    CGPathRelease(dotteShapePath);

    //把绘制好的虚线添加上来
    [self.imgV.layer addSublayer:dotteShapeLayer];
    
    
}


- (void)setModel:(QYZJMoneyModel *)model {
    _model = model;
    self.leftTitleLB.text = model.name;
    if (model.isAble) {
        
    }else {
        self.imgV.image = [UIImage imageNamed:@"yhq_3"];
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
