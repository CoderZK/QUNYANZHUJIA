//
//  QYZJMineHeadView.h
//  QYZJAPP
//
//  Created by zk on 2019/11/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineHeadView : UIView
@property(nonatomic,copy)void(^clickMineHeadBlock)(NSInteger index);
@property(nonatomic,strong)QYZJUserModel *dataModel;
@end

NS_ASSUME_NONNULL_END
