//
//  QYZJCoachCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJCoachCell.h"

@interface QYZJCoachCell()
@property(nonatomic,strong)UIView *whiteView;
@property(nonatomic,assign)BOOL isShowMore;
@end

@implementation QYZJCoachCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.whiteView = [[UIView alloc] init];
        self.whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.whiteView];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.top.equalTo(self);
        }];
        
        
        
    }
    return self;
}

- (void)setIsSpread:(BOOL)isSpread {
    _isSpread = isSpread;
}

- (void)setIsMore:(BOOL)isMore {
    _isMore = isMore;;
}

- (void)setDataArr:(NSMutableArray<QYZJTongYongModel *> *)dataArr {
    
    _dataArr = dataArr;;
    
    [self.whiteView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.isShowMore = NO;
    CGFloat wh = 80;
    CGFloat spaceX = (ScreenW - 3*wh)/6;
    CGFloat spaceY = 5;
    NSInteger count = 0;
    
    if (self.isMore) {
        if (self.isSpread) {
            count = dataArr.count + 1;
        }else {
            count = 6;
        }
    }else {
        count = self.dataArr.count;;
    }
    
    
    for (int i = 0 ; i < count; i++) {
     
        CoachView * view = [[CoachView alloc] initWithFrame:CGRectMake(spaceX + (2*spaceX + wh) * (i%3), spaceY + (spaceY + wh) * (i/3), wh, wh)];
        
        view.clickBt.tag = i;
        [view.clickBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        if (self.isMore) {
               if (self.isSpread) {
                   if (i== dataArr.count) {
                       view.titleLB.text = @"收起";
                       view.imgV.image = [UIImage imageNamed:@"coach9"];
                   }else {
                       view.titleLB.text = dataArr[i].name;
                       view.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"coach%d",(i%8)+1]];
                   }
                  
               }else {
                  if (i== 5) {
                       view.titleLB.text = @"更多";
                       view.imgV.image = [UIImage imageNamed:@"coach9"];
                   }else {
                       view.titleLB.text = dataArr[i].name;
                       view.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"coach%d",(i%8)+1]];
                       
                   }
               }
           }else {
               view.titleLB.text = dataArr[i].name;
               view.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"referee%d",(i%6)+1]];
           }
        [self.whiteView addSubview:view];
    }
}

- (void)clickAction:(UIButton *)button {
    
    if (self.isMore) {
          if (self.isSpread) {
              if (button.tag < self.dataArr.count) {
                  if (self.sendStatusBlock != nil) {
                      self.sendStatusBlock(YES, YES, NO, button.tag);
                  }
              }else {
                  if (self.sendStatusBlock != nil) {
                        self.sendStatusBlock(YES, NO,YES, button.tag);
                    }
              }
          }else {
              if (button.tag < 5) {
                  if (self.sendStatusBlock != nil) {
                      self.sendStatusBlock(YES, YES, NO,button.tag);
                  }
              }else {
                  if (self.sendStatusBlock != nil) {
                        self.sendStatusBlock(YES, YES,YES, button.tag);
                    }
              }
          }
      }else {
          
          if (self.sendStatusBlock != nil) {
              self.sendStatusBlock(NO, NO, NO,button.tag);
          }
          
      }
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}

@end


@implementation CoachView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        CGFloat ww = frame.size.width;
        CGFloat hh = frame.size.height;
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake((ww -40)/2, (hh -40)/2 - 15, 40, 40)];
        [self addSubview:self.imgV];
//        self.imgV.backgroundColor = [UIColor redColor];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgV.frame)+5, ww, 20)];
        self.titleLB.font = kFont(14);;
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLB];
        
        self.clickBt = [[UIButton alloc] initWithFrame:self.bounds];
        [self addSubview:self.clickBt];
        
        
    }
    return self;
}

@end
