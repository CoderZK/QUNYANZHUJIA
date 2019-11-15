//
//  QYZJFindTouTiaoHeadView.h
//  QYZJAPP
//
//  Created by zk on 2019/11/14.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJFindTouTiaoHeadView : UIView
@property(nonatomic,assign)CGFloat headheight;
@property(nonatomic,strong)QYZJFindModel *model;
@property(nonatomic,copy)void(^webLoadFindBlock)(CGFloat hh);
@end

NS_ASSUME_NONNULL_END
