//
//  QYZJMIneTwoCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMIneTwoCell.h"

@implementation QYZJMIneTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addviews];
    }
    return self;
}

- (void)addviews {
    
    CGFloat ww = 80;
    CGFloat space = (ScreenW - 4*ww)/5;
    CGFloat imgW = 35;
    
    for (int i  = 0 ; i < 4; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(space + (space + ww) * i, 10, ww,ww)];
        view.tag = 100+i;
        [self addSubview:view];
        
        UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(ww/2-35/2.0, 5, imgW, imgW)];
        imgV.backgroundColor = [UIColor yellowColor];
        [view addSubview:imgV];
        imgV.tag = 200;
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgV.frame) + 10, ww, 20)];
        lb.tag = 201;
        lb.font = kFont(14);
        [view addSubview:lb];
        lb.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)setImgArr:(NSArray *)imgArr {
    _imgArr = imgArr;
}
- (void)setTitleArr:(NSArray *)titleArr {
    
    _titleArr = titleArr;
    for (int i = 0 ; i<4; i++) {
        UIView * view = [self viewWithTag:100+i];
        UIImageView * imgV = [view viewWithTag:200];
        UILabel * lb = [view viewWithTag:201];
        if (titleArr.count < i+1) {
            view.hidden  = YES;

        }else {
            view.hidden  = NO;
            imgV.image = [UIImage imageNamed:self.imgArr[i]];
            lb.text = titleArr[i];
            
        }
        
        
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
