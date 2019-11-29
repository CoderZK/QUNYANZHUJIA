//
//  QYZJFindQuestionListCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFindQuestionListCell.h"

@interface QYZJFindQuestionListCell()
@property(nonatomic,strong)UIButton *headBt,*listBt;
@property(nonatomic,strong)UILabel *titleLB,*nameLB,*typeLB,*numberLB;


@end

@implementation QYZJFindQuestionListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 20, 20)];
        self.titleLB.font = kFont(15);
        [self addSubview:self.titleLB];
        
        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(10, 40, 45, 45)];
        self.headBt.layer.cornerRadius = 22.5;
        self.headBt.clipsToBounds = YES;
        [self addSubview:self.headBt];
        
        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, 52.5, 60, 20)];
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
        
        self.numberLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 100, 50, 90, 20)];
        self.numberLB.textColor = CharacterBlack112;
        self.numberLB.font = kFont(13);
        self.numberLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.numberLB];
        
        self.listBt = [[UIButton alloc] initWithFrame:CGRectMake(10, 95, 200, 25)];
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
        [self.listBt addTarget:self action:@selector(listAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}


- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    self.titleLB.text = model.title;
    self.nameLB.text = model.nickName;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.headImg]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.nameLB.mj_w = [self.nameLB.text getWidhtWithFontSize:14];
    self.typeLB.text= model.roleName;
    self.typeLB.mj_w = [self.typeLB.text getWidhtWithFontSize:14] + 15;
    self.typeLB.mj_x = CGRectGetMaxX(self.nameLB.frame) + 10;
    self.numberLB.text = [NSString stringWithFormat:@"%@人旁听",model.sitOnNum];
    
    [self.listBt setTitle:[NSString stringWithFormat:@"￥%0.2f元旁听",model.sitPrice] forState:UIControlStateNormal];
    
}

- (void)listAction:(UIButton *)button {
    
//    [[PublicFuntionTool shareTool] palyMp3WithNSSting:self.model.mediaUrl isLocality:NO];;
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
