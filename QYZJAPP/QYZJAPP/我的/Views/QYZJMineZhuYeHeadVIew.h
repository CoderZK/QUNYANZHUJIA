//
//  QYZJMineZhuYeHeadVIew.h
//  QYZJAPP
//
//  Created by zk on 2019/11/22.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineZhuYeHeadVIew : UIView
@property(nonatomic,assign)CGFloat  headHeight;
@property(nonatomic,copy)void(^clickZhuYeHeadBlock)(NSInteger index,UIButton *button);
@property(nonatomic,strong)QYZJUserModel *dataModel;
@end

NS_ASSUME_NONNULL_END
