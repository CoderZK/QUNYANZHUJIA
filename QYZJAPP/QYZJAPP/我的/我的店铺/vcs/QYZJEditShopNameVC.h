//
//  QYZJEditShopNameVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJEditShopNameVC : BaseViewController
@property(nonatomic,copy)void(^sendShopNameBlock)(NSString *name);
@end

NS_ASSUME_NONNULL_END
