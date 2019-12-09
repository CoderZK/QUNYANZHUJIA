//
//  QYZJQusetionListDetailCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJQusetionListDetailCell.h"

@interface QYZJQusetionListDetailCell()
@property(nonatomic,strong)UIButton *headBt;
@property(nonatomic,strong)UILabel *nameLB,*typeLB;


@end

@implementation QYZJQusetionListDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, 45, 45)];
        self.headBt.layer.cornerRadius = 22.5;
        self.headBt.clipsToBounds = YES;
        [self addSubview:self.headBt];
        
        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, 15, 60, 20)];
        self.nameLB.font = kFont(14);
        [self addSubview:self.nameLB];
        
        self.typeLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLB.frame), CGRectGetMinY(self.nameLB.frame), 60, 20)];
        self.typeLB.layer.cornerRadius = 2;
        self.clipsToBounds = YES;
        self.typeLB.font = kFont(14);
        self.typeLB.textColor = OrangeColor;
        self.typeLB.layer.borderColor = OrangeColor.CGColor;
        self.typeLB.layer.borderWidth = 1;
        self.typeLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.typeLB];
        

        
        self.listBt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, CGRectGetMaxY(self.nameLB.frame) + 10, 200, 25)];
        [self.listBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
        [self.listBt setImage:[UIImage imageNamed:@"sy"] forState:UIControlStateNormal];
        [self.listBt setTitle:@"32" forState:UIControlStateNormal];
        self.listBt.titleLabel.font = kFont(14);
        self.listBt.layer.cornerRadius = 12.5;
        self.listBt.clipsToBounds = YES;
        self.listBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.listBt setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
        [self.listBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0,  0)];
        [self addSubview:self.listBt];
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 134.4, ScreenW, 0.6)];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
        

        
    }
    return self;
}


- (void)setModel:(QYZJFindModel *)model {

    self.nameLB.text = model.a_nick_name;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.a_head_img]]  forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.nameLB.mj_w = [self.nameLB.text getWidhtWithFontSize:14];
    self.typeLB.text= model.a_role_name;
    self.typeLB.mj_w = [self.typeLB.text getWidhtWithFontSize:14] + 15;
    self.typeLB.mj_x = CGRectGetMaxX(self.nameLB.frame) + 10;
    if (model.is_pay) {
      [self.listBt setTitle:[NSString stringWithFormat:@"￥%0.2f元旁听",model.sit_price] forState:UIControlStateNormal];
    }else {
      [self.listBt setTitle:@"点击播放" forState:UIControlStateNormal];
    }
    
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
