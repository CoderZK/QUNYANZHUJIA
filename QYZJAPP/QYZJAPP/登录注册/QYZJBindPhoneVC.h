//
//  QYZJBindPhoneVC.h
//  QYZJAPP
//
//  Created by zk on 2019/12/20.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJBindPhoneVC : BaseViewController
@property(nonatomic,copy)void(^dissBlock)(BOOL isShowHome);
@property(nonatomic,strong)NSString *ID;
@end

NS_ASSUME_NONNULL_END
