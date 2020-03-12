//
//  QYZJConstructionCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJConstructionCell.h"

@interface QYZJConstructionCell()
@property(nonatomic,strong)UILabel *titleLB,*contentLB;
@property(nonatomic,strong)UIView *whiteV;
@end

@implementation QYZJConstructionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenW-20, 20)];
        self.titleLB.numberOfLines = 0;
        [self addSubview:self.titleLB];
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, ScreenW - 20, 20)];
        self.contentLB.numberOfLines = 0;
        [self addSubview:self.contentLB];
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(10, 50, ScreenW - 20, 20)];
        [self addSubview:self.whiteV];;
        
        
    }
    return self;
}


- (void)setModel:(QYZJWorkModel *)model {
    _model = model;
    
    self.titleLB.attributedText = [model.title getMutableAttributeStringWithFont:14 withBlood:YES lineSpace:3 textColor:[UIColor blackColor]];
    self.titleLB.mj_h = [model.title getHeigtWithIsBlodFontSize:14 lineSpace:3 width:ScreenW - 20];
    
    self.contentLB.attributedText = [model.content getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlack112];
    self.contentLB.mj_h = [model.content getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-20];
    self.contentLB.mj_y = CGRectGetMaxY(self.titleLB.frame) + 10;
    self.whiteV.mj_y = CGRectGetMaxY(self.contentLB.frame) + 10;
    [self formTable];
    model.cellHeight = CGRectGetMaxY(self.whiteV.frame) + 10;
    
    
    
}

- (void)formTable {
    
    [self.whiteV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat ww = (ScreenW - 24)/3;
    CGFloat hh = 41;
    CGFloat space = 1;
    CGFloat tw = ScreenW - 22;
    CGFloat th = (self.dataArray.count+1) * (hh) + 1;
    self.whiteV.mj_h = th;
    
    for (int i = 0 ; i < 4; i++) {
        UIView * VLine = [[UIView alloc] initWithFrame:CGRectMake((ww+ space) * i, 0, space, th)];
        VLine.backgroundColor = CharacterColor80;
        [self.whiteV addSubview:VLine];
    }
    
    for (int i = 0 ; i < self.dataArray.count + 2; i++) {
    
        UIView  *Hline = [[UIView alloc] initWithFrame:CGRectMake(space, (hh*i), tw, space)];
        Hline.backgroundColor = CharacterColor80;
        [self.whiteV addSubview:Hline];
        if (i<self.dataArray.count+1) {
            UILabel * leftLB = [[UILabel alloc] initWithFrame:CGRectMake(space , CGRectGetMaxY(Hline.frame), ww, hh-1)];
            leftLB.numberOfLines = 2;
            leftLB.font = kFont(14);
            
            UILabel * centerLB = [[UILabel alloc] initWithFrame:CGRectMake(space+space + ww , CGRectGetMaxY(Hline.frame), ww, hh-1)];
            centerLB.numberOfLines = 2;
            centerLB.font = kFont(14);
            UILabel * rightLB = [[UILabel alloc] initWithFrame:CGRectMake(3*space + 2*ww , CGRectGetMaxY(Hline.frame), ww, hh-1)];
            rightLB.numberOfLines = 2;
            rightLB.font = kFont(14);
            
            leftLB.textAlignment = centerLB.textAlignment = rightLB.textAlignment = NSTextAlignmentCenter;
            
            [self.whiteV addSubview:leftLB];
            [self.whiteV addSubview:centerLB];
            [self.whiteV addSubview:rightLB];
            
            if (i== 0) {
                leftLB.text = @"施工阶段名称";
                leftLB.textColor = centerLB.textColor = rightLB.textColor = CharacterBlack112;
                centerLB.text = @"施工阶段付款金额";
                rightLB.text = @"施工阶段工期";
                
            
            }else {
                QYZJWorkModel * model = self.dataArray[i-1];
                leftLB.text = model.stageName;
                centerLB.text = [NSString stringWithFormat:@"￥%0.0f",model.price];
                rightLB.text = [NSString stringWithFormat:@"%@ - %@",[NSString stringWithDatemmdd:model.timeStart withIsDian:YES],[NSString stringWithDatemmdd:model.timeEnd withIsDian:YES]];;
            }
        }
        
        
        
        
    }
    
    
    
}


- (void)setDataArray:(NSMutableArray<QYZJWorkModel *> *)dataArray {
    _dataArray = dataArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
   
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    
    
}

@end
