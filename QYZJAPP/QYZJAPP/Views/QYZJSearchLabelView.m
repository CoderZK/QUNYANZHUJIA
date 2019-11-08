//
//  QYZJSearchLabelView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJSearchLabelView.h"

#pragma mark ----- labelVIew -------



@implementation  QYZJSearchLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {

        self.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void)setDataArray:(NSMutableArray<QYZJTongYongModel *> *)dataArray {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _dataArray = dataArray;
    if (dataArray.count == 0) {
        self.mj_h = 0;
        return;
    }
      CGFloat spaceX  = 10;
      CGFloat spaceY  = 15;
      CGFloat ww = (ScreenW - 30 - 3 * spaceX) / 4;
      CGFloat hh = 35;
      for (int i = 0;i< dataArray.count; i++) {
          UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(15 + (spaceX + ww) * (i%4) , 10 + (spaceY + hh) * (i/4), ww, hh)];
          [button setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
          [button setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateSelected];
          button.tag = i+1000;
          button.titleLabel.font = kFont(14);
          button.layer.cornerRadius = 4;
          button.clipsToBounds = YES;
          [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [button setTitleColor:WhiteColor forState:UIControlStateSelected];
          [button setTitle:dataArray[i].name forState:UIControlStateNormal];
          [self addSubview:button];
          [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
           if (i+1 == dataArray.count) {
             self.mj_h = 20 + button.mj_y + hh;
           }
          if (i == 0){
              button.selected = YES;
          }
      }
}

- (void)selectAction:(UIButton *)button {

    for (int i = 0 ; i < self.dataArray.count; i++) {
        UIButton * bt =(UIButton *)[self viewWithTag:1000+i];
        if (i +1000 == button.tag) {
            bt.selected = YES;
        }else {
            bt.selected = NO;
        }
    }
    if (self.clickLabelBlock != nil) {
        self.clickLabelBlock(button.tag - 1000);
    }
    
//    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickLabelViewWithIndex:)]) {
//        [self.delegate didClickLabelViewWithIndex:button.tag - 1000];
//    }

}

@end
