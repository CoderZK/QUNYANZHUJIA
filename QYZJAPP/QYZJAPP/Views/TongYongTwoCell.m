//
//  TongYongTwoCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "TongYongTwoCell.h"

@implementation TongYongTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.leftLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 80, 20)];
        self.leftLB.font = kFont(15);
        self.leftLB.textColor = CharacterBlackColor;
        [self addSubview:self.leftLB];
        
        self.TF = [[UITextField alloc] initWithFrame:CGRectMake(100 , 10, ScreenW - 120 - 30, 30)];
        self.TF.textAlignment = NSTextAlignmentLeft;
        self.TF.placeholder = @"请填写或选择";
        self.TF.textColor = CharacterBlack112;
        self.TF.font = kFont(14);
        [self addSubview:self.TF];
//        self.TF.userInteractionEnabled = NO;
        
        self.moreImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 35, 15, 20, 20)];
        [self addSubview:self.moreImgV];
        self.moreImgV.image = [UIImage imageNamed:@"more"];
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 49.4, ScreenW-30, 0.6)];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
        self.lineV = backV;
        
        self.swith = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenW - 75  , 10, 60, 30)];
        [self addSubview:self.swith];
        self.swith.hidden = YES;
        self.swith.on = YES;
        [self.swith setOnTintColor:OrangeColor];
        
        self.rightLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 60, 15, 50, 20)];
        self.rightLB.font = kFont(14);
        self.rightLB.hidden = YES;
        self.rightLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.rightLB];
        
        NSString * ss = @"小燕子是北京久久安居网路科技有限公司群燕筑家项目官网方客服，工作宗旨是\"服务好平台每位用户\"。\n   1、负责群燕筑家项目介绍，推广 ；\  n2、负责群燕筑家用户相关使用指导，包括但不限于（注册、入住、抢单、放单等）；\n   3、负责跟进解决用户纠纷投诉等问题。";
        
        

    }
    return self;
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
