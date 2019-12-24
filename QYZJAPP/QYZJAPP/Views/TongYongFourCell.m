//
//  TongYongFourCell.m
//  QYZJAPP
//
//  Created by zk on 2019/12/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "TongYongFourCell.h"

@implementation TongYongFourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftLB = [[UILabel alloc] init];
        self.leftLB.font = kFont(15);
        self.leftLB.textColor = CharacterBlackColor;
        [self addSubview:self.leftLB];
        
        [self.leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(10);
            make.width.equalTo(@80);
            
        }];
        
        self.rightLB = [[UILabel alloc] init];
        self.rightLB.font = kFont(14);
        self.rightLB.textColor = CharacterBlack112;
        self.rightLB.numberOfLines = 0;
        [self addSubview:self.rightLB];
        
        [self.rightLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.leftLB.mas_right).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self).offset(15);
            
        }];
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(10, 49.4, ScreenW - 10, 0.6)];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
        self.lineV = backV;
        self.lineV.hidden = YES;
        
        
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
