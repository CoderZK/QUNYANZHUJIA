//
//  QYZJNoDataView.h
//  QYZJAPP
//
//  Created by zk on 2019/11/1.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJNoDataView : UIView
+ (void)show;
+ (void)diss;
+ (void)showWithSizeY:(CGFloat)Y title:(NSString *)titleStr;

@end

NS_ASSUME_NONNULL_END
