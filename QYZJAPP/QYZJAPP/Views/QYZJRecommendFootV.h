//
//  QYZJRecommendFootV.h
//  QYZJAPP
//
//  Created by zk on 2019/11/19.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJRecommendFootV : UIView
@property(nonatomic,copy)void(^clickRecommendFootVBlock)(void);
@property(nonatomic,strong)NSString *phoneStr;
@property(nonatomic,strong)NSString *codeStr;
@end

NS_ASSUME_NONNULL_END
