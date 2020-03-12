//
//  QYZJPicShowCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/7.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJPicShowCell.h"

@interface QYZJPicShowCell()
@property(nonatomic,strong)UIScrollView *scrollview;
@end


@implementation QYZJPicShowCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
 
         self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10 , ScreenW, (ScreenW - 60)/3)];
         [self addSubview:self.scrollview];
        
        
    }
    return self;
}

- (void)setPicsArr:(NSArray *)picsArr {
    _picsArr = picsArr;
    [self.scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
       for (int i = 0 ; i < picsArr.count; i++) {
           UIButton * anNiuBt = [[UIButton alloc] initWithFrame:CGRectMake(15 +  ((ScreenW - 60) /3 +15 )* i , 0, (ScreenW - 60) /3, (ScreenW - 60) /3)];
           anNiuBt.layer.cornerRadius = 3;
           anNiuBt.tag = 100+i;
           anNiuBt.clipsToBounds = YES;
           if ([picsArr[i] isKindOfClass:[NSString class]]) {
              [anNiuBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:picsArr[i]]]  forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"789"] options:SDWebImageRetryFailed];
           }else {
             [anNiuBt setBackgroundImage:picsArr[i] forState:UIControlStateNormal];
           }
           
           
           [anNiuBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
           [self.scrollview addSubview:anNiuBt];
           
//           UIButton * deleteBt = [[UIButton alloc] initWithFrame:CGRectMake((ScreenW - 60) /3 - 25 , 0, 25, 25)];
//           [deleteBt setImage:[UIImage imageNamed:@"48"] forState:UIControlStateNormal];
//           deleteBt.tag = 200+i;
//           deleteBt.backgroundColor = [UIColor groupTableViewBackgroundColor];
//           [deleteBt setBackgroundImage:picsArr[i] forState:UIControlStateNormal];
//           [deleteBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
//           [anNiuBt addSubview:deleteBt];
           self.scrollview.contentSize = CGSizeMake(15 + (15 + (ScreenW - 60)/3) * picsArr.count, (ScreenW - 60)/3);
       }
           
//       if (picsArr.count < 9) {
//           UIButton * anNiuBt = [[UIButton alloc] initWithFrame:CGRectMake(15 +  ((ScreenW - 60) /3 +15)* picsArr.count , 0, (ScreenW - 60) /3, (ScreenW - 60) /3)];
//           anNiuBt.layer.cornerRadius = 3;
//           anNiuBt.tag = 100+picsArr.count;
//           anNiuBt.clipsToBounds = YES;
//           anNiuBt.backgroundColor = [UIColor groupTableViewBackgroundColor];
//           [anNiuBt setImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];
//           [anNiuBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
//           [self.scrollview addSubview:anNiuBt];
//           self.scrollview.contentSize = CGSizeMake(15 + (15 + (ScreenW - 60)/3) * (picsArr.count + 1), (ScreenW - 60)/3);
//       }else {
//           self.scrollview.contentSize = CGSizeMake(15 + (15 + (ScreenW - 60)/3) * picsArr.count, (ScreenW - 60)/3);
//       }
       
    
}

//点击图片
- (void)hitAction:(UIButton *)anNiuBt {
    [[zkPhotoShowVC alloc] initWithArray:self.picsArr index:anNiuBt.tag - 100];
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
