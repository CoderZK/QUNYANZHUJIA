//
//  QYZJSearchLabelView.h
//  QYZJAPP
//
//  Created by zk on 2019/11/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QYZJSearchLabelViewDelegate <NSObject>
- (void)didClickLabelViewWithIndex:(NSInteger)index;
@end

@interface QYZJSearchLabelView : UIView
@property(nonatomic,strong)NSMutableArray<QYZJTongYongModel *> *dataArray;
@property(nonatomic,copy)void(^clickLabelBlock)(NSInteger index);
@property(nonatomic,assign)id<QYZJSearchLabelViewDelegate>delegate;
@end
