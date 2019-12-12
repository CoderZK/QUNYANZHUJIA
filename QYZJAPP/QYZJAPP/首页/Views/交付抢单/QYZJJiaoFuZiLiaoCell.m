//
//  QYZJJiaoFuZiLiaoCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/25.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJJiaoFuZiLiaoCell.h"

@interface QYZJJiaoFuZiLiaoCell()
@property(nonatomic,strong)UIView *whiteOneV;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation QYZJJiaoFuZiLiaoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
 
        
        CGFloat ww = 90;
        self.whiteOneV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ww+40)];
        UILabel * lb3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 110)];
        lb3.textColor = CharacterColor180;
        lb3.font = kFont(14);
        lb3.text = @"图片";
        self.leftLB = lb3;
        [self.whiteOneV addSubview:lb3];
        [self addSubview:self.whiteOneV];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 10, ScreenW-110, ww+20)];
        self.scrollView.showsVerticalScrollIndicator = NO;
        [self.whiteOneV addSubview:self.scrollView];

    }
    return self;
}


- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self addPicsWithArr:dataArray];
}

- (void)addPicsWithArr:(NSMutableArray *)picsArr {

    CGFloat space = 20;
    CGFloat ww = 90;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake((picsArr.count + 1) * (ww+space), ww+10);
    for (int i = 0 ; i < picsArr.count + 1; i++) {
        
        UIButton * anNiuBt = [[UIButton alloc] initWithFrame:CGRectMake((ww +  space) * i , 10, ww, ww)];
        anNiuBt.layer.cornerRadius = 3;
        anNiuBt.tag = 100+i;
        anNiuBt.clipsToBounds = YES;
        [anNiuBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:anNiuBt];
        
        if (i == picsArr.count) {
            
            [anNiuBt setBackgroundImage:[UIImage imageNamed:@"tianjia"] forState:UIControlStateNormal];
            
        }else {
            UIButton * deleteBt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(anNiuBt.frame) - 10 ,0 , 20, 20)];
            [deleteBt setImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];
            deleteBt.tag = 100+i;
            [deleteBt addTarget:self action:@selector(deleteHitAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:deleteBt];
             if ([picsArr[i] isKindOfClass:[NSString class]]) {
                            [anNiuBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:picsArr[i]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
                       }else {
                            [anNiuBt setBackgroundImage:picsArr[i] forState:UIControlStateNormal];
                       }
            
        }
        
        
    }
    
    
    
    
}

- (void)deleteHitAction:(UIButton *)button {
 if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didSelectLeftIndex:centerIndex:rightIndex:)]) {
           [self.delegate didClickQYZJJiaoFuZiLiaoCell:self withIndex:button.tag-100 withIsdelect:YES];
       }
}

- (void)hitAction:(UIButton *)button {
    
    if (button.tag == self.dataArray.count + 100) {
        //添加图片

        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickQYZJJiaoFuZiLiaoCell:withIndex:withIsdelect:)]) {
            [self.delegate didClickQYZJJiaoFuZiLiaoCell:self withIndex:button.tag withIsdelect:NO];
        }
     
        
    }else {
        [[zkPhotoShowVC alloc] initWithArray:self.dataArray index:button.tag - 100];
        
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
