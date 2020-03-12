//
//  QYZJLuYinView.h
//  QYZJAPP
//
//  Created by zk on 2019/11/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJLuYinView : UIView

+ (QYZJLuYinView *)LuYinTool;

- (void)show;
- (void)diss;
@property(nonatomic,copy)void(^statusBlock)(BOOL isStare ,NSData * mediaData);
@end

NS_ASSUME_NONNULL_END
