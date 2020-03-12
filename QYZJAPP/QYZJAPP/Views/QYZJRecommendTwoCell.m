//
//  QYZJRecommendTwoCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/19.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJRecommendTwoCell.h"

@implementation QYZJRecommendTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 80, 20)];
        self.leftLB.font = kFont(15);
        self.leftLB.textColor = CharacterBlackColor;
        self.leftLB.text = @"需求描述";
        [self addSubview:self.leftLB];
        
        self.TV = [[IQTextView alloc] initWithFrame:CGRectMake(95 , 10, ScreenW - 110, 60)];
        self.TV.textAlignment = NSTextAlignmentLeft;
        self.TV.placeholder = @"请输入需求描述";
        self.TV.textColor = CharacterBlackColor;
        self.TV.font = kFont(14);
        [self addSubview:self.TV];
        
        
        
        self.luyinBt = [[UIButton alloc] initWithFrame:CGRectMake(100, 80, 45, 45)];
        [self.luyinBt setBackgroundImage:[UIImage imageNamed:@"luyin"] forState:UIControlStateNormal];
        [self addSubview:self.luyinBt];
        
        self.listBt = [[UIButton alloc] initWithFrame:CGRectMake(155, 90, ScreenW - 155 - 20, 25)];
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
        
        UIView * backV =[[UIView alloc] init];
        backV.backgroundColor = [UIColor clearColor];
        [self addSubview:backV];
        
        [backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@0.6);
        }];
        
        self.lineV = backV;
        
        
        
        
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
