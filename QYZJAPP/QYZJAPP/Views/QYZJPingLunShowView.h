//
//  QYZJPingLunShowView.h
//  QYZJAPP
//
//  Created by zk on 2019/12/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJPingLunShowView : UIView
- (void)show;
- (void)diss;
@property(nonatomic,copy)void(^sendPingLunBlock)(NSString * message);
@end

NS_ASSUME_NONNULL_END
