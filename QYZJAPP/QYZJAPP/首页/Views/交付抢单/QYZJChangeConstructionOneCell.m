//
//  QYZJChangeConstructionOneCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJChangeConstructionOneCell.h"

@interface QYZJChangeConstructionOneCell()
@property(nonatomic,strong)UIView *whiteV;
@end

@implementation QYZJChangeConstructionOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 20, 20)];
        [self addSubview:self.whiteV];;
        
        
    }
    return self;
}

- (void)setDataArray:(NSMutableArray<QYZJWorkModel *> *)dataArray {
    _dataArray = dataArray;
    
    [self formTable];
    
}

- (void)formTable {
    
    [self.whiteV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat ww = (ScreenW - 25)/4;
    CGFloat hh = 41;
    CGFloat space = 1;
    CGFloat tw = ScreenW - 22;
    CGFloat th = (self.dataArray.count+1) * (hh) + 1;
    self.whiteV.mj_h = th;
    
    for (int i = 0 ; i < 5; i++) {
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
            
            UIButton * statusBt = [[UIButton alloc] initWithFrame:CGRectMake(4*space + 3*ww , CGRectGetMaxY(Hline.frame), ww, hh-1)];
            statusBt.titleLabel.font = kFont(14);
            
            leftLB.textAlignment = centerLB.textAlignment = rightLB.textAlignment = NSTextAlignmentCenter;
            
            [self.whiteV addSubview:leftLB];
            [self.whiteV addSubview:centerLB];
            [self.whiteV addSubview:rightLB];
            [self.whiteV addSubview:statusBt];
            
            if (i== 0) {
                leftLB.text = @"施工阶段名称";
                leftLB.textColor = centerLB.textColor = rightLB.textColor = CharacterBlack112;
                centerLB.text = @"施工阶段付款金额";
                rightLB.text = @"施工阶段工期";
                [statusBt setTitle:@"状态" forState:UIControlStateNormal];
                [statusBt setTitleColor:CharacterBlack112 forState:UIControlStateNormal];
            }else {
                QYZJWorkModel * model = self.dataArray[i-1];
                leftLB.text = model.stageName;
                centerLB.text = [NSString stringWithFormat:@"￥%0.0f",model.price];
                rightLB.text = [NSString stringWithFormat:@"%@ - %@",[NSString stringWithDatemmdd:model.timeStart withIsDian:YES],[NSString stringWithDatemmdd:model.timeEnd withIsDian:YES]];
                statusBt.mj_w = ww - 18;
                statusBt.mj_h = 26;
                statusBt.mj_x = 4*space + 3*ww + 9;
                statusBt.mj_y = CGRectGetMaxY(Hline.frame) + 7;;
                [statusBt setTitleColor:OrangeColor forState:UIControlStateNormal];
                statusBt.tag = i+99;
                [statusBt addTarget:self action:@selector(clickStatusAction:) forControlEvents:UIControlEventTouchUpInside];
                NSInteger status = [model.status integerValue];
                
                if (self.is_service) {
                    //客户
                    if (status == 1) {
                        [statusBt setTitle:@"审核" forState:UIControlStateNormal];
                        [statusBt setTitleColor:OrangeColor forState:UIControlStateNormal];
                        statusBt.layer.cornerRadius = 3;
                        statusBt.layer.borderWidth = 1;
                        statusBt.layer.borderColor = OrangeColor.CGColor;
                        statusBt.userInteractionEnabled = YES;
                    }else if (status == 2) {
                        [statusBt setTitle:@"支付" forState:UIControlStateNormal];
                        [statusBt setTitleColor:OrangeColor forState:UIControlStateNormal];
                        statusBt.layer.cornerRadius = 3;
                        statusBt.layer.borderWidth = 1;
                        statusBt.layer.borderColor = OrangeColor.CGColor;
                        statusBt.userInteractionEnabled = YES;
                    }else if (status == 3) {
                        [statusBt setTitle:@"已支付" forState:UIControlStateNormal];
                        [statusBt setTitleColor:CharacterBlack112 forState:UIControlStateNormal];
//                        statusBt.layer.cornerRadius = 3;
//                        statusBt.layer.borderWidth = 0.8;
//                        statusBt.layer.borderColor = OrangeColor.CGColor;
                        statusBt.userInteractionEnabled = NO;
                    }else if (status == 4) {
                          [statusBt setTitle:@"未通过" forState:UIControlStateNormal];
                          [statusBt setTitleColor:CharacterBlack112 forState:UIControlStateNormal];
                          statusBt.userInteractionEnabled = NO;
                    }
                    
                    
                }else {
                    //服务方
                    [statusBt setTitleColor:CharacterBlack112 forState:UIControlStateNormal];
                    statusBt.userInteractionEnabled = NO;
                    if (status == 1) {
                          [statusBt setTitle:@"待确认" forState:UIControlStateNormal];
                         
                    }else if (status == 2) {
                          [statusBt setTitle:@"待支付" forState:UIControlStateNormal];
                         
                    }else if (status == 3) {
                          [statusBt setTitle:@"已支付" forState:UIControlStateNormal];
                         
                    }else if (status == 4) {
                          [statusBt setTitle:@"未通过" forState:UIControlStateNormal];
                         
                    }
                    
                }
            }
        }
        
        
        
        
    }
    
    
    
}

- (void)clickStatusAction:(UIButton *)button {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickQYZJChangeConstructionOneCell:withIndex:)]) {
        [self.delegate didClickQYZJChangeConstructionOneCell:self withIndex:button.tag - 100];
    }
}


- (void)setIs_service:(BOOL)is_service {
    _is_service = is_service;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
